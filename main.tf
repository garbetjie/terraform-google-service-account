resource google_service_account account {
  account_id = var.account_id
  display_name = local.display_name
}

resource google_project_iam_member roles {
  count = length(var.roles)
  member = "serviceAccount:${google_service_account.account.email}"
  role = var.roles[count.index]
}
