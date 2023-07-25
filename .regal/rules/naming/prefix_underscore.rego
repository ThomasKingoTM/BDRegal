# METADATA 
# description: Non-query variables must start with an underscore.
package custom.regal.rules.naming["prefix_underscore"]

import future.keywords.in
import future.keywords.if
import future.keywords.contains

import data.regal.result

report contains violation if {
    some name in input.rules.head
    not name in _allowed_names
    not name.startswith("_")
    
    violation := result.fail(regal.metadata.chain(), result.position())
}

_allowed_names := ["decision", "deny_reasons"]