terraform {
  required_providers {
    tfe = {
      version  = "~> 0.35.0"
    }
  }
}

provider "tfe" {
  hostname = var.hostname
  token = var.token
}

resource "tfe_workspace" "child" {
  organization = var.organization
  name = "child"
}
