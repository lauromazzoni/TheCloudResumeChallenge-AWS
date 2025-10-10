import boto3
import json
import os

dynamodb = boto3.resource("dynamodb")
table_name = os.environ.get("TABLE_NAME", "resume-counter")
table = dynamodb.Table(table_name)

def lambda_handler(event, context):
    response = table.update_item(
        Key={"id": "visits"},
        UpdateExpression="ADD #count :inc",
        ExpressionAttributeNames={"#count": "count"},
        ExpressionAttributeValues={":inc": 1},
        ReturnValues="UPDATED_NEW"
    )

    count = int(response["Attributes"]["count"])
    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Methods": "GET,OPTIONS",
            "Access-Control-Allow-Headers": "Content-Type"
        },
        "body": json.dumps({"count": count})
    }
