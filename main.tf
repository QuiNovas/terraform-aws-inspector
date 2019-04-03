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

resource "null_resource" "install_aws_cli" {
  provisioner "local-exec" {
    command = <<EOH
${var.install_aws_cli ? "true" : "false"} \
&& ! command -v aws >/dev/null 2>&1 \
&& curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" \
&& unzip awscli-bundle.zip \
&& sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
EOH
  }
  triggers {
    events        = "${local.events_enabled}"
    template_arn  = "${aws_inspector_assessment_template.template.arn}"
    topic_arn     = "${aws_sns_topic.topic.arn}"
  }
}
