resource "tfe_workspace" "child" {
  organization = var.organization
  name = "child"
}
