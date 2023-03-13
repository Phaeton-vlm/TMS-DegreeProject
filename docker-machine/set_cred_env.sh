export AWS_ACCESS_KEY_ID="$(aws configure get aws_access_key_id --profile vlm)"
export AWS_SECRET_ACCESS_KEY="$(aws configure get aws_secret_access_key --profile vlm)"
export AWS_DEFAULT_REGION="$(aws configure get region --profile vlm)"


echo AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
echo AWS_SECRET_ACCESS_KEY=$(echo $AWS_SECRET_ACCESS_KEY|tr '[:print:]' '*')
echo AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION