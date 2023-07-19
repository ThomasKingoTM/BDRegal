package custom.regal.rules.missing["deny_test"]

import future.keywords.if

import data.regal.ast
import data.regal.config
import data.custom.regal.rules.missing.deny as rule

test_fail_missing_deny if {
	r := rule.report with input as ast.policy(`
	some_rule := true {
        input.foo
    }`)
	r == {"Missing deny clause"}
}

test_success_deny_present if {
    r := rule.report with input as ast.policy(`
    deny := true {
        input.foo
    }`)
    r == set()
}