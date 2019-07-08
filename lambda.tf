data "aws_iam_policy_document" "runner" {
  statement {
    actions = [
      "inspector:StartAssessmentRun",
    ]
    resources = [
      "*",
    ]
    sid = "AllowAssessmentRuns"
  }
}

resource "aws_iam_policy" "runner" {
  name   = "${var.name}-inspector-assessment-runner"
  policy = data.aws_iam_policy_document.runner.json
}

module "runner" {
  dead_letter_arn = var.dead_letter_arn
  environment_variables = {
    ASSESSMENT_TEMPLATE_ARN = aws_inspector_assessment_template.template.arn
    RUN_NAME_PREFIX         = "${aws_inspector_assessment_template.template.name} "
  }
  handler       = "function.handler"
  kms_key_arn   = var.kms_key_arn
  l3_object_key = local.inspector_assessment_runner_object_key
  name          = "${var.name}-inspector-assessment-runner"
  policy_arns = [
    aws_iam_policy.runner.arn,
  ]
  policy_arns_count = 1
  runtime           = "python2.7"
  source            = "QuiNovas/lambdalambdalambda/aws"
  version           = "0.2.0"
}

resource "aws_cloudwatch_event_rule" "runner" {
  description         = "Scheduled event that runs the inspector assessment runner"
  is_enabled          = var.assessment_run_enabled
  name                = "${var.name}-inspector-assessment-runner"
  schedule_expression = "rate(${var.assessment_run_interval} days)"
}

resource "aws_lambda_permission" "runner" {
  action        = "lambda:InvokeFunction"
  function_name = module.runner.name
  principal     = "events.amazonaws.com"
  statement_id  = "AllowExecutionFromEvents"
  source_arn    = aws_cloudwatch_event_rule.runner.arn
}

resource "aws_cloudwatch_event_target" "runner" {
  depends_on = [aws_lambda_permission.runner]
  arn        = module.runner.arn
  rule       = aws_cloudwatch_event_rule.runner.name
}

