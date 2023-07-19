package custom.regal.rules.missing["decision_test"]

import future.keywords.if

import data.regal.ast
import data.regal.config
import data.custom.regal.rules.missing.decision as rule

test_fail_missing_decision if {
	r := rule.report with input as ast.policy(`
	some_rule := true {
        input.foo
    }`)
	r == {"Missing decision clause"}
}

test_success_decision_present if {
    r := rule.report with input as ast.policy(`
    decision := true {
        input.foo
    }`)
    r == set()
}