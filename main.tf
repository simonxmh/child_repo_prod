terraform {
  required_providers {
    tfe = {
      version = "~> 0.35.0"
    }
  }
}

provider "tfe" {
  hostname = var.hostname
}

resource "tfe_workspace" "child" {
  count        = 5
  organization = var.organization
  name         = "child-${count.index}"

  lifecycle {
    postcondition {
      condition     = self.organization == "my org"
      error_message = "org name failure"
    }

    postcondition {
      condition     = self.organization == "my org 2222"
      error_message = "second org name failure"
    }
  }
}
