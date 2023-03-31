module "eventbridge" {
  source = "github.com/my_org/eventbridge"

  event_bus_name = "my-event-bus"

  event_rules = [
    {
      name         = "rule1"
      description  = "My EventBridge rule 1"
      event_source = "aws.ec2"
      event_pattern = jsonencode({
        source = ["aws.ec2"],
        detail = {
          state = ["terminated"]
        }
      })
      target_arn = "arn:aws:sns:us-east-1:123456789012:my-sns-topic"
    },
    {
      name         = "rule2"
      description  = "My EventBridge rule 2"
      event_source = "aws.s3"
      event_pattern = jsonencode({
        source = ["aws.s3"],
        detail = {
          bucket_name = ["my-bucket"]
        }
      })
      target_arn = "arn:aws:sns:us-east-1:123456789012:my-sns-topic"
    }
  ]
}
