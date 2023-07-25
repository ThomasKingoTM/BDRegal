# METADATA
# description: Exactly two decision rules (1. allow = true, 2. allow = false) should be present in the policy.
package custom.regal.rules.structure["two-decision-clauses"]

import future.keywords.every
import future.keywords.in 
import future.keywords.contains 
import future.keywords.if

import data.regal.result

report contains violation if {
    # If the policy is missing a "decision := {"allow": true}"
    not _contains_decision_true_clause
    violation := result.fail(rego.metadata.chain(), result.location(input.rules[0].head))
}

report contains violation if {
    # If the policy is missing a "decision := {"allow": false}"
    not _contains_decision_false_clause
    violation := result.fail(rego.metadata.chain(), result.location(input.rules[0].head))
}

report contains violation if {
    # If the policy has more than two "decision := {"allow": true/false}" clauses
    _contains_three_decision_clauses
    violation := result.fail(rego.metadata.chain(), result.location(input.rules[0].head))
}


# Helpers
_contains_decision_true_clause := true {
    some i, line in input.regal.file.lines
    contains(line,("decision := {\"allow\": true"))
}

_contains_decision_false_clause := true {
    some i, line in input.regal.file.lines
    contains(line, ("decision := {\"allow\": false"))
}

_contains_three_decision_clauses := true {
    some i, line in input.regal.file.lines
    some j, line2 in input.regal.file.lines
    some k, line3 in input.regal.file.lines
    i != j
    i != k
    j != k
    contains(line, ("decision := {\"allow\":"))
    contains(line2, ("decision := {\"allow\":"))
    contains(line3, ("decision := {\"allow\":"))
}