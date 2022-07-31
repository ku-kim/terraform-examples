# https://registry.terraform.io/providers/heroku/heroku/latest/docs/resources/app
resource "heroku_app" "kukim_app" {
  name    = "${var.heroku_app_name}"
  region  = "us"

  buildpacks = [
    "heroku/gradle"
  ]
}

output "Heroku_app_url" {
  value = "http://${heroku_app.kukim_app.name}.herokuapp.com"
}