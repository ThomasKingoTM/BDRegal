# METADATA
# description: No 'deny_reasons' rule present
package custom.regal.rules.missing["deny-reasons"]

import future.keywords.contains
import future.keywords.every
import future.keywords.if
import future.keywords.in

import data.regal.result

report contains violation if {
	every rule in input.rules {
		rule.head.name != "_deny_reasons"
	}
	violation := result.fail(rego.metadata.chain(), result.location(input.rules[0].head))
}
