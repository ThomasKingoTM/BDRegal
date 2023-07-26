package rules_test

import (
	"context"
	"testing"

	"github.com/styrainc/regal/internal/test"
	"github.com/styrainc/regal/pkg/config"
	"github.com/styrainc/regal/pkg/rules"
)

func TestMaskingRuleFails_NoMaskingFile(t *testing.T) {
	t.Parallel()

	ctx := context.Background()

	policyFileName := "api/authz/policy.rego"
	policyFileContent := `
package policy

token := data.global.jwt.validate.token
`

	bundle := map[string]string{
		policyFileName: policyFileContent,
	}

	result, err := rules.NewMaskingRule(config.Config{}).Run(ctx, test.InputBundle(bundle))
	if err != nil {
		t.Fatal(err)
	}

	if len(result.Violations) != 1 {
		t.Errorf("expected 1 violation, got %d", len(result.Violations))
	}

	if result.Violations[0].Title != "masking-of-jwt" {
		t.Errorf("expected violation title to be 'masking-of-jwt', got %s", result.Violations[0].Title)
	}

	if result.Violations[0].Category != "bugs" {
		t.Errorf("expected violation category to be 'bugs', got %s", result.Violations[0].Category)
	}

	if result.Violations[0].Location.File != "api/authz/policy.rego" {
		t.Errorf("expected violation location file to be 'api/authz/policy.rego', got %s", result.Violations[0].Location.File)
	}
}

func TestMaskingRuleFails_IncorrectMaskingFile(t *testing.T) {
	t.Parallel()

	ctx := context.Background()

	policyFileName := "api/authz/policy.rego"
	policyFileContent := `
package policy

token := data.global.jwt.validate.token
`
	systemLogFileName := "system/log/error.rego"
	systemLogFileContent := "package system.log"

	bundle := map[string]string{
		policyFileName:    policyFileContent,
		systemLogFileName: systemLogFileContent,
	}

	result, err := rules.NewMaskingRule(config.Config{}).Run(ctx, test.InputBundle(bundle))
	if err != nil {
		t.Fatal(err)
	}

	if len(result.Violations) != 1 {
		t.Errorf("expected 1 violation, got %d", len(result.Violations))
	}

	if result.Violations[0].Title != "masking-of-jwt" {
		t.Errorf("expected violation title to be 'masking-of-jwt', got %s", result.Violations[0].Title)
	}

	if result.Violations[0].Category != "bugs" {
		t.Errorf("expected violation category to be 'bugs', got %s", result.Violations[0].Category)
	}

	if result.Violations[0].Location.File != "api/authz/policy.rego" {
		t.Errorf("expected violation location file to be 'api/authz/policy.rego', got %s", result.Violations[0].Location.File)
	}
}

func TestMaskingRuleFails_CorrectMaskingFileMissingMaskingRule(t *testing.T) {
	t.Parallel()

	ctx := context.Background()

	policyFileName := "api/authz/policy.rego"
	policyFileContent := `
package policy

token := data.global.jwt.validate.token
`
	systemLogFileName := "system/log/log.rego"
	systemLogFileContent := "package system.log"

	bundle := map[string]string{
		policyFileName:    policyFileContent,
		systemLogFileName: systemLogFileContent,
	}

	result, err := rules.NewMaskingRule(config.Config{}).Run(ctx, test.InputBundle(bundle))
	if err != nil {
		t.Fatal(err)
	}

	if len(result.Violations) != 1 {
		t.Errorf("expected 1 violation, got %d", len(result.Violations))
	}

	if result.Violations[0].Title != "masking-of-jwt" {
		t.Errorf("expected violation title to be 'masking-of-jwt', got %s", result.Violations[0].Title)
	}

	if result.Violations[0].Category != "bugs" {
		t.Errorf("expected violation category to be 'bugs', got %s", result.Violations[0].Category)
	}

	if result.Violations[0].Location.File != "api/authz/policy.rego" {
		t.Errorf("expected violation location file to be 'api/authz/policy.rego', got %s", result.Violations[0].Location.File)
	}
}

