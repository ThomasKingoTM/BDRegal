package comparison

decision := true {
    input.bar > input.what
    1 < "1"
    "1" >= 1
    1 <= "1"
}

decision := {"allow": false} {
    not input.foo
}