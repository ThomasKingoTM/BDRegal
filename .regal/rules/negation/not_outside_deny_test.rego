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
    res := {
        {
            "category": "negation",
            "description": "Use of 'not' outside deny-clause",
            "level": "error",
            "location": {"col": 9, "file": "policy.rego", "row": 5, "text": "        not input.foo"},
            "related_resources": [{
                "description": "documentation", 
                "ref": config.docs.resolve_url("$baseUrl/$category/not-outside-deny", "negation"),
            }],
            "title": "not-outside-deny"
        }
    }
    print(r)
    print(res)
	r == res
}
    
test_success_not_in_deny if {
    r := rule.report with input as ast.policy(`
        deny := true {
            not input.foo
    }`)
    r == set()
}