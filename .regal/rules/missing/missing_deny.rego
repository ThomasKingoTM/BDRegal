# METADATA
# description: No "deny" rule present
package custom.regal.rules.missing["deny-reasons"]

import future.keywords.every
import future.keywords.in 
import future.keywords.contains 
import future.keywords.if

import data.regal.result

report contains violation if {
    every rule in input.rules{
        rule.head.name != "deny_reasons"
    }
    violation := "Missing deny_reasons clause"
}
