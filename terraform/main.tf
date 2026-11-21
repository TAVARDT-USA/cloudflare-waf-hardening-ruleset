# TAVARDT Cloudflare WAF Hardening Module
terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

variable "zone_id" {
  type        = string
  description = "Cloudflare Zone ID"
}

resource "cloudflare_ruleset" "waf_hardening" {
  zone_id     = var.zone_id
  name        = "TAVARDT WAF Hardening Ruleset"
  description = "Edge perimeter defense ruleset created by TAVARDT"
  kind        = "zone"
  phase       = "http_request_firewall_custom"

  rules {
    action      = "block"
    expression  = "(http.request.uri.path contains \"/.env\" or http.request.uri.path contains \"/.git\" or http.request.uri.path contains \".sql\")"
    description = "Block sensitive credentials and environment files"
    enabled     = true
  }

  rules {
    action      = "block"
    expression  = "(http.user_agent contains \"nikto\" or http.user_agent contains \"sqlmap\" or http.user_agent contains \"masscan\")"
    description = "Block malicious exploit scanners"
    enabled     = true
  }

  rules {
    action      = "block"
    expression  = "(http.request.uri.path contains \"/xmlrpc.php\" or http.request.uri.path contains \"/wp-trackback.php\")"
    description = "Block WordPress XML-RPC vectors"
    enabled     = true
  }
}
