package custom.regal.rules.two_decision_clauses

import future.keywords.if
import future.keywords.in
import future.keywords.contains

import data.regal.ast
import data.regal.config
import custom.regal.rules. as rule

test_fail_ if {
    r := rule.report with input as ast.policy(
    `decision := {"allow": true} {
        input.foo
    }`)
    res := {
        {
            "category": "structure",
            "description": "Exactly two decision rules (1. allow = true, 2. allow = false) should be present in the policy.",
            "level": "error",
            "location": {
                "col": 1,
                "file": "policy.rego",
                "row": 3,
                "text": "decision := {"allow": true} {"
            },
            "title": "two-decision-clauses"
        }
    }
    r == res
}


test_success_ if {
    r := rule.report with input as ast.policy(`
    decision := {allow: true} {
        input.foo
    }
    decision := {allow: false} {
        not input.foo
    }`)
    r == set()
}