func TestMaskingRuleFails_IncorrectMaskingFileCorrectRule(t *testing.T) {
	t.Parallel()

	ctx := context.Background()

	policyFileName := "api/authz/policy.rego"
	policyFileContent := `
package policy

token := data.global.jwt.validate.token
`
	systemLogFileName := "system/log/error.rego"
	systemLogFileContent := `
package system.log

mask[{"op": "upsert", "path": "/input/encodedJwt", "value": x}] {
	x := "**REDACTED**"
}
`

	bundle := map[string]string{
		policyFileName:    policyFileContent,
		systemLogFileName: systemLogFileContent,
	}

	result, err := rules.NewMaskingRule(config.Config{}).Run(ctx, test.InputBundle(bundle))
	if err != nil {
		t.Fatal(err)
	}

	if len(result.Violations) != 1 {
		t.Errorf("expected 1 violation, got %d", len(result.Violations))
	}

	if result.Violations[0].Title != "masking-of-jwt" {
		t.Errorf("expected violation title to be 'masking-of-jwt', got %s", result.Violations[0].Title)
	}

	if result.Violations[0].Category != "bugs" {
		t.Errorf("expected violation category to be 'bugs', got %s", result.Violations[0].Category)
	}

	if result.Violations[0].Location.File != "api/authz/policy.rego" {
		t.Errorf("expected violation location file to be 'api/authz/policy.rego', got %s", result.Violations[0].Location.File)
	}
}

func TestMaskingRuleFails_CorrectMaskingFileWrongMaskingRule(t *testing.T) {
	t.Parallel()

	ctx := context.Background()

	policyFileName := "api/authz/policy.rego"
	policyFileContent := `
package policy

token := data.global.jwt.validate.token
`
	systemLogFileName := "system/log/log.rego"
	systemLogFileContent := `
package system.log

mask[{"op": "upsert", "path": "/input/incorrectValue", "value": x}] {
	x := "**REDACTED**"
}
	`

	bundle := map[string]string{
		policyFileName:    policyFileContent,
		systemLogFileName: systemLogFileContent,
	}

	result, err := rules.NewMaskingRule(config.Config{}).Run(ctx, test.InputBundle(bundle))
	if err != nil {
		t.Fatal(err)
	}

	if len(result.Violations) != 1 {
		t.Errorf("expected 1 violation, got %d", len(result.Violations))
	}

	if result.Violations[0].Title != "masking-of-jwt" {
		t.Errorf("expected violation title to be 'masking-of-jwt', got %s", result.Violations[0].Title)
	}

	if result.Violations[0].Category != "bugs" {
		t.Errorf("expected violation category to be 'bugs', got %s", result.Violations[0].Category)
	}

	if result.Violations[0].Location.File != "api/authz/policy.rego" {
		t.Errorf("expected violation location file to be 'api/authz/policy.rego', got %s", result.Violations[0].Location.File)
	}
}

func TestMaskingRuleSuccess_CorrectMaskingFileCorrectMaskingRule(t *testing.T) {
	t.Parallel()

	ctx := context.Background()

	policyFileName := "api/authz/policy.rego"
	policyFileContent := `
package policy

token := data.global.jwt.validate.token
`
	systemLogFileName := "system/log/log.rego"
	systemLogFileContent := `
package system.log

mask[{"op": "upsert", "path": "/input/encodedJwt", "value": x}] {
	x := "**REDACTED**"
}
	`

	bundle := map[string]string{
		policyFileName:    policyFileContent,
		systemLogFileName: systemLogFileContent,
	}

	result, err := rules.NewMaskingRule(config.Config{}).Run(ctx, test.InputBundle(bundle))
	if err != nil {
		t.Fatal(err)
	}

	if len(result.Violations) != 0 {
		t.Errorf("expected 0 violation, got %d", len(result.Violations))
	}
}
