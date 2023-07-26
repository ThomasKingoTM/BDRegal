# METADATA 
# description: Rules must be maximum 8 lines in length.
package custom.regal.rules.style["max-8-lines"]

import future.keywords.in
import future.keywords.if
import future.keywords.contains
import future.keywords.every 

import data.regal.result

report contains violation if {
    not _number_of_lines_is_less_than_9

    violation := result.fail(rego.metadata.chain(), result.location(input.rules[0].head))
}

_object_of_opening_clauses := {
    index:line | 
        some index, line in input.regal.file.lines
        is_number(index)
        contains(line,"{")
}

_number_of_lines_is_less_than_9 := true {
    every opening_index, _ in _object_of_opening_clauses {
        some closing_index, closing_clause in input.regal.file.lines 
        contains(closing_clause,"}")
        is_number(closing_index)
        closing_index > opening_index
        closing_index - opening_index < 10
    }
}

# some rule in input.rules
    # some index in rule.body[_].index
    # is_number(index)
    # index > 7 
    
    # Make a set with all lines that contain "{"
    # For every line in the set, check that there exists SOME line that contains a "}" 
    # The difference in index between these lines must be 9 or less