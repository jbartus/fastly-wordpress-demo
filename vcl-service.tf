#######################################################################
## a fastly delivery service 
#######################################################################

resource "fastly_service_vcl" "demo_service" {
  name = var.site_name

  domain {
    name = "${var.site_name}.global.ssl.fastly.net"
  }

  backend {
    address        = google_compute_instance.demo_origin_instance.network_interface.0.access_config.0.nat_ip
    name           = "${var.site_name}-origin"
    port           = 443
    override_host  = "${var.site_name}.freetls.fastly.net"
    use_ssl        = "true"
    ssl_check_cert = "false"
  }

  force_destroy = true

  # ignore resources the ngwaf changes
  lifecycle {
    ignore_changes = [
      dictionary,
      dynamicsnippet
    ]
  }
}