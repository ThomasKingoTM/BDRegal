package p

# Validate if the user has access
token := {"valid": true, "payload": payload, "subject": subject, "scopes": scopes, "environment": env, "reasons": set()} {
	count(_invalid_input) == 0
	jwt_check.valid
	subject := jwt_check.subject
	scopes := jwt_check.scopes
	payload := jwt_check.payload
	env := jwt_check.environment
} else = {"valid": false, "payload": {}, "reasons": reasons} {
	reasons := jwt_check.reasons
} else = {"valid": false, "payload": {}, "reasons": reasons} {
	reasons := _invalid_input
} else = {"valid": false}

_issuers := data.global.oidc.sandbox.issuers

_invalid_input["Token not provided as input (input.encoded_jwt)"] {
	not input.encoded_jwt
}

_invalid_input["Timestamp not provided as input (input.current_time_millis)"] {
	not input.current_time_millis
}

# helper for using jwt library to validate token at the specified time
jwt_check := result {
	result := data.global.jwt.core.token with input as {"jwt": input.encoded_jwt, "current_time": input.current_time_millis, "issuers": _issuers}
}