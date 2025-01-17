package custom.regal.rules.safety["else-if_test"]

import future.keywords.if

import data.custom.regal.rules.safety["else-if"] as rule
import data.regal.ast
import data.regal.config

test_fail_else_if if {
	r := rule.report with input as ast.policy(`_allow {
        input.x == 5
    }
    else {
        input.bar == 6
    }`)
	res := {{
		"category": "safety",
		"description": "Else keyword only allowed in 'else if' construct",
		"level": "error",
		"location": {"col": 5, "file": "policy.rego", "row": 6, "text": "    else {"},
		"title": "else-if",
	}}
	print("_________")
	print("else_if")
	print(r)
	print(res)
	r == res
}

test_fail_else_if_imported if {
	r := rule.report with input as ast.policy(`import future.keywords.if
    _allow {
        input.x == 5
    }
    else {
        input.bar == 6
    }`)
	res := {{
		"category": "safety",
		"description": "Else keyword only allowed in 'else if' construct",
		"level": "error",
		"location": {"col": 5, "file": "policy.rego", "row": 7, "text": "    else {"},
		"title": "else-if",
	}}
	print("_________")
	print("else_if_imported")
	print(r)
	print(res)
	r == res
}

test_success_else_if if {
	r := rule.report with input as ast.policy(`
    import future.keywords.if
    _allow {
        input.x == 5
    }
    else if {
        input.bar == 6
    }`)
	r == set()
}
