terraform {
  required_providers {
    tfe = {
      version  = "~> 0.35.0"
    }
  }
}

provider "tfe" {
  hostname = var.hostname
  token = var.TF_TOKEN_simontest_ngrok_io
}

resource "tfe_workspace" "child" {
  organization = var.organization
  name = "child"
}
