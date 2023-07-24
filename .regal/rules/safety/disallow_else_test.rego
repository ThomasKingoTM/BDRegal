package custom.regal.rules.safety["disallow-else_test"]

import future.keywords.if

import data.regal.ast
import data.regal.config
import data.custom.regal.rules.safety["disallow-else"] as rule

test_fail_disallow_else if {
	r := rule.report with input as ast.policy(
    `allow {
        input.x == 5
    }
    else {
        input.bar == 6
    }`)
    res := {
        {
            "category": "safety",
            "description": "Else keyword not allowed",
            "level": "error",
            "location": {"col": 1, "file": "policy.rego", "row": 3, "text": "allow {"},
            "title": "disallow-else"
        }
    }
	r == res
}

test_success_disallow_else if {
    r := rule.report with input as ast.policy(`
    some_rule := true {
        input.foo
    }
    some_rule := false {
        not input.foo
    }`)
    r == set()
}