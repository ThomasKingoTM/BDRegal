package rules

import (
	"context"
	"strings"

	"github.com/styrainc/regal/pkg/config"
	"github.com/styrainc/regal/pkg/report"
)

type MaskingRule struct {
	ruleConfig config.Rule
}

const (
	title_masking_rule                       = "masking-of-jwt"
	description_masking_rule                 = "masking rule must be present when using jwt library"
	category_masking_rule                    = "bugs"
	relatedResourcesDescription_masking_rule = "documentation"
)

func NewMaskingRule(conf config.Config) *MaskingRule {
	ruleConf, ok := conf.Rules[category_masking_rule][title_masking_rule]
	if ok {
		return &MaskingRule{ruleConfig: ruleConf}
	}

	return &MaskingRule{ruleConfig: config.Rule{
		Level: "error",
	}}
}

func (f *MaskingRule) Run(ctx context.Context, input Input) (*report.Report, error) {
	result := &report.Report{}

	usesJwtLib, file := policyUsesJwtLib(input.FileContent)
	masksJwt := policyMasksJwt(input.FileContent)

	if usesJwtLib == true && masksJwt == false {
		violation := report.Violation{
			Title:       title_masking_rule,
			Description: description_masking_rule,
			Category:    category_masking_rule,
			RelatedResources: []report.RelatedResource{{
				Description: relatedResourcesDescription_masking_rule,
				Reference:   f.Documentation(),
			}},
			Location: report.Location{
				File: file,
			},
			Level: f.ruleConfig.Level,
		}
		result.Violations = append(result.Violations, violation)
	}

	return result, nil
}

func policyUsesJwtLib(policyBundle map[string]string) (bool, string) {
	for filename, fileContent := range policyBundle {
		if strings.Contains(fileContent, "data.global.jwt.validate.token") {
			return true, filename
		}
	}
	return false, ""
}

func policyMasksJwt(policyBundle map[string]string) bool {
	for filename, fileContent := range policyBundle {
		if strings.Contains(filename, "system/log/log.rego") {
			return strings.Contains(fileContent, "mask[{\"op\": \"upsert\", \"path\": \"/input/encodedJwt\"")
		}
	}
	return false
}

func (f *MaskingRule) Name() string {
	return title_masking_rule
}

func (f *MaskingRule) Category() string {
	return category_masking_rule
}

func (f *MaskingRule) Description() string {
	return description_masking_rule
}

func (f *MaskingRule) Config() config.Rule {
	return f.ruleConfig
}

func (f *MaskingRule) Documentation() string {
	return "No documentation exist"
}
