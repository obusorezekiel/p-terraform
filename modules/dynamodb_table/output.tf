output "table_name" {
  value = aws_dynamodb_table.tf_lock_table.id
}