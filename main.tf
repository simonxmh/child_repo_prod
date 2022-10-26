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
  count        = 10
  organization = var.organization
  name         = "child-${random_id.child_id}"

  lifecycle {
    postcondition {
      condition     = self.organization == var.organization 
      error_message = "org name failed"
    }
  }
}

resource "random_id" "child_id" {
  byte_length = 8
}

resource "tfe_variable" "test-var" {
  key = "test_var"
  value = var.random_var
  category = "env"
  workspace_id = tfe_workspace.child[0].id
  description = "This allows the build agent to call back to TFC when executing plans and applies"

  lifecycle {
    precondition {
      condition = tfe_workspace.child[0].name == "child-0"
      error_message = "workspace child name precondition failed"
    }
    postcondition {
      condition = self.value == "test_Var"
      error_message = "var name postcondition failed"
    }
  }
}
