resource "aws_wafv2_web_acl" "waf_votation" {
  name     = "waf-votation"
  scope    = "REGIONAL"

  rule {
    name     = "country-rule"
    priority = 1

    action {
      allow {}
    }

    statement {
      geo_match_statement {
        country_codes = "BR"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = ""
      sampled_requests_enabled   = false
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = ""
    sampled_requests_enabled   = false
  }

  tags = {
    "project_votation" = "${local.votation_tag}"
  }
}

resource "aws_wafv2_web_acl_association" "waf_association_alb" {
  resource_arn = aws_lb.lb_votation.arn
  web_acl_arn  = aws_wafv2_rule_group.waf_votation.arn
}