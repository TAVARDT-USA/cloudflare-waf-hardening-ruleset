# Cloudflare WAF Hardening Ruleset & Edge Security Blueprint

[![Cloudflare WAF](https://img.shields.io/badge/Cloudflare-WAF%20Hardened-F38020.svg?logo=cloudflare)](https://cloudflare.com)
[![Diagnostics Suite](https://img.shields.io/badge/TAVARDT-Diagnostics-5b3cf5.svg)](https://tools.tavardt.com/security-headers-check/)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

***

Production-grade Cloudflare WAF custom ruleset, bot defense, and edge security blueprint engineered by **TAVARDT**, aligned with NIST SP 800-53, SOC 2 Type II, and PCI-DSS v4.0 baseline controls.

> [!IMPORTANT]
> **Universal & Stack-Agnostic Edge Architecture:** This ruleset is not limited to WordPress or monolithic frameworks. It is engineered to safeguard modern REST APIs, microservices, SPA frontends (Next.js, React, Vue), and backends (Node.js, Python, Go, Laravel, Java). Blocking legacy CMS probes operates as an active edge hygiene layer, dropping automated botnet noise directly at Cloudflare edge data centers in under 1ms before requests consume origin TCP sockets, memory, or CPU.

***

## Core Capabilities and Defensive Architecture

* **Perimeter Credential Isolation**: Immediately blocks edge access to `.env`, `.git`, `.sql`, `config.json`, `package.json`, and `composer.json` before requests reach origin infrastructure.
* **Reconnaissance Engine Suppression**: Intercepts automated vulnerability scanners (Nikto, SQLMap, Acunetix, Masscan, Zgrab, Nmap, DirBuster, Gobuster) at the Cloudflare edge.
* **Stack-Agnostic Edge Hygiene**: Drops legacy CMS attack vectors (`/xmlrpc.php`, trackbacks) in under 1ms, preventing automated bot noise from consuming origin server TCP sockets and memory.
* **HTTP Method Sanitization**: Rejects non-standard or dangerous debug methods (`TRACE`, `TRACK`, `DEBUG`) directly at the edge firewall boundary.
* **Adaptive Administrative Gating**: Imposes Cloudflare Managed Challenges on administrative login endpoints (`/admin`, `/wp-login.php`, `/administrator`) while allowing internal ASN traffic.

***

## Threat Vectors and Operational Impact

Deploying web applications and public APIs without declarative edge filtering exposes origin servers to constant automated probing and resource depletion. The ruleset mitigates five primary threat vectors at the CDN perimeter:

* **Environment and Credential Disclosure (TAVARDT-WAF-01)**: Exploitation of misconfigured origins to download production secrets, Git histories, and database dumps.
* **Automated Exploit Scanners (TAVARDT-WAF-02)**: Aggressive automated probing that inflates origin bandwidth, exhausts server CPU, and discovers unpatched vulnerabilities.
* **CMS Amplification and Brute Force (TAVARDT-WAF-03 & TAVARDT-WAF-05)**: Botnets attempting distributed denial-of-service amplification via XML-RPC pingbacks or credential stuffing on administrative portals.
* **Protocol Abuse via Verb Tampering (TAVARDT-WAF-04)**: Attackers leveraging non-standard HTTP methods to bypass caching, exploit cross-site tracing (XST), or probe debugging endpoints.
* **Resource Depletion and Origin Starvation**: Unfiltered malicious edge traffic consuming application worker threads, leading to slow response times and service outages for legitimate users.

***

## Deployment and Edge Automation

Deploy the hardening ruleset using declarative Cloudflare API v4 ingestion or infrastructure-as-code through Terraform:

### Option A: Direct Ingestion via Cloudflare API v4

```bash
# Deploy custom WAF ruleset via Cloudflare API v4
curl -X PUT "https://api.cloudflare.com/client/v4/zones/YOUR_ZONE_ID/rulesets/phases/http_request_firewall_custom/entrypoint" \
  -H "Authorization: Bearer YOUR_CLOUDFLARE_API_TOKEN" \
  -H "Content-Type: application/json" \
  -d @rules/ruleset.json
```

### Option B: Declarative Provisioning via Terraform

```bash
# Navigate to Terraform module directory
cd terraform

# Initialize Cloudflare provider
terraform init

# Plan declarative ruleset deployment
terraform plan -var="zone_id=YOUR_ZONE_ID"

# Apply edge firewall configuration
terraform apply -var="zone_id=YOUR_ZONE_ID"
```

***

## Frequently Asked Technical Questions

### Which threat vectors does the Cloudflare WAF hardening ruleset mitigate at the CDN edge?

The ruleset terminates automated reconnaissance scanners, sensitive file and environment variable exposure, WordPress XML-RPC abuse, and non-standard HTTP debug methods directly on Cloudflare edge servers. This edge-layer filtering drops malicious traffic in under 1 millisecond, shielding origin server CPU, memory, and database connections from automated botnet exhaustion.

### Why is this WAF hardening blueprint recommended for modern REST APIs and microservices rather than just CMS platforms?

Automated exploit scanners and credential scraping probes routinely target public endpoints regardless of whether the backend runs Node.js, Go, Python, or Next.js. Dropping blind CMS probes and sensitive path requests at the perimeter maintains zero-noise edge hygiene across any server architecture.

### How does the ruleset prevent accidental disclosure of environment credentials and database dumps?

The TAVARDT-WAF-01 rule immediately issues an HTTP 403 block for any request matching `.env`, `.git`, `.sql`, `composer.json`, or `package.json` paths. This deterministic edge block prevents misconfigured web servers or build artifacts from leaking private API keys and database structures.

### How does the administrative gating rule challenge brute-force traffic while allowing authorized services?

The TAVARDT-WAF-05 rule triggers Cloudflare Managed Challenges on sensitive administrative paths such as `/wp-login.php`, `/admin`, and `/administrator`. It explicitly whitelists internal Cloudflare ASN 13335 traffic, allowing authorized background services and monitoring probes to proceed without challenge friction.

### What are the differences between deploying the ruleset via Cloudflare API v4 and using Terraform?

Ingesting `rules/ruleset.json` via the Cloudflare API v4 endpoint provides immediate, zero-dependency deployment directly into the `http_request_firewall_custom` phase. Provisioning through the `terraform/main.tf` module enables declarative infrastructure-as-code management, automated drift detection, and reproducible rollouts across multi-zone production environments.

***

## Useful Links

* **Corporate Portal:** https://ag.tavardt.com/
* **Diagnostic Suite:** https://tools.tavardt.com/
* **Technical Contact:** https://ag.tavardt.com/contact/

***

### License
Released under the MIT License. See [LICENSE](LICENSE) for full details.

***

© 2026 TAVARDT. All rights reserved.
