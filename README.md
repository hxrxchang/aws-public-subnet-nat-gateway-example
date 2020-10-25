# aws-public-subnet-nat-gateway-example

## 必要なもの

- aws-cli
- terraform
- direnv

## リソース作成

- tfstate を保存する S3 バケットの作成
- 環境変数定義
  - `$ cp .envrc.test .envrc`
  - `.envrc` を編集

```
export TF_VAR_key_name="<EC2にsshログインする際に使う秘密鍵のファイル名>"
export TF_VAR_public_key_path="<上の秘密鍵の公開鍵のファイルパス>"
export TF_VAR_backend_s3_bucket="<最初に作成したs3バケット名>"
```

```
$ make terraform-init
$ cd terraform/aws
$ terraform plan
$ terraform apply
```
