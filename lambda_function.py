import boto3

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
        "headers": {"Content-Type": "application/json"},
        "body": '{"visits": %d}' % response['Attributes']['count']
    }

