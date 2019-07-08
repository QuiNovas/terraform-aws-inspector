locals {
  assessment_run_started_event_enabled      = contains(var.events, "ASSESSMENT_RUN_STARTED")
  assessment_run_completed_event_enabled    = contains(var.events, "ASSESSMENT_RUN_COMPLETED")
  assesment_run_state_changed_event_enabled = contains(var.events, "ASSESSMENT_RUN_STATE_CHANGED")
  aws_cli_command                           = var.install_aws_cli ? local.aws_standard_cli_command : local.aws_module_cli_command
  aws_module_cli_command                    = "${path.module}/awscli/bin/aws"
  aws_standard_cli_command                  = "aws"
  finding_reported_event_enabled            = contains(var.events, "FINDING_REPORTED")
  inspector_account                         = local.regional_inspector_accounts[data.aws_region.current.name]
  inspector_assessment_runner_object_key    = "quinovas/inspector-assessment-runner/inspector-assessment-runner-0.0.1.zip"
  os_rules_package_arns = {
    amazon_linux = [
      local.regional_rules_package_arns[data.aws_region.current.name]["common_vulnerabilities_and_exposures"],
      local.regional_rules_package_arns[data.aws_region.current.name]["security_best_practices"],
    ]
    amazon_linux_2_lts_2017_12 = [
      local.regional_rules_package_arns[data.aws_region.current.name]["common_vulnerabilities_and_exposures"],
      local.regional_rules_package_arns[data.aws_region.current.name]["security_best_practices"],
      local.regional_rules_package_arns[data.aws_region.current.name]["runtime_behavior_analysis"],
    ]
    amazon_linux_2012_2014 = [
      local.regional_rules_package_arns[data.aws_region.current.name]["common_vulnerabilities_and_exposures"],
      local.regional_rules_package_arns[data.aws_region.current.name]["security_best_practices"],
    ]
    amazon_linux_2015_2018 = [
      local.regional_rules_package_arns[data.aws_region.current.name]["common_vulnerabilities_and_exposures"],
      local.regional_rules_package_arns[data.aws_region.current.name]["cis_operating_system_security_configuration_benchmarks"],
      local.regional_rules_package_arns[data.aws_region.current.name]["security_best_practices"],
      local.regional_rules_package_arns[data.aws_region.current.name]["runtime_behavior_analysis"],
    ]
    centos = [
      local.regional_rules_package_arns[data.aws_region.current.name]["common_vulnerabilities_and_exposures"],
      local.regional_rules_package_arns[data.aws_region.current.name]["cis_operating_system_security_configuration_benchmarks"],
      local.regional_rules_package_arns[data.aws_region.current.name]["security_best_practices"],
      local.regional_rules_package_arns[data.aws_region.current.name]["runtime_behavior_analysis"],
    ]
    generic = [
      local.regional_rules_package_arns[data.aws_region.current.name]["common_vulnerabilities_and_exposures"],
    ]
    linux = [
      local.regional_rules_package_arns[data.aws_region.current.name]["common_vulnerabilities_and_exposures"],
      local.regional_rules_package_arns[data.aws_region.current.name]["security_best_practices"],
    ]
    debian = [
      local.regional_rules_package_arns[data.aws_region.current.name]["common_vulnerabilities_and_exposures"],
      local.regional_rules_package_arns[data.aws_region.current.name]["security_best_practices"],
    ]
    rhel = [
      local.regional_rules_package_arns[data.aws_region.current.name]["common_vulnerabilities_and_exposures"],
      local.regional_rules_package_arns[data.aws_region.current.name]["cis_operating_system_security_configuration_benchmarks"],
      local.regional_rules_package_arns[data.aws_region.current.name]["security_best_practices"],
      local.regional_rules_package_arns[data.aws_region.current.name]["runtime_behavior_analysis"],
    ]
    ubuntu = [
      local.regional_rules_package_arns[data.aws_region.current.name]["common_vulnerabilities_and_exposures"],
      local.regional_rules_package_arns[data.aws_region.current.name]["security_best_practices"],
      local.regional_rules_package_arns[data.aws_region.current.name]["runtime_behavior_analysis"],
    ]
    ubuntu_14_16_lts = [
      local.regional_rules_package_arns[data.aws_region.current.name]["common_vulnerabilities_and_exposures"],
      local.regional_rules_package_arns[data.aws_region.current.name]["cis_operating_system_security_configuration_benchmarks"],
      local.regional_rules_package_arns[data.aws_region.current.name]["security_best_practices"],
      local.regional_rules_package_arns[data.aws_region.current.name]["runtime_behavior_analysis"],
    ]
    ubuntu_18_04_lts = [
      local.regional_rules_package_arns[data.aws_region.current.name]["common_vulnerabilities_and_exposures"],
      local.regional_rules_package_arns[data.aws_region.current.name]["security_best_practices"],
      local.regional_rules_package_arns[data.aws_region.current.name]["runtime_behavior_analysis"],
    ]
    windows = [
      local.regional_rules_package_arns[data.aws_region.current.name]["common_vulnerabilities_and_exposures"],
      local.regional_rules_package_arns[data.aws_region.current.name]["runtime_behavior_analysis"],
    ]
    windows_server_2008_2012 = [
      local.regional_rules_package_arns[data.aws_region.current.name]["common_vulnerabilities_and_exposures"],
      local.regional_rules_package_arns[data.aws_region.current.name]["cis_operating_system_security_configuration_benchmarks"],
      local.regional_rules_package_arns[data.aws_region.current.name]["runtime_behavior_analysis"],
    ]
    windows_server_2016_base = [
      local.regional_rules_package_arns[data.aws_region.current.name]["common_vulnerabilities_and_exposures"],
      local.regional_rules_package_arns[data.aws_region.current.name]["runtime_behavior_analysis"],
    ]
  }
  regional_inspector_accounts = {
    ap-northeast-1 = "arn:aws:iam::406045910587:root"
    ap-northeast-2 = "arn:aws:iam::526946625049:root"
    ap-south-1     = "arn:aws:iam::162588757376:root"
    ap-southeast-2 = "arn:aws:iam::454640832652:root"
    eu-central-1   = "arn:aws:iam::537503971621:root"
    eu-west-1      = "arn:aws:iam::357557129151:root"
    us-east-1      = "arn:aws:iam::316112463485:root"
    us-east-2      = "arn:aws:iam::646659390643:root"
    us-gov-west-1  = "arn:aws-us-gov:iam::850862329162:root"
    us-west-1      = "arn:aws:iam::166987590008:root"
    us-west-2      = "arn:aws:iam::758058086616:root"
  }
  regional_rules_package_arns = {
    ap-northeast-1 = {
      common_vulnerabilities_and_exposures                   = "arn:aws:inspector:ap-northeast-1:406045910587:rulespackage/0-gHP9oWNT"
      cis_operating_system_security_configuration_benchmarks = "arn:aws:inspector:ap-northeast-1:406045910587:rulespackage/0-7WNjqgGu"
      security_best_practices                                = "arn:aws:inspector:ap-northeast-1:406045910587:rulespackage/0-bBUQnxMq"
      runtime_behavior_analysis                              = "arn:aws:inspector:ap-northeast-1:406045910587:rulespackage/0-knGBhqEu"
    }
    ap-northeast-2 = {
      common_vulnerabilities_and_exposures                   = "arn:aws:inspector:ap-northeast-2:526946625049:rulespackage/0-PoGHMznc"
      cis_operating_system_security_configuration_benchmarks = "arn:aws:inspector:ap-northeast-2:526946625049:rulespackage/0-T9srhg1z"
      security_best_practices                                = "arn:aws:inspector:ap-northeast-2:526946625049:rulespackage/0-2WRpmi4n"
      runtime_behavior_analysis                              = "arn:aws:inspector:ap-northeast-2:526946625049:rulespackage/0-PoYq7lI7"
    }
    ap-south-1 = {
      common_vulnerabilities_and_exposures                   = "arn:aws:inspector:ap-south-1:162588757376:rulespackage/0-LqnJE9dO"
      cis_operating_system_security_configuration_benchmarks = "arn:aws:inspector:ap-south-1:162588757376:rulespackage/0-PSUlX14m"
      security_best_practices                                = "arn:aws:inspector:ap-south-1:162588757376:rulespackage/0-fs0IZZBj"
      runtime_behavior_analysis                              = "arn:aws:inspector:ap-south-1:162588757376:rulespackage/0-EhMQZy6C"
    }
    ap-southeast-2 = {
      common_vulnerabilities_and_exposures                   = "arn:aws:inspector:ap-southeast-2:454640832652:rulespackage/0-D5TGAxiR"
      cis_operating_system_security_configuration_benchmarks = "arn:aws:inspector:ap-southeast-2:454640832652:rulespackage/0-Vkd2Vxjq"
      security_best_practices                                = "arn:aws:inspector:ap-southeast-2:454640832652:rulespackage/0-asL6HRgN"
      runtime_behavior_analysis                              = "arn:aws:inspector:ap-southeast-2:454640832652:rulespackage/0-P8Tel2Xj"
    }
    eu-central-1 = {
      common_vulnerabilities_and_exposures                   = "arn:aws:inspector:eu-central-1:537503971621:rulespackage/0-wNqHa8M9"
      cis_operating_system_security_configuration_benchmarks = "arn:aws:inspector:eu-central-1:537503971621:rulespackage/0-nZrAVuv8"
      security_best_practices                                = "arn:aws:inspector:eu-central-1:537503971621:rulespackage/0-ZujVHEPB"
      runtime_behavior_analysis                              = "arn:aws:inspector:eu-central-1:537503971621:rulespackage/0-0GMUM6fg"
    }
    eu-west-1 = {
      common_vulnerabilities_and_exposures                   = "arn:aws:inspector:eu-west-1:357557129151:rulespackage/0-ubA5XvBh"
      cis_operating_system_security_configuration_benchmarks = "arn:aws:inspector:eu-west-1:357557129151:rulespackage/0-sJBhCr0F"
      security_best_practices                                = "arn:aws:inspector:eu-west-1:357557129151:rulespackage/0-SnojL3Z6"
      runtime_behavior_analysis                              = "arn:aws:inspector:eu-west-1:357557129151:rulespackage/0-lLmwe1zd"
    }
    us-east-1 = {
      common_vulnerabilities_and_exposures                   = "arn:aws:inspector:us-east-1:316112463485:rulespackage/0-gEjTy7T7"
      cis_operating_system_security_configuration_benchmarks = "arn:aws:inspector:us-east-1:316112463485:rulespackage/0-rExsr2X8"
      security_best_practices                                = "arn:aws:inspector:us-east-1:316112463485:rulespackage/0-R01qwB5Q"
      runtime_behavior_analysis                              = "arn:aws:inspector:us-east-1:316112463485:rulespackage/0-gBONHN9h"
    }
    us-east-2 = {
      common_vulnerabilities_and_exposures                   = "arn:aws:inspector:us-east-2:646659390643:rulespackage/0-JnA8Zp85"
      cis_operating_system_security_configuration_benchmarks = "arn:aws:inspector:us-east-2:646659390643:rulespackage/0-m8r61nnh"
      security_best_practices                                = "arn:aws:inspector:us-east-2:646659390643:rulespackage/0-AxKmMHPX"
      runtime_behavior_analysis                              = "arn:aws:inspector:us-east-2:646659390643:rulespackage/0-UCYZFKPV"
    }
    us-gov-west-1 = {
      common_vulnerabilities_and_exposures                   = "arn:aws-us-gov:inspector:us-gov-west-1:850862329162:rulespackage/0-4oQgcI4G"
      cis_operating_system_security_configuration_benchmarks = "arn:aws-us-gov:inspector:us-gov-west-1:850862329162:rulespackage/0-Ac4CFOuc"
      security_best_practices                                = "arn:aws-us-gov:inspector:us-gov-west-1:850862329162:rulespackage/0-rOTGqe5G"
      runtime_behavior_analysis                              = "arn:aws-us-gov:inspector:us-gov-west-1:850862329162:rulespackage/0-JMyjuzoW"
    }
    us-west-1 = {
      common_vulnerabilities_and_exposures                   = "arn:aws:inspector:us-west-1:166987590008:rulespackage/0-TKgzoVOa"
      cis_operating_system_security_configuration_benchmarks = "arn:aws:inspector:us-west-1:166987590008:rulespackage/0-xUY8iRqX"
      security_best_practices                                = "arn:aws:inspector:us-west-1:166987590008:rulespackage/0-byoQRFYm"
      runtime_behavior_analysis                              = "arn:aws:inspector:us-west-1:166987590008:rulespackage/0-yeYxlt0x"
    }
    us-west-2 = {
      common_vulnerabilities_and_exposures                   = "arn:aws:inspector:us-west-2:758058086616:rulespackage/0-9hgA516p"
      cis_operating_system_security_configuration_benchmarks = "arn:aws:inspector:us-west-2:758058086616:rulespackage/0-H5hpSawc"
      security_best_practices                                = "arn:aws:inspector:us-west-2:758058086616:rulespackage/0-JJOtZiqQ"
      runtime_behavior_analysis                              = "arn:aws:inspector:us-west-2:758058086616:rulespackage/0-vg5GGHSD"
    }
  }
  rules_package_arns = [
    local.os_rules_package_arns[var.os_name],
  ]
  sns_topic_enabled = length(var.events) > 0 ? 1 : 0
}

