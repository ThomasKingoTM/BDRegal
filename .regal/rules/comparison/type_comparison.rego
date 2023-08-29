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
	set_of_dangerous_comparison_operator_unicodes := {"\u003c", "\u003c", "\u003e=", "\u003c="}

	danger_set := set_of_dangerous_comparison_operators | set_of_dangerous_comparison_operator_names | set_of_dangerous_comparison_operator_unicodes
	
	some rule in input.rules
	some body in rule.body 
	some term in body.terms
	some value in term.value
	

	# print(input.rules[0].body[0].terms[0].value[0].value)

	# Dangerous comparison operator
	value.value in danger_set
	
	# Find the type of one side of the operator
	type_one := body.terms[1].type
	# some other_term in body.terms
	# some type_one in other_term 

	# Find the type of the other side of the operator
	type_two := body.terms[2].type
	# some third_term in body.terms
	# some type_two in third_term

	type_one != type_two

	violation := result.fail(rego.metadata.chain(), result.location(value))
}
