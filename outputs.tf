output email {
  value = google_service_account.account.email
  description = "The service account's email address"
}

output account_id {
  value = google_service_account.account.account_id
  description = "The account ID used to generate the service account's email address"
}

output unique_id {
  value = google_service_account.account.unique_id
  description = "The unique ID of the service account"
}
