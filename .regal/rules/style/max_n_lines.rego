# METADATA 
# description: Rules must adhere to the maximum number of lines (max-lines) specified in config.yaml.
package custom.regal.rules.style["max-n-lines"]

import future.keywords.contains
import future.keywords.every
import future.keywords.if
import future.keywords.in

import data.regal.config
import data.regal.result

report contains violation if {
	not _number_of_lines_is_less_than_specified_in_config

	violation := result.fail(rego.metadata.chain(), result.location(input.rules[0].head))
}

_object_of_opening_clauses := {index: line |
	some index, line in input.regal.file.lines
	is_number(index)
	contains(line, "{")
}

_number_of_lines_is_less_than_specified_in_config if {
	cfg := config.for_rule({"custom": {"category": "style"}, "title": "line-max"})
	every opening_index, _ in _object_of_opening_clauses {
		some closing_index, closing_clause in input.regal.file.lines
		contains(closing_clause, "}")
		is_number(closing_index)
		closing_index > opening_index
		closing_index - opening_index < cfg["max-lines"]
	}
}

# some rule in input.rules
# some index in rule.body[_].index
# is_number(index)
# index > 7 
# Make a set with all lines that contain "{"
# For every line in the set, check that there exists SOME line that contains a "}" 
# The difference in index between these lines must be 9 or less
