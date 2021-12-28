# Get List of Availability Zones in a Specific Region
# Region is set in f-f-f-f-f-f-f-f-providers.tf in Provider Block
# Datasource-1
data "aws_availability_zones" "availability-zone-list" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

# Check if that respective Instance Type is supported in that Specific Region in list of availability Zones
# Get the List of Availability Zones in a Particular region where that respective Instance Type is supported
# Datasource-2
data "aws_ec2_instance_type_offerings" "instance-type-list" {
  for_each      = toset(data.aws_availability_zones.availability-zone-list.names)
  filter {
    name   = "instance-type"
    values = ["t2.micro"]
  }
  filter {
    name   = "location"
    values = [each.key]
  }
  location_type = "availability-zone"
}
