package custom.regal.rules.style["max-8-lines_test"]

import future.keywords.if
import future.keywords.in
import future.keywords.contains

import data.regal.ast
import data.regal.config
import data.custom.regal.rules.style["max-8-lines"] as rule

test_fail_max_8_lines if {
    r := rule.report with input as ast.policy(
    `decision := {"allow": true} {
        input.foo
        input.foo
        input.foo
        input.foo
        input.foo
        input.foo
        input.foo
        input.foo
        input.foo
    }`)
    res := {
        {
            "category": "style",
            "description": "Rules must be maximum 8 lines in length.",
            "level": "error",
            "location": {
                "col": 1,
                "file": "policy.rego",
                "row": 3,
                "text": "decision := {\"allow\": true} {"
            },
            "title": "max-8-lines"
        }
    }
    r == res
}


test_success_max_8_lines if {
    r := rule.report with input as ast.policy(`
    _some_rule := true {
        input.foo
        input.foo
        input.foo
        input.foo
        input.foo
        input.foo
    }
    _some_other_rule := true {
        input.foo
        input.foo
        input.foo
    }`)
    r == set()
}
