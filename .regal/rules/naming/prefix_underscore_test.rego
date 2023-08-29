package custom.regal.rules.naming["prefix-underscore_test"]

import future.keywords.contains
import future.keywords.if
import future.keywords.in

import data.custom.regal.rules.naming["prefix-underscore"] as rule
import data.regal.ast
import data.regal.config

test_fail_prefix_underscore if {
	r := rule.report with input as ast.policy(`some_rule := true {
        input.foo
    }
    `)
	res := {{
		"category": "naming",
		"description": "Non-query variables must start with an underscore.",
		"level": "error",
		"location": {
			"col": 1,
			"file": "policy.rego",
			"row": 3,
			"text": "some_rule := true {",
		},
		"title": "prefix-underscore",
	}}
	r == res
}

test_fail_prefix_underscore2 if {
	r := rule.report with input as ast.policy(`_some_rule := true {
        input.foo
    }
    some_other_rule := true {
        input.bar
    }
    `)
	res := {{
		"category": "naming",
		"description": "Non-query variables must start with an underscore.",
		"level": "error",
		"location": {
			"col": 5,
			"file": "policy.rego",
			"row": 6,
			"text": "    some_other_rule := true {",
		},
		"title": "prefix-underscore",
	}}
	r == res
}

test_success_prefix_underscore if {
	r := rule.report with input as ast.policy(`
    decision := {allow: true} {
        input.foo
    }
    _some_other_rule := true {
        input.bar
    }
    `)
	r == set()
}
