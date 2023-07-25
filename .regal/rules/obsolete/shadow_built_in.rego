# METADATA
# description: Shadowing built-in functions is not allowed
package custom.regal.rules.safety["shadow-built-in"]

import future.keywords.contains
import future.keywords.if
import future.keywords.in

import data.regal.result
import data.regal.ast

# THIS ENTIRE POLICY IS REDUNDANT - IT IS ALREADY COVERED BY THE "rule_shadows_builtin" IN /bundle/regal/rules/bugs.
_list_of_globals_opa_0_45 := ["abs", "all", "and", "any", "array", "assign", "bits", "cast_array", "cast_boolean", "cast_null", "cast_object", "cast_set", "cast_string",
                     "ceil", "concat", "contains", "count", "crypto", "data", "div", "endswith", "eq", "equal", "floor", "format_int", "glob", "graph", "graphql",
                     "gt", "gte", "hex", "http", "indexof", "indexof_n", "input", "internal", "intersection", "io", "is_array", "is_boolean", "is_null",
                     "is_number", "is_object", "is_set", "is_string", "json", "lower", "lt", "lte", "max", "min", "minus", "mul", "neq", "net", "numbers", 
                     "object", "opa", "or", "plus", "print", "product", "rand", "re_match", "regex", "rego", "rem", "replace", "round", "semver", "set_diff", 
                     "sort", "split", "sprintf", "startswith", "strings", "substring", "sum", "time", "to_number", "trace", "trim", "trim_left", "trim_prefix",
                     "trim_right", "trim_space", "trim_suffix", "type_name", "union", "units", "upper", "urlquery", "uuid", "walk", "yaml"]

# Possibly add these? ["default", "deny", "else", "end", "false", "format", "ge", "head", "import"] 

_newer_than_opa_0_45 := ["json.match_schema", "json.verify_schema", "object.keys", "time.format", "crypto.hmac.equal", "crypto.x509.parse_keypair", 
        "graphql.schema_is_valid", "providers.aws.sign_req", "net.cidr_is_valid"]



report contains violation if {
	some rule in input.rules
    some expr in rule.head

    # Is this too generic? How can it be limited to only functions? 
	rule.head.name in _list_of_globals_opa_0_45
    expr.assign == true

	violation := result.fail(rego.metadata.chain(), result.location(rule)) 
}