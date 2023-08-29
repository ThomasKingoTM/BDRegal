package custom.regal.rules.comparison["type-comparison-test"]

import future.keywords.if
import future.keywords.in

import data.custom.regal.rules.comparison["type-comparison"] as rule

test_fail_dangerous_type_comparison {
    module := regal.parse_module("example.rego", `
    package policy

    allow := true {"1" > 1}`)

    r := rule.report with input as module

    print(r)

    res := {{
    	"category": "comparison",
    	"description": "Using dangerous built-in type comparison with different types!",
    	"level": "error",
    	"location": {"col": 24, "file": "example.rego", "row": 4, "text": "    allow := true {\"1\" > 1}"},
    	"title": "type-comparison"
    }}
    print(res)
    r == res
}

test_success_dangerous_type_comparison_with_equal_types {
    module := regal.parse_module("example.rego", `
    package policy

    allow := true {"1" > "1"}`)

    r := rule.report with input as module

    res := set()

    r == res
}

test_success_non_dangerous_type_comparison_with_different_types {
    module := regal.parse_module("example.rego", `
    package policy

    allow := true {1 != 2}`)

    r := rule.report with input as module

    res := set()
    r == res
}