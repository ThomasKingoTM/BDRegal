package custom.regal.rules.safety["shadow-built-in_test"]

import future.keywords.if

import data.regal.ast
import data.regal.config
import data.custom.regal.rules.safety["shadow-built-in"] as rule

test_fail_shadow_built_in if {
	r := rule.report with input as ast.policy(
    `gt(left, right) := sprintf("values provided: %v, %v", [left, right])`)
    res := {
        {
            "category": "safety",
            "description": "Shadowing built-in functions is not allowed",
            "level": "error",
            "location": {"col": 1, "file": "policy.rego", "row": 3, "text": "gt(left, right) := sprintf(\"values provided: %v, %v\", [left, right])"},
            "related_resources": [{
                "description": "documentation", 
                "ref": config.docs.resolve_url("$baseUrl/$category/decision", "missing"),
            }],
            "title": "decision"
        }
    }
    print("r is:")
    print(r)
    print("res is:")
    print(res)
	r == res
}

test_success_use_built_in if {
    r := rule.report with input as ast.policy(`
    some_rule := true {
        left := input.left 
        right := input.right
        gt(left, right)
    }`)
    r == set()
}