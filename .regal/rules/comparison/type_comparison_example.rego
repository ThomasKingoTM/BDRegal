package comparison

# regal ignore:constant-condition
decision {
	input.bar > input.what

	# regal ignore:constant-condition
	1 < "1"

	# regal ignore:constant-condition
	"1" >= 1

	# regal ignore:constant-condition
	1 <= "1"
}

decision := {"allow": false} {
	not input.foo
}
