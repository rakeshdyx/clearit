output "folder" {
  description = "The requested anthem folder."
  value = local.layer == 2 ? data.google_active_folder.l2_folder[0] : data.google_active_folder.l1_folder
}
