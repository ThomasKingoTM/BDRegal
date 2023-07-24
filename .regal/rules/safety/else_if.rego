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
    some expr in rule.else


	violation := result.fail(rego.metadata.chain(), result.location(rule.head))
}
