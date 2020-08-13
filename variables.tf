variable roles {
  type = set(string)
  description = "A list of roles to assign to the service account"
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
}
