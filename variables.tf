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
    "1 smtp.google.com.",
  ]
}

variable "spf_list" {
  description = "SPF record list (defaults to Google Apps)"
  type        = list(any)

  default = [
    "v=spf1 a include:_spf.google.com -all",
  ]
}

variable "dkim_config" {
  description = "DKIM configuration string"
  type        = string

  default = ""
}

variable "dkim_prefix" {
  description = "DKIM record prefix"
  type        = string

  default = "google"
}

variable "dmarc_address" {
  description = "DMARC report address"
  type        = strng

  default = ""
}
