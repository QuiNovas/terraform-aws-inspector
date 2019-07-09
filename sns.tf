resource "aws_sns_topic" "topic" {
  count        = local.sns_topic_enabled
  display_name = aws_inspector_assessment_template.template.name
  name         = "${var.name}-inspector"
}

data "aws_iam_policy_document" "topic" {
  statement {
    actions = [
      "sns:Publish",
    ]
    principals {
      
      identifiers = 
        [local.inspector_account],
      
      type = "AWS"
    }
    resources = [
      aws_sns_topic.topic[0].arn,
    ]
    sid = "AllowInspectorToPublish"
  }
}

resource "aws_sns_topic_policy" "topic" {
  arn    = aws_sns_topic.topic[0].arn
  count  = local.sns_topic_enabled
  policy = data.aws_iam_policy_document.topic.json
}

resource "null_resource" "subscribe_assessment_run_completed" {
  count = local.assessment_run_completed_event_enabled ? 1 : 0
  depends_on = [
    aws_sns_topic_policy.topic,
    null_resource.install_aws_cli,
  ]
  provisioner "local-exec" {
    command = "${local.aws_cli_command} inspector subscribe-to-event --event ASSESSMENT_RUN_COMPLETED --resource-arn ${aws_inspector_assessment_template.template.arn} --topic-arn ${aws_sns_topic.topic[0].arn} --region ${data.aws_region.current.name}"
  }
  triggers = {
    event        = local.assessment_run_completed_event_enabled
    template_arn = aws_inspector_assessment_template.template.arn
    topic_arn    = aws_sns_topic.topic[0].arn
  }
}

resource "null_resource" "unsubscribe_assessment_run_completed" {
  count = local.assessment_run_completed_event_enabled ? 0 : 1
  depends_on = [
    aws_sns_topic_policy.topic,
    null_resource.install_aws_cli,
  ]
  provisioner "local-exec" {
    command = "${local.aws_cli_command} inspector unsubscribe-from-event --event ASSESSMENT_RUN_COMPLETED --resource-arn ${aws_inspector_assessment_template.template.arn} --topic-arn ${aws_sns_topic.topic[0].arn} --region ${data.aws_region.current.name}"
  }
  triggers = {
    event        = local.assessment_run_completed_event_enabled
    template_arn = aws_inspector_assessment_template.template.arn
    topic_arn    = aws_sns_topic.topic[0].arn
  }
}

resource "null_resource" "subscribe_assessment_run_started" {
  count = local.assessment_run_started_event_enabled ? 1 : 0
  depends_on = [
    aws_sns_topic_policy.topic,
    null_resource.install_aws_cli,
  ]
  provisioner "local-exec" {
    command = "${local.aws_cli_command} inspector subscribe-to-event --event ASSESSMENT_RUN_STARTED --resource-arn ${aws_inspector_assessment_template.template.arn} --topic-arn ${aws_sns_topic.topic[0].arn} --region ${data.aws_region.current.name}"
  }
  triggers = {
    event        = local.assessment_run_started_event_enabled
    template_arn = aws_inspector_assessment_template.template.arn
    topic_arn    = aws_sns_topic.topic[0].arn
  }
}

resource "null_resource" "unsubscribe_assessment_run_started" {
  count = local.assessment_run_started_event_enabled ? 0 : 1
  depends_on = [
    aws_sns_topic_policy.topic,
    null_resource.install_aws_cli,
  ]
  provisioner "local-exec" {
    command = "${local.aws_cli_command} inspector unsubscribe-from-event --event ASSESSMENT_RUN_STARTED --resource-arn ${aws_inspector_assessment_template.template.arn} --topic-arn ${aws_sns_topic.topic[0].arn} --region ${data.aws_region.current.name}"
  }
  triggers = {
    event        = local.assessment_run_started_event_enabled
    template_arn = aws_inspector_assessment_template.template.arn
    topic_arn    = aws_sns_topic.topic[0].arn
  }
}

resource "null_resource" "subscribe_assessment_run_state_changed" {
  count = local.assesment_run_state_changed_event_enabled ? 1 : 0
  depends_on = [
    aws_sns_topic_policy.topic,
    null_resource.install_aws_cli,
  ]
  provisioner "local-exec" {
    command = "${local.aws_cli_command} inspector subscribe-to-event --event ASSESSMENT_RUN_STATE_CHANGED --resource-arn ${aws_inspector_assessment_template.template.arn} --topic-arn ${aws_sns_topic.topic[0].arn} --region ${data.aws_region.current.name}"
  }
  triggers = {
    event        = local.assesment_run_state_changed_event_enabled
    template_arn = aws_inspector_assessment_template.template.arn
    topic_arn    = aws_sns_topic.topic[0].arn
  }
}

resource "null_resource" "unsubscribe_assessment_run_state_changed" {
  count = local.assesment_run_state_changed_event_enabled ? 0 : 1
  depends_on = [
    aws_sns_topic_policy.topic,
    null_resource.install_aws_cli,
  ]
  provisioner "local-exec" {
    command = "${local.aws_cli_command} inspector unsubscribe-from-event --event ASSESSMENT_RUN_STATE_CHANGED --resource-arn ${aws_inspector_assessment_template.template.arn} --topic-arn ${aws_sns_topic.topic[0].arn} --region ${data.aws_region.current.name}"
  }
  triggers = {
    event        = local.assesment_run_state_changed_event_enabled
    template_arn = aws_inspector_assessment_template.template.arn
    topic_arn    = aws_sns_topic.topic[0].arn
  }
}

resource "null_resource" "subscribe_finding_reported" {
  count = local.finding_reported_event_enabled ? 1 : 0
  depends_on = [
    aws_sns_topic_policy.topic,
    null_resource.install_aws_cli,
  ]
  provisioner "local-exec" {
    command = "${local.aws_cli_command} inspector subscribe-to-event --event FINDING_REPORTED --resource-arn ${aws_inspector_assessment_template.template.arn} --topic-arn ${aws_sns_topic.topic[0].arn} --region ${data.aws_region.current.name}"
  }
  triggers = {
    event        = local.finding_reported_event_enabled
    template_arn = aws_inspector_assessment_template.template.arn
    topic_arn    = aws_sns_topic.topic[0].arn
  }
}

resource "null_resource" "unsubscribe_finding_reported" {
  count = local.finding_reported_event_enabled ? 0 : 1
  depends_on = [
    aws_sns_topic_policy.topic,
    null_resource.install_aws_cli,
  ]
  provisioner "local-exec" {
    command = "${local.aws_cli_command} inspector unsubscribe-from-event --event FINDING_REPORTED --resource-arn ${aws_inspector_assessment_template.template.arn} --topic-arn ${aws_sns_topic.topic[0].arn} --region ${data.aws_region.current.name}"
  }
  triggers = {
    event        = local.finding_reported_event_enabled
    template_arn = aws_inspector_assessment_template.template.arn
    topic_arn    = aws_sns_topic.topic[0].arn
  }
}

