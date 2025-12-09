data "aws_autoscaling_groups" "eks_node_asg" {
  filter {
    name   = "tag:eks:nodegroup-name"
    values = [var.node_group_name]
  }
}

data "aws_instances" "eks_nodes" {
  filter {
    name   = "tag:eks:nodegroup-name"
    values = [var.node_group_name]
  }
}

resource "aws_sns_topic" "alerts" {
  name = "cloudwatch-alerts-topic"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.sns_email
}


resource "aws_autoscaling_policy" "scale_out" {
  name                   = "${var.node_group_name}-scale-out"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 300
  autoscaling_group_name = data.aws_autoscaling_groups.eks_node_asg.names[0]
}

resource "aws_autoscaling_policy" "scale_in" {
  name                   = "${var.node_group_name}-scale-in"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
  cooldown               = 600
  autoscaling_group_name = data.aws_autoscaling_groups.eks_node_asg.names[0]
}


resource "aws_cloudwatch_metric_alarm" "node_group_high_cpu" {
  alarm_name          = "EKSNodeGroup-HighCPU"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Scale OUT nodes when CPU is high"

  dimensions = {
    AutoScalingGroupName = data.aws_autoscaling_groups.eks_node_asg.names[0]
  }

  alarm_actions = [
    aws_autoscaling_policy.scale_out.arn,
    aws_sns_topic.alerts.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "node_group_low_cpu" {
  alarm_name          = "EKSNodeGroup-LowCPU"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 3
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 180
  statistic           = "Average"
  threshold           = 30
  alarm_description   = "Scale IN nodes when CPU is low"

  dimensions = {
    AutoScalingGroupName = data.aws_autoscaling_groups.eks_node_asg.names[0]
  }

  alarm_actions = [
    aws_autoscaling_policy.scale_in.arn,
    aws_sns_topic.alerts.arn
  ]
}
