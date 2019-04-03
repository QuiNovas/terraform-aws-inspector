resource "random_integer" "sleep_timer" {
  keepers {
    events        = "${local.events_enabled}"
    template_arn  = "${aws_inspector_assessment_template.template.arn}"
    topic_arn     = "${aws_sns_topic.topic.arn}"
  }
  max = 90
  min = 5
}

resource "null_resource" "install_aws_cli" {
  provisioner "local-exec" {
    command = <<EOH
${var.install_aws_cli ? "true" : "false"} \
&& ! command -v aws >/dev/null 2>&1 \
&& sleep ${random_integer.sleep_timer.result}s \
&& [ ! -f awscli-bundle.zip ] \
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
