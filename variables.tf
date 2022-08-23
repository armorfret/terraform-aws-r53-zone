variable "domain_name" {
  description = "Domain name for which to create a zone"
  type        = string
}

variable "admin_email" {
  description = "Email used for SOA record"
  type        = string
}

variable "delegation_set_id" {
  description = "Delegation set ID to reuse"
  type        = string
}

variable "caa_list" {
  description = "List of issuers allowed to sign certificates for this zone (defaults to AWS ACM)"
  type        = list(any)

  default = [
    "amazon.com",
  ]
}

variable "mx_list" {
  description = "MX record list (defaults to Google Apps MX list)"
  type        = list(any)

  default = [
    "1   aspmx.l.google.com.",
    "5   alt1.aspmx.l.google.com.",
    "5   alt2.aspmx.l.google.com.",
    "10  aspmx2.googlemail.com.",
    "10  aspmx3.googlemail.com.",
  ]
}

variable "spf_list" {
  description = "SPF record list (defaults to Google Apps)"
  type        = list(any)

  default = [
    "v=spf1 a include:_spf.google.com ~all",
  ]
}
