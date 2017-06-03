# Terraform Azure

## Prerequisites

 1. Install [Terraform](https://www.terraform.io/intro/getting-started/install.html).

 1. Install [Azure CLI](https://docs.microsoft.com/cs-cz/cli/azure/install-azure-cli).

 1. Follow these [instructions](https://www.terraform.io/docs/providers/azurerm/index.html#to-create-using-azure-cli-) to create Azure credentials then export them to your environment.

    - `ARM_CLIENT_ID`
    - `ARM_CLIENT_SECRET`
    - `ARM_SUBSCRIPTION_ID`
    - `ARM_TENANT_ID`

## Getting Started

 This project orchestrates multiple environments.  By default, commands will rely on `dev` when applied and not specified. These are the environments available:

- `dev` (default)
- `stg`
- `prd`

Let's create `dev` environment:

 1. First, get `dev` modules.

    ```console
    $ make terraform-get env=dev
    ```

    or

    ```console
    $ make terraform-get
    ```

 1. Then generate an execution plan for Terraform.

    ```console
    $ make terraform-plan env=dev
    ```

    Make sure you acknowledge the execution plan before you `apply` the changes.

 1. And now you are ready to orchestrate your environment.

    ```console
    $ make terraform-apply
    ```
