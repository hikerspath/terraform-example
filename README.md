# Terraform Setup

Just an example of one way to build out an Amazon VPC the way they [recommend](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Scenario2.html) and show some basic concepts for working inside terraform workspaces.

## How Do I Use It?

First, you will need an account on https://app.terraform.io which will be ok for personal and small-group use (5 users).  After this point you will follow [their setup](https://learn.hashicorp.com/tutorials/terraform/cloud-workspace-create) to enable webhooks on the repository you created.

Now that you have the hooks and everything else setup acording to hashicorp documentation, you will want to ensure you change all `terraform.tf` files to support your newly created terraform state backend on app.terraform.io

```
find . -name terraform.tf
```

This repo is setup to use terraform's `Workspaces` with a limited view of a specific directory within the repository.  While tedious on smaller projects, once you hit about 500 resources in AWS, you will appreciate a smaller workspace that contains a very specific sub-group of resources.

## Development Workflow

Push events in the repository should send webhooks to app.terraform.io (once configured to do so).  These webhooks should then trigger terraform workspaces that match the directory structure below save that the `/` is replaced with a `_`.  Examples (base and public-box) are in the `test-vpc` directory structure already.  The default branch of the repository is meant to show what is presently deployed in every region and provider (if you use something other than AWS).

### Directory Structure

```
aws/                 # Service Provider
  + archive/         # We all have it, old code (rename terraform.tf to terraform.tf.NO)
  + modules/         # Terraform Modules specific to AWS Provider
      + globals/     # Global Data Lookups
  + region/          # Houses all VPC's within a given region (ex: us-east-1)
      + vpc/         # Houses all VPC segments
          + thing/   # This is built to house apps / functions / etc within a vpc
              ------- Workspace = aws_region_vpc_thing  # From Sample Code
```

**NOTE**: While terraform cloud will be sent webhooks based on event, your code locations and workspace definitions (code inside the `terraform.tf` files) will pick up when terraform cloud should execute code within that same directory.  Essentially making the workspace trigger based on changes to a specific [folder structure](https://www.terraform.io/docs/cloud/workspaces/settings.html#terraform-working-directory) in its configuration.

**NOTE**: The `thing` folders (because of the [globals](aws/modules/globals) module, `_locals.tf`, and `terraform.tf` file in each) should be capable of duplication between any environment.  This makes spinning up a development vpc SUPER easy.  To help in this, it is best (outside of the `_locals.tf` file, not have any region / vpc specific lingo or hard-coded values.

### Pull Request /vs/ Push

It is a great idea to stage your pull requests to trigger a `terraform plan` so that you can preview what is going to happen on merge of the same.  Then the push event (what happens when you merge a PR) will perform the `terraform apply` of the code you submitted.

## Reference

* https://www.terraform.io/docs/cloud
* https://registry.terraform.io/providers/hashicorp/aws/latest
* https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
* https://registry.terraform.io/modules/terraform-aws-modules/route53/aws/latest
