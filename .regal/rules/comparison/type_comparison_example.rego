package comparison

decision := true {
    "1" > 1
    1 < "1"
    "1" >= 1
    1 <= "1"
}

decision := {"allow": false} {
    not input.foo
}