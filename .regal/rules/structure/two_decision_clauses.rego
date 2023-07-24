# METADATA
# description: Exactly two decision rules (1. allow = true, 2. allow = false) should be present in the policy.
package custom.regal.rules.structure["two-decision-clauses"]

import future.keywords.every
import future.keywords.in 
import future.keywords.contains 
import future.keywords.if

import data.regal.result

report contains violation if {
    some rule in input.rules
    rule.head.name == "decision"
    rule.head.value.value[0].value == "true"

    every rule2 in input.rules {
        rule2.head.name != "decision"
        rule2 != rule
    }
    
    violation := result.fail(rego.metadata.chain(), result.location(rule.head))
}

report contains violation if {
    some rule in input.rules 
    rule.head.name == "decision"
    rule.head.value.value[1].value == "false"
    
    every rule2 in input.rules {
        rule2.head.name != "decision"
        rule2 != rule
    }

    violation := result.fail(rego.metadata.chain(), result.location(rule.head))
}