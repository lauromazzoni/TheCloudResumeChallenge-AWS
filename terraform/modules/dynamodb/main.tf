# DynamoDB table for visitor counter
resource "aws_dynamodb_table" "visitor_counter" {
  name           = "${var.project_name}-${var.environment}-visitor-counter"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = var.tags
}

# Initial item in DynamoDB table
resource "aws_dynamodb_table_item" "visitor_count" {
  table_name = aws_dynamodb_table.visitor_counter.name
  hash_key   = aws_dynamodb_table.visitor_counter.hash_key

  item = jsonencode({
    id = {
      S = "visitor_count"
    }
    count = {
      N = "0"
    }
  })

  lifecycle {
    ignore_changes = [item]
  }
}