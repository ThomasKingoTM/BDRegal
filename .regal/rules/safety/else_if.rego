# METADATA
# description: Else keyword only allowed in 'else if' construct
package custom.regal.rules.safety["else-if"]

import future.keywords.contains
import future.keywords.if
import future.keywords.in

import data.regal.ast
import data.regal.result

report contains violation if {
	some rule in input.rules
	some expr in rule["else"]
	exists(expr)

	not _contains_else_if_construct

	not _has_imported_future_keywords_if

	violation := result.fail(rego.metadata.chain(), result.location(expr))
}

# Possibly missing case: Using "else if" but not importing future.keywords.if. (Handled by baseline regal-linter case 'rule_named_if.rego')

# METADATA
# description: Else used outside 'else if' construct
report contains violation if {
	some rule in input.rules
	some expr in rule["else"]
	exists(expr)

	not _contains_else_if_construct

	_has_imported_future_keywords_if

	violation := result.fail(rego.metadata.chain(), result.location(expr))
}

exists(x) if {
	x == x
}

_contains_else_if_construct if {
	some i, line in input.regal.file.lines
	"else if {" == trim_space(line)
}

_has_imported_future_keywords_if if {
	some imported in input.imports
	imported.path.type == "ref"
	count(imported.path.value) == 3
	imported.path.value[0].type == "var"
	imported.path.value[0].value == "future"
	imported.path.value[1].type == "string"
	imported.path.value[1].value == "keywords"
	imported.path.value[2].type == "string"
	imported.path.value[2].value == "if"
}
