package custom.regal.rules.missing.decision_test

import future.keywords.if

import data.custom.regal.rules.missing.decision as rule
import data.regal.ast
import data.regal.config

test_fail_missing_decision if {
	r := rule.report with input as ast.policy(`some_rule := true {
        input.foo
    }`)
	res := {{
		"category": "missing",
		"description": "No 'decision' rule present",
		"level": "error",
		"location": {"col": 1, "file": "policy.rego", "row": 3, "text": "some_rule := true {"},
		"title": "decision",
	}}
	r == res
}

test_success_decision_present if {
	r := rule.report with input as ast.policy(`
    decision := true {
        input.foo
    }`)
	r == set()
}
