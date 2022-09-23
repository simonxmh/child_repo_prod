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
      condition     = self.organization == "Shouldfail"
      error_message = "org name failed"
    }


    postcondition {
      condition     = self.organization == var.organization
      error_message = "org name failed another time"
    }
  }
}

