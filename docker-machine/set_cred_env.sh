#! /bin/env bash
export AWS_ACCESS_KEY_ID="$(cat aws_cred/aws_access_key_id)"
export AWS_SECRET_ACCESS_KEY="$(cat aws_cred/aws_secret_access_key)"
export AWS_DEFAULT_REGION="us-east-1"