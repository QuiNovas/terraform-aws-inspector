output "assessment_target_arn" {
  description = "The target assessment ARN."
  value       = aws_inspector_assessment_target.target.arn
}

output "assessment_template_arn" {
  description = "The template assessment ARN."
  value       = aws_inspector_assessment_template.template.arn
}

output "resource_group_arn" {
  description = "The resource group ARN."
  value       = aws_inspector_resource_group.group.arn
}

output "topic_arn" {
  description = "The ARN of the SNS that Inspector will report on topic."
  value       = local.sns_topic_enabled ? join("", aws_sns_topic.topic.*.arn) : ""
}

