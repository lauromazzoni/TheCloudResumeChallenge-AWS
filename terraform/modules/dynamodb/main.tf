resource "aws_dynamodb_table" "this" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

resource "aws_dynamodb_table_item" "seed" {
  table_name = aws_dynamodb_table.this.name
  hash_key   = "id"

  item = jsonencode({
    id    = { S = "visits" }
    count = { N = "0" }
  })
}
