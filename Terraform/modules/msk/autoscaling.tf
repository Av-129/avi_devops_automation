resource "aws_appautoscaling_target" "msk_storage_target" {
  service_namespace  = "kafka"
  scalable_dimension = "kafka:broker-storage:VolumeSize"
  resource_id        = aws_msk_cluster.msk.arn
  min_capacity       = 1    # Use the allowed minimum from your existing infra
  max_capacity       = 700  # Use the allowed maximum from your existing infra
  role_arn           = aws_iam_role.msk_autoscale.arn

  depends_on = [aws_msk_cluster.msk]
}

resource "aws_appautoscaling_policy" "msk_storage_policy" {
  name               = "msk-storage-autoscale-policy"
  service_namespace  = aws_appautoscaling_target.msk_storage_target.service_namespace
  resource_id        = aws_appautoscaling_target.msk_storage_target.resource_id
  scalable_dimension = aws_appautoscaling_target.msk_storage_target.scalable_dimension
  policy_type        = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    target_value = 70

    predefined_metric_specification {
      predefined_metric_type = "KafkaBrokerStorageUtilization"
    }
    scale_in_cooldown  = 300
    scale_out_cooldown = 300
  }
}
