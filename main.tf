terraform {
  backend "local" {
    path = "/terrafun/terraform.tfstate"
  }

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  count = 0
  image = docker_image.nginx.latest
  name  = "from-atlantis"
  ports {
    internal = 80
    external = 8040
  }
}
