terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

resource "aws_route53_zone" "this" {
  delegation_set_id = var.delegation_set_id
  name              = var.domain_name
}

resource "aws_route53_record" "soa" {
  zone_id         = aws_route53_zone.this.zone_id
  name            = var.domain_name
  type            = "SOA"
  ttl             = "86400"
  records         = ["${aws_route53_zone.this.name_servers.0}. ${replace(var.admin_email, "@", ".")}. 1 7200 900 1209600 3600"]
  allow_overwrite = true
}

resource "aws_route53_record" "caa" {
  zone_id = aws_route53_zone.this.zone_id
  name    = var.domain_name
  type    = "CAA"
  ttl     = "86400"

  records = concat(
    formatlist("0 issue \"%s\"", var.caa_list),
    [
      "0 issuewild \";\"",
      format("0 iodef \"mailto:%s\"", var.admin_email),
    ],
  )

  count = length(var.caa_list) == 0 ? 0 : 1
}

resource "aws_route53_record" "mx" {
  zone_id = aws_route53_zone.this.zone_id
  name    = var.domain_name
  type    = "MX"
  ttl     = "86400"

  records = var.mx_list
}

resource "aws_route53_record" "txt" {
  zone_id = aws_route53_zone.this.zone_id
  name    = var.domain_name
  type    = "TXT"
  ttl     = "86400"
  records = var.spf_list
}

resource "aws_route53_record" "dkim" {
  zone_id = aws_route53_zone.this.zone_id
  name    = "${var.dkim_prefix}._domainkey"
  type    = "TXT"
  ttl     = "3600"
  records = [join(
    "\"\"",
    [
      substr(local.dkim_config, 0, 255),
      substr(local.dkim_config, 255, -1),
    ],
  )]

  count = length(var.dkim_config) > 0 ? 1 : 0
}

resource "aws_route53_record" "dmarc" {
  zone_id = aws_route53_zone.this.zone_id
  name    = "_DMARC"
  type    = "TXT"
  ttl     = "86400"
  records = [
    "v=DMARC1; p=reject; rua=mailto:${var.dmarc_address}; ruf=mailto:${var.dmarc_address}; fo=1; pct=100; aspf=s; adkim=s"
  ]

  count = length(var.dmarc_address) > 0 ? 1 : 0
}
