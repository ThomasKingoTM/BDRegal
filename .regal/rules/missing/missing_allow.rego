# METADATA
# description: No "allow" rule present
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
    violation := "Missing decision clause"
}
