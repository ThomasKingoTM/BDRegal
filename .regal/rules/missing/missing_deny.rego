# METADATA
# description: No "deny" rule present
package custom.regal.rules.missing.deny

import future.keywords.every
import future.keywords.in 
import future.keywords.contains 
import future.keywords.if

import data.regal.result

report contains violation if {
    every rule in input.rules{
        rule.head.name != "deny"
    }
    violation := "Missing deny clause"
}
