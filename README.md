# Cloudflare WAF Hardening Ruleset & Edge Security Blueprint

[![Licence MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Cloudflare WAF](https://img.shields.io/badge/Cloudflare-WAF%20Hardened-F38020.svg?logo=cloudflare)](https://cloudflare.com)
[![Language](https://img.shields.io/badge/Language-English%20(US)-green.svg)](README.md)
[![Diagnostics Suite](https://img.shields.io/badge/TAVARDT-Diagnostics-5b3cf5.svg)](https://tools.tavardt.com/security-headers-check/)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

Production-grade Cloudflare WAF custom ruleset, bot defense, and edge security blueprint aligned with NIST SP 800-53 and SOC 2 baseline controls.

Engineered and maintained by the infrastructure and perimeter security team at **TAVARDT**.

> [!IMPORTANT]
> **Universal & Stack-Agnostic Architecture:** This repository is **not exclusive to WordPress**. It is engineered to safeguard **modern REST APIs, microservices, frontend applications (Next.js, React, Vue), and enterprise backends (Node.js, Python/Django/FastAPI, Go, Laravel, Java)**. Blocking legacy CMS probes operates as an **active edge hygiene layer**, dropping automated botnet noise directly at Cloudflare edge data centers (< 1ms) before malicious requests can consume TCP connections, memory, or CPU on your origin servers.

***

### Multi-Stack Defense Matrix

| Defense Layer | Mitigated Vectors | Protected Applications & Stacks |
| :- | :- | :- |
| **Credential Isolation** | Immediate block for `.env`, `.git`, `.sql`, `package.json`, `composer.json` | **APIs, Next.js, Node.js, Python, Go, Laravel, React** |
| **Reconnaissance Suppression** | Block Nikto, SQLMap, Acunetix, Masscan, Gobuster, Nmap probes | **Any public web application, microservice, or API** |
| **HTTP Verb Sanitization** | Rejection of non-essential debug verbs (`TRACE`, `TRACK`, `DEBUG`) | **Production RESTful APIs and API Gateways** |
| **Privileged Route Gating** | Managed challenges on sensitive administration paths (`/admin`, `/login`) | **Internal dashboards, administration portals, web ERPs** |
| **Zero-Noise Edge Hygiene** | Edge drop for blind legacy CMS scans (`/xmlrpc.php`, trackbacks) | **Immediate origin CPU and connection overhead relief** |

***

## 1. Edge Architecture Overview

This repository delivers an battle-tested, production-grade ruleset for Cloudflare edge firewalls, mitigating automated recon, brute force attempts, and critical data exposure vectors:

* **Sensitive File & Credential Isolation:** Immediate edge block for requests accessing `.env` configurations, `.git` metadata trees, `.sql` dumps, and package manifests (`composer.json`, `package.json`).
* **Automated Recon & Vulnerability Scanner Mitigation:** Real-time edge suppression of known reconnaissance engines (Nikto, SQLMap, Acunetix, Masscan, Nmap, Gobuster, DirBuster).
* **CMS Attack Surface Hardening:** Edge termination of high-frequency abuse targets including `/xmlrpc.php` and `/wp-trackback.php`.
* **Dangerous HTTP Method Rejection:** Strict blocking of non-essential debug verbs (`TRACE`, `TRACK`, `DEBUG`) at the CDN boundary.
* **Managed Challenge on Privileged Endpoints:** Autonomous challenge gating for sensitive administration paths (`/wp-login.php`, `/admin`).

***

## 2. Pre-Deployment Security Diagnostic

Prior to rolling out edge rules in production, benchmark your current security headers and SSL posture using TAVARDT's open diagnostics suite:

* **Security Headers & Edge Posture Audit:** **TAVARDT Security Headers Analyzer**
* **Complete Web & Infrastructure Diagnostics:** **TAVARDT Tools Suite**

***

## 3. Rapid Deployment Guide

### Option A: Direct Ingestion via Cloudflare API v4

Deploy the declarative ruleset using [`rules/ruleset.json`](rules/ruleset.json):

```bash
curl -X PUT "https://api.cloudflare.com/client/v4/zones/YOUR_ZONE_ID/rulesets/phases/http_request_firewall_custom/entrypoint" \
     -H "Authorization: Bearer YOUR_CLOUDFLARE_API_TOKEN" \
     -H "Content-Type: application/json" \
     -data @rules/ruleset.json
```

### Option B: Declarative Provisioning via Terraform

Utilize the production-ready Terraform module located in [`terraform/main.tf`](terraform/main.tf):

```bash
cd terraform
terraform init
terraform plan -var="zone_id=YOUR_ZONE_ID"
terraform apply -var="zone_id=YOUR_ZONE_ID"
```

***

## 4. Security Engineering & SOC Advisory

If your organization requires comprehensive penetration testing, SOC 2 compliance verification, autonomous agent safeguarding, or round-the-clock incident engineering:

* **Corporate Portal:** **TAVARDT**
* **Direct Technical Advisory:** [Contact Engineering Team](https://ag.tavardt.com/contact/)

***

## Governance and Sovereignty

* **Sovereign Unit**: [TAVARDT United States](https://ag.tavardt.com/) (`TAVARDT-USA`)
* **Core Standards**: [00-core Governance](https://github.com/TAVARDT-USA/00-core)
* **Diagnostic Portal**: [TAVARDT US Diagnostic Suite](https://tools.tavardt.com/)
* **Enterprise Security**: [TAVARDT US Cybersecurity](https://ag.tavardt.com/cybersecurity/)

***

## License

Released under the open-source MIT License. Review the [`LICENSE`](LICENSE) file for full terms.  
Copyright

***

© 2026 TAVARDT. All rights reserved.
