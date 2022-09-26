output "project" {
  description = "The requested anthem project."
  value = data.google_projects.anthem_project.projects[0]
}
