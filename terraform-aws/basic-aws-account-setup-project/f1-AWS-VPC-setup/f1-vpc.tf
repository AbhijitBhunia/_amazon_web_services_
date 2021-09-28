resource "aws_vpc" "main" {
  cidr_block = var.VPC_CIDR[0]
  instance_tenancy =  var.instance_tenancy
  enable_dns_support = var.DNS_support
  enable_dns_hostnames = var.DNS_hostnames
  assign_generated_ipv6_cidr_block = var.generated_ipv6_cidr_block
  enable_classiclink = var.ClassicLink
  enable_classiclink_dns_support = var.classiclink_dns_support
  tags = merge(
          var.additional_vpc_tags,
          module.project_provider_settings.tags
  )
}
