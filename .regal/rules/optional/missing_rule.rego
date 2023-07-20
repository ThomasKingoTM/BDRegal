# METADATA
# description: No rule present
package custom.regal.rules.missing.rule

import future.keywords.every
import future.keywords.in 
import future.keywords.contains 
import future.keywords.if

import data.regal.result

report contains violation if {
    not _rule_exists

    violation := result.fail(rego.metadata.chain(), result.location(input.rules.head))

}

_rule_exists {
    some rule in input.rules{
        rule.head.name != ""
    }
}