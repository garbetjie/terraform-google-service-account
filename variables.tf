variable project_roles {
  type = set(string)
  default = []
  description = "A list of project-wide roles to assign to the service account"
}

variable account_id {
  type = string
  description = "The unique ID of the service account, used to create the service account's email address"
}

variable display_name {
  type = string
  default = ""
  description = "Display name of the service account to show"
}

variable display_name_suffix {
  type = string
  default = " (managed by terraform)"
  description = "String to append to the display name"
}

locals {
  display_name = "${coalesce(var.display_name, var.account_id)}${var.display_name_suffix}"

  project_roles = toset(concat(
    [for role in var.project_roles:
      role
    if substr(role, 0, 9) == "projects/" || substr(role, 0, 14) == "organizations/"],

    [for role in var.project_roles:
      "roles/${trimprefix(role, "roles/")}"
    if substr(role, 0, 9) != "projects/" && substr(role, 0, 14) != "organizations/"]
  ))
}
