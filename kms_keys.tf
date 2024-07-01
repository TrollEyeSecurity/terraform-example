# ----------------------------------------------------------------------------------------------------------------------
# AWS Encryption key
# ----------------------------------------------------------------------------------------------------------------------
resource "aws_kms_key" "default-data-key" {
    description = "Default KMS key"
    tags = {
        Name = upper("KMS-KEY")
        Purpose = "KMS KEY"
    }
    deletion_window_in_days = 7
}

resource "aws_kms_alias" "client-data-key-alias" {
  name          = "alias/default-data-key"
  target_key_id = aws_kms_key.default-data-key.key_id
}
