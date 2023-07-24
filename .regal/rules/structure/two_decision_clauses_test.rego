package custom.regal.rules.structure["two-decision-clauses_test"]

import future.keywords.if

import data.regal.ast
import data.regal.config
import data.custom.regal.rules.structure["two-decision-clauses"] as rule

test_fail_two_decision_clauses if {
	r := rule.report with input as ast.policy(
    `decision := {"allow": true} {
        input.foo
    }`)
    res := {
        {
            "category": "structure",
            "description": "Exactly two decision rules (1. allow = true, 2. allow = false) should be present in the policy.",
            "level": "error",
            "location": {"col": 1, "file": "policy.rego", "row": 3, "text": "decision := {allow: true, reason: \"foo\"} {"},
            "title": "two-decision-clauses"
        }
    }
    print(r)
    print(res)
	r == res
}

test_success_two_decision_clauses if {
    r := rule.report with input as ast.policy(`
    decision := {"allow": true} {
        input.foo
    }
    decision := {"allow": false} {
        not input.foo
    }`)
    r == set()
}