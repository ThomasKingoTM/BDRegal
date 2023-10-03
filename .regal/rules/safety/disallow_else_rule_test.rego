package custom.regal.rules.safety["disallow-else-rule_test"]

import future.keywords.if

import data.custom.regal.rules.safety["disallow-else-rule"] as rule
import data.regal.ast
import data.regal.config

test_fail_disallow_else_rule if {
	r := rule.report with input as ast.policy(`_allow := true {
        input.x == 5
    }
    else {
        input.bar == 6
    }`)
	res := {{
		"category": "safety",
		"description": "Rule must not be named else",
		"level": "error",
		"location": {"col": 1, "file": "policy.rego", "row": 3, "text": "_allow := true {"},
		"title": "disallow-else-rule",
	}}
    print("_________")
    print("disallow_else_rule")
    print(r)
    print(res)
	r == res
}

test_success_disallow_else_rule if {
	r := rule.report with input as ast.policy(`
    _some_rule := true {
        input.foo
    }
    _some_rule := false {
        not input.foo
    }`)
	r == set()
}
