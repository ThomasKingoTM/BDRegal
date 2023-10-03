# METADATA
# description: Rule must not be named else
package custom.regal.rules.safety["disallow-else-rule"]

import future.keywords.contains
import future.keywords.if
import future.keywords.in

import data.regal.result

report contains violation if {
	some rule in input.rules
	some expr in rule["else"]

	violation := result.fail(rego.metadata.chain(), result.location(rule.head))
}
