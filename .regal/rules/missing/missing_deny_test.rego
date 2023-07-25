package custom.regal.rules.missing["deny-reasons_test"]

import future.keywords.if

import data.regal.ast
import data.regal.config
import data.custom.regal.rules.missing["deny-reasons"] as rule

test_fail_missing_deny_reasons if {
	r := rule.report with input as ast.policy(
    `some_rule := true {
        input.foo
    }`)
	res := {
        {
            "category": "missing",
            "description": "No 'deny_reasons' rule present",
            "level": "error",
            "location": {"col": 1, "file": "policy.rego", "row": 3, "text": "some_rule := true {"},
            "title": "deny-reasons"
        }
    }
	r == res
}

test_success_deny_reasons_present if {
    r := rule.report with input as ast.policy(`
    deny_reasons := true {
        input.foo
    }`)
    r == set()
}