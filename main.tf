resource google_service_account account {
  account_id = var.account_id
  display_name = local.display_name
}

resource google_project_iam_member roles {
  for_each = local.project_roles
  member = "serviceAccount:${google_service_account.account.email}"
  role = each.value
}
