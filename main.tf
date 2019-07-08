data "aws_region" "current" {
}

resource "aws_inspector_resource_group" "group" {
  tags = var.tags
}

resource "aws_inspector_assessment_target" "target" {
  name               = var.name
  resource_group_arn = aws_inspector_resource_group.group.arn
}

resource "aws_inspector_assessment_template" "template" {
  duration = var.duration
  name     = var.name
  # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
  # force an interpolation expression to be interpreted as a list by wrapping it
  # in an extra set of list brackets. That form was supported for compatibilty in
  # v0.11, but is no longer supported in Terraform v0.12.
  #
  # If the expression in the following list itself returns a list, remove the
  # brackets to avoid interpretation as a list of lists. If the expression
  # returns a single list item then leave it as-is and remove this TODO comment.
  rules_package_arns = 
    local.rules_package_arns,
  
  target_arn = aws_inspector_assessment_target.target.arn
}

