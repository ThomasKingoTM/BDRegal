package custom.regal.rules.safety["else-if_test"]

import future.keywords.if

import data.regal.ast
import data.regal.config
import data.custom.regal.rules.safety["else-if"] as rule

test_fail_else_if if {
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
            "description": "Else keyword only allowed in 'else if' construct",
            "level": "error",
            "location": {"col": 1, "file": "policy.rego", "row": 3, "text": "else {"},
            "title": "else-if"
        }
    }
    print("r is:")
    print(r)
    print("res is:")
    print(res)
	r == res
}

test_success_else_if if {
    r := rule.report with input as ast.policy(`
    import future.keywords.if
    allow {
        input.x == 5
    }
    else if {
        input.bar == 6
    }`)
    r == set()
}