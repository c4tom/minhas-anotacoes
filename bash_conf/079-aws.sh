
if [[ ! -f /usr/bin/aws ]] 
then
	ct_awsInstall() {
		sudo snap install aws-cli --classic
        sudo apt-get install awscli
	}
fi

# https://docs.aws.amazon.com/pt_br/cli/latest/userguide/cli-configure-envvars.html
export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""
export AWS_DEFAULT_REGION="us-west-1"

ct_awsSetKeys() {
    local KEY=$1
    local SEC=$2
    local REG=$3
    local BUK=$4

    export AWS_ACCESS_KEY_ID="$1"
    export AWS_SECRET_ACCESS_KEY="$2"
    export AWS_BUCKET="$4";
    export AWS_DEFAULT_REGION="$3"
}

ct_awsSetKeyFromCredentialFile() {
    if [ -z "$1" ] 
        then
            echo "Informe o nome do bucket: "
            read AWS_BUCKET
            export AWS_BUCKET
        else
            export AWS_BUCKET="$1";
        fi

    export AWS_SECRET_ACCESS_KEY=`ct_parseINI ~/.aws/credentials default aws_secret_access_key`
    export AWS_ACCESS_KEY_ID=`ct_parseINI ~/.aws/credentials default aws_access_key_id`
    export AWS_DEFAULT_REGION=`ct_parseINI ~/.aws/config default region`
}

ct_awsAutoComplete() {
    complete -C '/snap/aws-cli/151/bin/aws_completer' aws
}


