import boto3
import json
import os

dynamodb = boto3.resource("dynamodb")
table_name = os.environ.get("TABLE_NAME", "resume-counter")
table = dynamodb.Table(table_name)

def lambda_handler(event, context):
    response = table.update_item(
        Key={"id": "visitor_count"},
        UpdateExpression="ADD visits :inc",
        ExpressionAttributeValues={":inc": 1},
        ReturnValues="UPDATED_NEW"
    )

    visits = int(response["Attributes"]["visits"])
    return {"visits": visits}









# import boto3
# import json

# dynamodb = boto3.resource('dynamodb')
# table = dynamodb.Table('resume-counter')

# def lambda_handler(event, context):
#     response = table.update_item(
#         Key={'id': 'visits'},
#         UpdateExpression="ADD #count :incr",
#         ExpressionAttributeNames={"#count": "count"},
#         ExpressionAttributeValues={":incr": 1},
#         ReturnValues="UPDATED_NEW"
#     )

#     return {
#         "statusCode": 200,
#         "headers": {
#             "Content-Type": "application/json",
#             "Access-Control-Allow-Origin": "*"  # habilita CORS
#         },
#         "body": json.dumps({
#             "visits": int(response['Attributes']['count'])
#         })
#     }

