package custom.regal.rules.missing["deny-reasons_test"]

import future.keywords.if

import data.regal.ast
import data.regal.config
import data.custom.regal.rules.missing["deny-reasons"] as rule

test_fail_missing_deny_reasons if {
	r := rule.report with input as ast.policy(`
	some_rule := true {
        input.foo
    }`)
	r == {"Missing deny_reasons clause"}
}

test_success_deny_present if {
    r := rule.report with input as ast.policy(`
    deny_reasons := true {
        input.foo
    }`)
    r == set()
}