# Google Service Account Terraform Module

Terraform module which creates service accounts on Google Cloud Platform, and assigns project roles to it. These roles
are assigned in a non-authoritative manner, which means they won't affect other roles or service accounts.

## Usage

```hcl
module my_service_account {
  source = "garbetjie/service-account/google"
  
  account_id = "my-service-account"
  roles = ["compute.viewer", "roles/compute.viewer"]
  display_name = "My Service Account"
  display_name_suffix = " (managed by terraform)"
}
```

### With custom roles

It is also possible to use this module with custom roles:

```hcl
resource google_project_iam_custom_role my_custom_role {
  permissions = ["compute.instances.delete"]
  role_id = "my.custom.role"
  title = "Custom Role"
}

module my_service_account {
  source = "garbetjie/service-account/google"
  
  account_id = "my-service-account"
  roles = [google_project_iam_custom_role.my_custom_role.id]
}
```


## Inputs

| Name                | Description                                                                               | Type   | Default                     | Required |
|---------------------|-------------------------------------------------------------------------------------------|--------|-----------------------------|----------|
| account_id          | The unique ID of the service account, used to create the service account's email address. | string | N/A                         | Yes      |
| project_roles       | A list of project-wide roles to assign to the service account.                            | list   | `[]`                        | No       |
| display_name        | The display name of the service account to show.                                          | string | `${var.account_id}`         | No       |
| display_name_suffix | The string to append to the display name.                                                 | string | `" (managed by terraform)"` | No       |


## Outputs

| Name       | Description                                    |
|------------|------------------------------------------------|
| email      | Full email address of the service account.     |
| account_id | Account ID used to generate the email address. |
| unique_id  | Unique ID of the service account.              |
