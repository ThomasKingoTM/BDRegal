# METADATA
# description: No 'decision' rule present
package custom.regal.rules.missing.decision

import future.keywords.every
import future.keywords.in 
import future.keywords.contains 
import future.keywords.if

import data.regal.result

report contains violation if {
    every rule in input.rules{
        rule.head.name != "decision"
    }
    violation := result.fail(rego.metadata.chain(), result.location(input.rules[0].head))
}
