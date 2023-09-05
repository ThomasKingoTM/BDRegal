package custom.regal.rules.obsolete["max-n-lines_test"]

import future.keywords.contains
import future.keywords.if
import future.keywords.in

import data.custom.regal.rules.obsolete["max-n-lines"] as rule
import data.regal.ast
import data.regal.config

test_fail_max_8_lines if {
	r := rule.report with input as ast.policy(`decision := {"allow": true} {
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
		with config.for_rule as {"level": "error", "max-lines": 8}
	res := {{
		"category": "style",
		"description": "Rules must adhere to the maximum number of lines (max-lines) specified in config.yaml.",
		"level": "error",
		"location": {
			"col": 1,
			"file": "policy.rego",
			"row": 3,
			"text": "decision := {\"allow\": true} {",
		},
		"title": "max-n-lines",
	}}
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
		with config.for_rule as {"level": "error", "max-lines": 8}
	r == set()
}
