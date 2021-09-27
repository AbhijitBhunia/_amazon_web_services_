import os
import json
import boto3
import gzip
import base64
import base64
import requests

region_name = '${var.region}'
secret_name = '${aws_secretsmanager_secret.elasticsearch_credentials.name}'

log_group = boto3.client('logs')

host = os.environ['host_name']
headers = {'Content-type': 'application/json','Accept': 'text/plain'}

def lambda_handler(event, context):

    cw_data = event['awslogs']['data']
    compressed_data = base64.b64decode(cw_data)
    uncompressed_data = gzip.decompress(compressed_data)
    data = json.loads(uncompressed_data)
    log_events = data['logEvents']

    session = boto3.session.Session()
    client = session.client( service_name='secretsmanager', region_name=region_name)
    get_secrets = client.get_secrets_value( SecretId = secret_name)
    cred_str = get_secrets['SecretString']
    cred_json = json.loads(cred_str)
    ID = cred_json['Username']
    password = cred_json['Password']
    log_json = json.dumps(data)

    try:
        response = requests.post(host, auth=(ID, password), data=log_json, headers=headers, timeout=30)
        print("status code: \n", response.status_code)
        print("elapsed time: \n", response.elapsed)
        print("text response: \n", response.text)
        print("request type: \n", response.request)
        print("reason of response: \n", response.reason)
    except requests.Timeout as response:
        print("status code: \n", response.status_code)
        print("elapsed time: \n", response.elapsed)
        print("text response: \n", response.text)
        print("request type: \n", response.request)
        print("reason of response: \n", response.reason)