package custom.regal.rules.safety["disallow-else_test"]

import future.keywords.if

import data.custom.regal.rules.safety["disallow-else"] as rule
import data.regal.ast
import data.regal.config

test_fail_disallow_else if {
	r := rule.report with input as ast.policy(`_allow := true {
        input.x == 5
    }
    else {
        input.bar == 6
    }`)
	res := {{
		"category": "safety",
		"description": "Else keyword not allowed",
		"level": "error",
		"location": {"col": 1, "file": "policy.rego", "row": 3, "text": "_allow := true {"},
		"title": "disallow-else",
	}}
	r == res
}

test_success_disallow_else if {
	r := rule.report with input as ast.policy(`
    _some_rule := true {
        input.foo
    }
    _some_rule := false {
        not input.foo
    }`)
	r == set()
}
