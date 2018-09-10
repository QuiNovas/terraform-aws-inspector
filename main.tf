data "aws_region" "current" {}

resource "aws_inspector_resource_group" "group" {
  tags = "${var.tags}"
}

resource "aws_inspector_assessment_target" "target" {
  name                = "${var.name}"
  resource_group_arn  = "${aws_inspector_resource_group.group.arn}"
}

resource "aws_inspector_assessment_template" "template" {
  duration            = "${var.duration}"
  name                = "${var.name}"
  rules_package_arns  = [
    "${local.rules_package_arns}"
  ]
  target_arn          = "${aws_inspector_assessment_target.target.arn}"
}

resource "aws_sns_topic" "topic" {
  display_name = "${aws_inspector_assessment_template.template.name}"
  name = "${var.name}-inspector"
}

data "aws_iam_policy_document" "topic" {
  statement {
    actions   = [
      "sns:Publish"
    ]
    principals {
      identifiers = [
        "${local.inspector_account}"
      ]
      type = "AWS"
    }
    resources = [
      "${aws_sns_topic.topic.arn}"
    ]
    sid       = "AllowInspectorToPublish"
  }
}

resource "aws_sns_topic_policy" "topic" {
  arn     = "${aws_sns_topic.topic.arn}"
  policy  = "${data.aws_iam_policy_document.topic.json}"
}

resource "null_resource" "assessment_run_started" {
  provisioner "local-exec" {
    command = "aws inspector subscribe-to-event --event ASSESSMENT_RUN_STARTED --resource-arn ${aws_inspector_assessment_template.template.arn} --topic-arn ${aws_sns_topic.topic.arn}"
  }
  triggers {
    template_arn  = "${aws_inspector_assessment_template.template.arn}"
    topic_arn     = "${aws_sns_topic.topic.arn}"
  }
}

resource "null_resource" "assessment_run_completed" {
  provisioner "local-exec" {
    command = "aws inspector subscribe-to-event --event ASSESSMENT_RUN_COMPLETED --resource-arn ${aws_inspector_assessment_template.template.arn} --topic-arn ${aws_sns_topic.topic.arn}"
  }
  triggers {
    template_arn  = "${aws_inspector_assessment_template.template.arn}"
    topic_arn     = "${aws_sns_topic.topic.arn}"
  }
}

resource "null_resource" "assessment_run_state_changed" {
  provisioner "local-exec" {
    command = "aws inspector subscribe-to-event --event ASSESSMENT_RUN_STATE_CHANGED --resource-arn ${aws_inspector_assessment_template.template.arn} --topic-arn ${aws_sns_topic.topic.arn}"
  }
  triggers {
    template_arn  = "${aws_inspector_assessment_template.template.arn}"
    topic_arn     = "${aws_sns_topic.topic.arn}"
  }
}

resource "null_resource" "finding_reported" {
  provisioner "local-exec" {
    command = "aws inspector subscribe-to-event --event FINDING_REPORTED --resource-arn ${aws_inspector_assessment_template.template.arn} --topic-arn ${aws_sns_topic.topic.arn}"
  }
  triggers {
    template_arn  = "${aws_inspector_assessment_template.template.arn}"
    topic_arn     = "${aws_sns_topic.topic.arn}"
  }
}
