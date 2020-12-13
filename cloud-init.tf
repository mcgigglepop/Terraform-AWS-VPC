# cloud init config data resource
data "template_cloudinit_config" "cloud-init" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = data.template_file.cloud-init.rendered
  }

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.shell-script.rendered
  }
}

# Cloud Init Template File Resource
data "template_file" "cloud-init" {
  template = file("${path.module}/cloud-init.cfg")
}

# Shell Script Used on Deployment
data "template_file" "shell-script" {
  template = file("${path.module}/cloud-init.sh")
}