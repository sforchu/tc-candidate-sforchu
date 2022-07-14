#!/bin/bash
aws s3 cp s3://smith-bucket-1234/tech-challenge-flask-app/ /tmp/tech-challenge-flask-app --recursive
export TC_DYNAMO_TABLE=Candidates
yum -y install python-pip
pip install -r /tmp/tech-challenge-flask-app/requirements.txt
cd /tmp/tech-challenge-flask-app/
gunicorn -b 0.0.0.0 app:candidates_app