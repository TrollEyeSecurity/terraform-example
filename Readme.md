## Terraform Infrastructure As Code (IaC)

This repository can be used to build Development, UAT, and Production environments in AWS, using Terraform Cloud.

Terraform Cloud URL: https://app.terraform.io/app/

The `.tf` files are broken up to add a better understanding of what the modules are for.
When the monitored branch is modified, Terraform Cloud receives a webhook and kicks of a `terraform plan`. When the plan
is complete, it is up to team member to review the plan in Terraform, and approve or deny the change. When the team member
approves the change, `terraform apply` is automatically executed on the plan.

__1) Set the variables as follows:__

Browse to the workspaces URL. Click on a workspace name (ie: infrastructure-development-environment), and select the variables on the left.

Click Add Variable, and choose the __HCL__ checkbox. If the variable is sensitive, like an AWS secret choose the __secret__ checkbox.

From the examples below, the key is the value before the '=', and the value is the full value including the '{}'.
```
ssh-key = {
  default = "ssh-rsa SSH-PVT-KEY"
}

instance_type = {
    default = {
        jump-box = "t3a.micro"
        ccscanner = "t3a.large"
        redis-cache = "cache.t3.micro"
        mq = "mq.t3.micro"
    }
}
aws-region = {
    us-east-1 = "us-east-1"
}
aws-az = {
    us-east-1a = "us-east-1a"
    us-east-1b = "us-east-1b"
    us-east-1c = "us-east-1c"
}

management_addrs = {
    default = {
        cidr_block: [
            "IPADDR/32",
        ]
    }
}

tenancy = {
    default = "default"
}

aws-access-key = {
    default = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}
aws-secret-key = {
    default = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

env = {
    name = "development"
    shortname = "dev"
}

mongodb = {
    public_key = "PUBLIC_KEY"
    atlas_org_id = "ATLAS_ORG_ID"
    atlas_project_name = "development-db"
    environment = "development"
    cluster_instance_size_name = "M10"
    atlas_region = "US_EAST_1"
    mongodb_version = "7.0"
    mongodb_user = "mongodb-user"
    cloud_provider = "AWS"
    backups = true
}

mongodb-secrets = {
    private_key = "PRIVATE_KEY"
    mongodb_password = "RANDOM_PASSWORD"
}
```

__2) Setup Version Control__

On the left side, choose settings, then version control. In this setting, you can change how terraform reacts to the webhook.
You can disable automatic `plans` and make this a manual process.