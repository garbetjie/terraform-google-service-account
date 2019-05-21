variable roles {
  type = "list"
}

variable account_id {
  type = "string"
}

variable display_name {
  type = "string"
  default = ""
}

variable display_name_suffix {
  type = "string"
  default = " (managed by terraform)"
}

locals {
  display_name = "${coalesce(var.display_name, var.account_id)}${var.display_name_suffix}"
}
