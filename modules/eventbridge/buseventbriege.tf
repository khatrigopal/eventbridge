variable "event_rules" {
  description = "A list of EventBridge rules"
  type        = list(object({
    name          = string
    description   = string
    event_pattern = string
    event_bus_arn = string
    target_arn    = string
  }))
}

resource "aws_cloudwatch_event_rule" "event_rule" {
  for_each = { for rule in var.event_rules : rule.name => rule }

  name          = each.value.name
  description   = each.value.description
  event_pattern = jsondecode(each.value.event_pattern)
  event_bus_arn = each.value.event_bus_arn

  target {
    arn = each.value.target_arn
  }
}

output "event_rule_arns" {
  value = values(aws_cloudwatch_event_rule.event_rule)[*].arn
}
