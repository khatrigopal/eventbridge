module "eventbridge" {
  source = "github.com/my_org/eventbridge"

  event_rules = [
    {
      name          = "rule1"
      description   = "My EventBridge rule 1"
      event_pattern = jsonencode({
        source      = ["aws.ec2"],
        detail_type = ["EC2 Instance State-change Notification"],
        detail      = {
          state = ["terminated"]
        }
      })
      event_bus_arn = aws_cloudwatch_event_bus.event_bus.arn
      target_arn    = aws_sns_topic.sns_topic.arn
    },
    {
      name          = "rule2"
      description   = "My EventBridge rule 2"
      event_pattern = jsonencode({
        source      = ["aws.s3"],
        detail_type = ["AWS API Call via CloudTrail"],
        detail      = {
          eventSource = ["s3.amazonaws.com"],
          eventName   = ["CreateBucket"]
        }
      })
      event_bus_arn = aws_cloudwatch_event_bus.event_bus.arn
      target_arn    = aws_sqs_queue.sqs_queue.arn
    }
  ]
}

resource "aws_cloudwatch_event_bus" "event_bus" {
  name = "my-event-bus"
}

resource "aws_sns_topic" "sns_topic" {
  name = "my-sns-topic"
}

resource "aws_sqs_queue" "sqs_queue" {
  name = "my-sqs-queue"
}
