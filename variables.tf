variable "domain_name" {
  type = "string"
}

variable "admin_email" {
  type = "string"
}

variable "delegation_set_id" {
  type = "string"
}

variable "caa_list" {
  type = "list"

  default = [
    "amazon.com",
  ]
}

variable "mx_list" {
  type = "list"

  default = [
    "1   aspmx.l.google.com.",
    "5   alt1.aspmx.l.google.com.",
    "5   alt2.aspmx.l.google.com.",
    "10  aspmx2.googlemail.com.",
    "10  aspmx3.googlemail.com.",
  ]
}

variable "spf_list" {
  type = "list"

  default = [
    "v=spf1 a include:_spf.google.com ~all",
  ]
}
