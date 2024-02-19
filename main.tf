resource "aws_efs_file_system" "efs-fs" {
  throughput_mode = var.throughput_mode
  encrypted = var.encrypted
  lifecycle_policy {
    transition_to_ia = var.transition_to_ia
  }
  lifecycle_policy {
    transition_to_primary_storage_class = var.transition_out_of_ia
  }
  tags = {
    Name = var.efs-name
  }
}

resource "aws_efs_access_point" "rp-access-point" {
  file_system_id = aws_efs_file_system.efs-fs.id
  root_directory {
    path = var.efs_access_point_path
  }
}

resource "aws_efs_mount_target" "rp-mount-point" {
  count = length(var.app_subnet)
  file_system_id = aws_efs_file_system.efs-fs.id
  subnet_id      = var.app_subnet[count.index]
  security_groups = [var.sg-id]
}