To create an cloudwatch alarm which sends a mail to the owner/subscriber(whichever email provided) when there's a state change for any of the instance in the given region.

----------
references:
aws article for ec2 state change alarm:
https://aws.amazon.com/premiumsupport/knowledge-center/ec2-email-instance-state-change/

details about instance lifecycle:
https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-lifecycle.html

creating aws cloudwatch event rule template for terraform:
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule

setup customized sns notification using sns and lambda:
https://aws.amazon.com/premiumsupport/knowledge-center/sns-email-notifications-cloudwatch/

lambda function reference:
https://stackoverflow.com/questions/52194888/email-notification-through-sns-and-lambda
