# METADATA 
# description: Non-query variables must start with an underscore.
package custom.regal.rules.naming["prefix-underscore"]

import future.keywords.in
import future.keywords.if
import future.keywords.contains

import data.regal.result

report contains violation if {
    some rule in input.rules
    
    not rule.head.name == "decision"
    not rule.head.name == "deny_reasons"
    
    not startswith(rule.head.name, "_")
    
    violation := result.fail(rego.metadata.chain(), result.location(rule.head))
}

_allowed_names = {"decision", "deny_reason"}