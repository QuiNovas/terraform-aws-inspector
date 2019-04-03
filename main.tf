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
