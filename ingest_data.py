import boto3
import requests

# 1. Setup - Use YOUR bucket name here
BUCKET_NAME = 'cyber-pipeline-data' # Change this if yours is different!
FILE_NAME = 'threat_intel.csv'

# 2. Get the data (Top 100 Malicious IPs from a public list)
print("Downloading threat intelligence data...")
url = "https://raw.githubusercontent.com/stamparm/ipsum/master/ipsum.txt"
response = requests.get(url)
data = response.text

# 3. Upload to AWS S3
s3 = boto3.client('s3')
print(f"Uploading to S3 bucket: {BUCKET_NAME}...")

try:
    s3.put_object(Bucket=BUCKET_NAME, Key=f'raw-logs/{FILE_NAME}', Body=data)
    print("✅ Success! Data is now in the Cloud.")
except Exception as e:
    print(f"❌ Error: {e}")
