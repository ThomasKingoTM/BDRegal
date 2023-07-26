# METADATA
# description: Use of 'not' outside deny-clause
package custom.regal.rules.negation["not-outside-deny"]

import future.keywords.contains
import future.keywords.if
import future.keywords.in

import data.regal.ast
import data.regal.result

report contains violation if {
	some rule in input.rules
	some expr in rule.body

	rule.head.name != "_deny_reasons"
	expr.negated == true

	violation := result.fail(rego.metadata.chain(), result.location(expr))
}
