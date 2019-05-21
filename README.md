# Google Service Account Terraform Module

Terraform module which creates service accounts on Google Cloud Platform, and assigns project roles to it.
These roles are assigned in a non-authoritative manner (they won't affect other roles or service accounts).


## Usage

```hcl
module my_service_account {
  source = "garbetjie/service-account/google"
  
  account_id = "my-service-account"
  roles = ["compute.instances.delete", "compute.instances.list"]
  display_name = "My Service Account"
  display_name_suffix = " (managed by terraform)"
}
```

### With custom roles

It is also possible to use this module with custom roles:

```hcl
data google_project project {

}

resource google_project_iam_custom_role my_custom_role {
  permissions = ["compute.instances.delete"]
  role_id = "my.custom.role"
  title = "Custom Role"
}

module my_service_account {
  source = "garbetjie/service-account/google"
  
  account_id = "my-service-account"
  roles = ["projects/${data.google_project.project.project_id}/roles/${google_project_iam_custom_role.my_custom_role.role_id}"]
}
```


## Inputs

| Name                | Description                                                                               | Type   | Default                     | Required |
|---------------------|-------------------------------------------------------------------------------------------|--------|-----------------------------|----------|
| account_id          | The unique ID of the service account, used to create the service account's email address. | string | n/a                         | Yes      |
| roles               | A list of roles to assign to the service account.                                         | list   | n/a                         | Yes      |
| display_name        | The display name of the service account to show.                                          | string | `${var.account_id}`         | No       |
| display_name_suffix | The string to append to the display name.                                                 | string | `" (managed by terraform)"` | No       |


## Outputs

| Name       | Description                                    |
|------------|------------------------------------------------|
| email      | Full email address of the service account.     |
| account_id | Account ID used to generate the email address. |
| unique_id  | Unique ID of the service account.              |
