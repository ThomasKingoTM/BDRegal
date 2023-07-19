package custom.regal.rules.missing["allow_test"]

import future.keywords.if

import data.regal.ast
import data.regal.config
import data.custom.regal.rules.missing.allow as rule

test_fail_missing_allow if {
	r := rule.report with input as ast.policy(`
	some_rule := true {
        input.foo
    }`)
	r == {"Missing allow clause"}
}

test_success_allow_present if {
    r := rule.report with input as ast.policy(`
    allow := true {
        input.foo
    }`)
    r == set()
}