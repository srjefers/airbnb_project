import boto3
import json
from datetime import datetime

def lambda_handler(event, context) -> dict:
    table_name = 'tbl_airbnb_review'
    bucket_name = 'bkt_airbnb_review'
    dynamodb = boto3.resource('dynamodb')
    s3 = boto3.client('s3')

    table = dynamodb.Table(table_name)
    response = table.scan()
    items = response.get('items', [])
    timestamp = datetime.now().strftime("%Y-%m-%dT%H:%M:%S")
    file_name = f"airbnb_reviews_{timestamp}.json"
    json_content = json.dumps(items, indent=4)

    s3.put_object(
        Bucket=bucket_name,
        Key=file_name,
        Body=json_content,
        ContentType='application/json'
    )

    return {
        'statusCode': 200,
        'body': json.dumps({
            'message': 'Success',
            'file_name': file_name
        })
    }
