# METADATA
# description: Non-query variables must start with an underscore.
package custom.regal.rules.naming["prefix-underscore"]

import future.keywords.contains
import future.keywords.if
import future.keywords.in

import data.regal.result

report contains violation if {
	some rule in input.rules

	rule.head.name != "decision"

	not startswith(rule.head.name, "_")

	violation := result.fail(rego.metadata.chain(), result.location(rule.head))
}
