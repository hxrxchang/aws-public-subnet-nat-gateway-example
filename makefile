terraform-init:
	cd terraform/aws && terraform init -backend-config="bucket=${TF_VAR_backend_s3_bucket}" \
                 -backend-config="key=aws-public-subnet-nat-gateway-example.tfstate" \
                 -backend-config="region=ap-northeast-1" \
				 -backend-config="encrypt=true"
