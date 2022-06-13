provider "aws" {
    region = "${var.AWS_REGION}"
    // LINUX
    // shared_config_files = ["~/.aws/config"]
    // WINDOWS
    shared_credentials_files = ["C:/Users/sophi/.aws/creds"]
}