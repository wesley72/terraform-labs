# Shared SNS topic for alarms
resource "aws_sns_topic" "alerts" {
  name = "shared-alerts"
}

# Example CloudWatch log group
resource "aws_cloudwatch_log_group" "shared_logs" {
  name              = "/terraform/shared"
  retention_in_days = 14
}

# Example dashboard
resource "aws_cloudwatch_dashboard" "shared_dashboard" {
  dashboard_name = "SharedInfraDashboard"
  dashboard_body = <<EOF
{
  "widgets": [
    {
      "type": "text",
      "x": 0,
      "y": 0,
      "width": 24,
      "height": 3,
      "properties": {
        "markdown": "## Shared Infra Monitoring"
      }
    }
  ]
}
EOF
}

output "sns_topic_arn" {
  value = aws_sns_topic.alerts.arn
}