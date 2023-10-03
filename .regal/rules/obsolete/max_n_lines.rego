# METADATA
# description: Rules must adhere to the maximum number of lines (max-lines) specified in config.yaml.
package custom.regal.rules.obsolete["max-n-lines"]

# import future.keywords.contains
# import future.keywords.every
# import future.keywords.if
# import future.keywords.in

# import data.regal.config
# import data.regal.result

# report contains violation if {
# 	#	not _number_of_lines_is_less_than_specified_in_config

# 	violation := result.fail(rego.metadata.chain(), result.location(input.rules[0].head))
# }

#_object_of_opening_clauses := {index: line |
#	some index, line in input.regal.file.lines
#	is_number(index)
#	contains(line, "{")
#}
#_number_of_lines_is_less_than_specified_in_config if {
#	cfg := config.for_rule(("custom", {"category": "style"}), ("title": "max-n-lines"))
#	every opening_index, _ in _object_of_opening_clauses {
#		some closing_index, closing_clause in input.regal.file.lines
#		contains(closing_clause, "}")
#		is_number(closing_index)
#		closing_index > opening_index
#		closing_index - opening_index < cfg["max-lines"]
#	}
#}
