# METADATA
# description: Else keyword only allowed in 'else if' construct
package custom.regal.rules.safety["else-if"]

import future.keywords.contains
import future.keywords.if
import future.keywords.in

import data.regal.result
import data.regal.ast

report contains violation if {
	some rule in input.rules
    some expr in rule["else"]
	
	not _contains_else_if_construct

	not _has_imported_future_keywords_if
	

	violation := result.fail(rego.metadata.chain(), result.location(expr))
}

_contains_else_if_construct := true {
	some i, line in input.regal.file.lines
	"else if" in line 
}

_has_imported_future_keywords_if := true {
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