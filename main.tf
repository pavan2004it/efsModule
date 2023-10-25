resource "aws_efs_file_system" "rp-efs-jobs" {
  throughput_mode = "elastic"
  lifecycle_policy {
    transition_to_ia = "AFTER_90_DAYS"
    transition_to_primary_storage_class = "AFTER_1_ACCESS"
  }
  tags = {
    Name = "rp-dev-efs"
  }
}

resource "aws_efs_access_point" "rp-access-point" {
  file_system_id = aws_efs_file_system.rp-efs-jobs.id
  root_directory {
    path = "/"
  }
}

resource "aws_efs_mount_target" "rp-mount-point" {
  count = length(var.app_subnet)
  file_system_id = aws_efs_file_system.rp-efs-jobs.id
  subnet_id      = var.app_subnet[count.index]
  security_groups = [var.sg-id]
}