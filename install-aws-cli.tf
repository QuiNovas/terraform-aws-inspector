resource "random_string" "path_suffix" {
  keepers {
    events        = "${join(",", var.events)}"
    template_arn  = "${aws_inspector_assessment_template.template.arn}"
    topic_arn     = "${aws_sns_topic.topic.arn}"
  }
  length  = 8
  number  = false
  special = false
}

resource "null_resource" "install_aws_cli" {
  provisioner "local-exec" {
    command = <<EOH
${var.install_aws_cli ? "true" : "false"} \
&& rm -rf ${local.aws_cli_path} \
&& mkdir -p ${local.aws_cli_path} \
&& curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "${local.aws_cli_path}/awscli-bundle.zip" \
&& unzip ${local.aws_cli_path}/awscli-bundle.zip \
&& sudo ./awscli-bundle/install -i ${local.aws_cli_path}/awscli
EOH
  }
  triggers {
    events        = "${join(",", var.events)}"
    template_arn  = "${aws_inspector_assessment_template.template.arn}"
    topic_arn     = "${aws_sns_topic.topic.arn}"
  }
}
