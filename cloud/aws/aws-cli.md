# AWS CLI

Instalação via snap

`sudo snap install aws-cli --classic`
- https://github.com/aws/aws-cli

## Configurando

- https://docs.aws.amazon.com/cli/latest/reference/configure/index.html
- https://docs.aws.amazon.com/pt_br/cli/latest/userguide/cli-configure-files.html]


```sh
aws configure --profile clienteABS
AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
Default region name [None]: us-west-2
Default output format [None]: json
```

## Autocomplete
- https://docs.aws.amazon.com/pt_br/cli/latest/userguide/cli-configure-completion.html
 - instalar: apt-get install awscli
 - executar no bash: complete -C '/snap/aws-cli/151/bin/aws_completer' aws

## Serviços S3

`aws s3 help`

- Listar arquivos
  - `aws s3 ls s3://<meu-bucket>`
  - `aws s3api list-objects --bucket <bucket_name>`
  - `aws s3api list-objects --bucket <bucket_name> --query Contents[].[Key,Size]`
  - `aws s3 cp /arquivo.txt s3://<meu-bucket>`
    - aws s3 cp /tmp/foo/ s3://bucket/ --recursive --exclude "*" --include "*.jpg"