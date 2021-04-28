# Terraform Setup

Just an example of one way to build out a VPC and some basic components working inside terraform workspaces.

## How Do I Use It?

First, you will need an account on https://app.terraform.io which will be ok for personal and small-group use (5 users).  After this point you will follow their setup to enable webhooks on the repository you created.

Now that you have the hooks and everything else setup acording to hashicorp documentation, you will want to ensure you change all `terraform.tf` files to support your newly created terraform state backend on app.terraform.io

```
find . -name terraform.tf
```

## Development Workflow

Commits in the repository should kick-start workspaces that match the directory structure save that the `/` is replaced with a `_`.  Examples are in the directory structure created already.

### Directory Structure

```
aws/                 # Service Provider
  + modules/         # Terraform Modules specific to AWS Provider
      + globals/     # Global Data Lookups
  + region/          # Houses all VPC's within a given region (ex: us-east-1)
      + vpc/         # Houses all VPC segments
          + thing/   # This is built to house apps / functions / etc within a vpc
              ------- Workspace = aws_us-east-1_test-vpc_base  # From Sample Code
```

Terraform cloud will require setup to only trigger certain pipelines based on the workspace which can trigger a specific folder structure in its configuration.  Please refer to terraform documentation for this part.
