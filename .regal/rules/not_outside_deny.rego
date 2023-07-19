# METADATA
# description: Use of 'not' outside deny-clause
package custom.regal.rules.negation["not-outside-deny"]

import future.keywords.contains
import future.keywords.if
import future.keywords.in

import data.regal.result
import data.regal.ast

report contains violation if {
	some rule in input.rules
	some expr in rule.body

	rule.head.name != "deny"
	expr.negated == true

	#print(sprintf("rule.head.name is: %v", [rule.head.name]))
	#print(sprintf("negated is: %v", [expr.negated]))

	violation := "Use of 'not' outside deny clause" 
}
