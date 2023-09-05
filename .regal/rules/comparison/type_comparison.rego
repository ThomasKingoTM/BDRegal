# METADATA
# description: Using dangerous built-in type comparison with different types!
# schemas:
# - input: schema.regal.ast
package custom.regal.rules.comparison["type-comparison"]

import future.keywords.contains
import future.keywords.if
import future.keywords.in

import data.regal.result

report contains violation if {
	set_of_dangerous_comparison_operators := {"<", "<=", ">", ">="}
	set_of_dangerous_comparison_operator_names := {"lt", "le", "gt", "ge"}
	set_of_dangerous_comparison_operator_unicodes := {"<", ">=", "<="}

	# regal ignore:line-length
	danger_set := (set_of_dangerous_comparison_operators | set_of_dangerous_comparison_operator_names) | set_of_dangerous_comparison_operator_unicodes

	some rule in input.rules
	some body in rule.body
	some term in body.terms
	some value in term.value

	value.value in danger_set

	violation := result.fail(rego.metadata.chain(), result.location(value))
}
