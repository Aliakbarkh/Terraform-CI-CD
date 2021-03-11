data "aws_availability_zones" "available" {}

resource "aws_autoscaling_group" "main" {
  name_prefix = "example"

  launch_configuration = aws_instance.main.id
  availability_zones   = [data.aws_availability_zones.available.names[0]]

  min_size = 2
  max_size = 5

  tags = [
    {
      key                 = "application"
      value               = "main"
      propagate_at_launch = true
    },
  ]
}

resource "aws_autoscalingplans_scaling_plan" "main" {
  name = "example-dynamic-cost-optimization"

  application_source {
    tag_filter {
      key    = "application"
      values = ["main"]
    }
  }

  scaling_instruction {
    max_capacity       = 5
    min_capacity       = 2
    resource_id        = format("autoScalingGroup/%s", aws_autoscaling_group.example.name)
    scalable_dimension = "autoscaling:autoScalingGroup:DesiredCapacity"
    service_namespace  = "autoscaling"

    target_tracking_configuration {
      predefined_scaling_metric_specification {
        predefined_scaling_metric_type = "ASGAverageCPUUtilization"
      }

      target_value = 45
    }
  }
}
