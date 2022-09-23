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
  }
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
      error_message = "org name failed"
    }
    postcondition {
      condition = self.value == "test_Var"
      error_message = "org name failed"
    }
  }
}

