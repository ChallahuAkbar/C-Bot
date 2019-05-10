workflow "Validate Licenses" {
  on = "push"
  resolves = "Licensed Status"
}

action "Licensed Status" {
  uses = "actions/licensed/ruby@master"
  args = "status"
  env = {
    BUNDLER_VERSION = "2.0.1"
  }
}
