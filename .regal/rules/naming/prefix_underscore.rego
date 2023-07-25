# METADATA 
# description: 
package custom.regal.rules.

import future.keywords.in
import future.keywords.if
import future.keywords.contains

import data.regal.result

report contains violation if {
    
    
    
    violation := result.fail(regal.metadata.chain(), result.position())
}