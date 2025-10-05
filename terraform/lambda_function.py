import boto3
import json

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('resume-counter')

def lambda_handler(event, context):
    response = table.update_item(
        Key={'id': 'visits'},
        UpdateExpression="ADD #count :incr",
        ExpressionAttributeNames={"#count": "count"},
        ExpressionAttributeValues={":incr": 1},
        ReturnValues="UPDATED_NEW"
    )

    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*"  # importante: habilita CORS
        },
        "body": json.dumps({
            "visits": int(response['Attributes']['count'])
        })
    }

