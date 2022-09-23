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
      condition     = self.organization == var.organization
      error_message = "org name failed"
    }


    postcondition {
      condition     = self.organization == var.organization
      error_message = "org name failed another time"
    }
  }
}

resource "tfe_variable" "test-var" {
  key = "test_var"
  value = var.random_var
  category = "env"
  workspace_id = tfe_workspace.child.id
  description = "This allows the build agent to call back to TFC when executing plans and applies"
  lifecycle {
    postcondition {
      condition = self.value == "test_Var"
      error_message = "post condition succeeded"
    }
  }
}
