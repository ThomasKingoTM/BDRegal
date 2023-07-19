package custom.regal.rules.negation["not-outside-deny_test"]

import future.keywords.if

import data.regal.ast
import data.regal.config
import data.custom.regal.rules.negation["not-outside-deny"] as rule

test_fail_not_outside_deny if {
    r := rule.report with input as ast.policy(`
        allow := true {
            not input.foo
    }`)
    #print(r)
    r == {"Use of 'not' outside deny clause"}
}
    
test_success_not_in_deny if {
    r := rule.report with input as ast.policy(`
        deny := true {
            not input.foo
    }`)
    r == set()
}