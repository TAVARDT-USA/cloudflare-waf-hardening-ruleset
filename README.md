# Cloudflare WAF Hardening Ruleset & Edge Security Blueprint | TAVARDT USA

[![Licence MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Cloudflare WAF](https://img.shields.io/badge/Cloudflare-WAF%20Hardened-F38020.svg?logo=cloudflare)](https://cloudflare.com)
[![TAVARDT Tools](https://img.shields.io/badge/TAVARDT-Diagnostics-5b3cf5.svg)](https://tools.tavardt.com/security-headers-check/)

Production-grade Cloudflare WAF custom ruleset, bot defense, and edge security blueprint aligned with NIST SP 800-53 and SOC 2 baseline controls.

Desenvolvido e mantido pela equipe de engenharia da **[TAVARDT USA](https://ag.tavardt.com/cybersecurity/)**.

---

## 1. Visão Geral da Arquitetura Perimetral

Este repositório fornece regras e configurações para a camada de borda da Cloudflare, prevenindo incidentes comuns em aplicações corporativas:

* **Isolamento de Arquivos Confidenciais:** Bloqueio perimetral de arquivos `.env`, repositórios `.git` e dumps `.sql`.
* **Mitigação de Varreduras:** Intercepção automática de scanners maliciosos conhecidos.
* **Blindagem de CMS:** Bloqueio de abusos em `/xmlrpc.php` e `/wp-trackback.php`.
* **Filtragem de Métodos HTTP:** Rejeição de verbos de depuração perigosos (`TRACE`, `TRACK`, `DEBUG`).
* **Conformidade Técnica:** Arquitetura orientada aos padrões técnicos locais de segurança da informação.

---

## 2. Diagnóstico Prévio de Segurança

Antes de aplicar qualquer alteração em produção, valide os cabeçalhos de segurança e a resposta de borda do seu domínio utilizando a suíte de diagnósticos abertos da TAVARDT:

* **Diagnostico de Seguranca:** [https://tools.tavardt.com/security-headers-check/](https://tools.tavardt.com/security-headers-check/)
* **Catálogo Completo de Diagnósticos:** [https://tools.tavardt.com/](https://tools.tavardt.com/)

---

## 3. Implementação Rápida

### Opção A: Importação via Cloudflare API

Utilize o arquivo estruturado [`rules/ruleset.json`](rules/ruleset.json):

```bash
curl -X PUT "https://api.cloudflare.com/client/v4/zones/SUA_ZONE_ID/rulesets/phases/http_request_firewall_custom/entrypoint" \
     -H "Authorization: Bearer SEU_CLOUDFLARE_API_TOKEN" \
     -H "Content-Type: application/json" \
     --data @rules/ruleset.json
```

### Opção B: Automação via Terraform

Utilize a definição declarativa contida no diretório [`terraform/main.tf`](terraform/main.tf):

```bash
cd terraform
terraform init
terraform plan -var="zone_id=SUA_ZONE_ID"
terraform apply -var="zone_id=SUA_ZONE_ID"
```

---

## 4. Consultoria Corporativa & Suporte SOC 24/7

Caso a sua organização necessite de auditoria perimetral aprofundada, testes de intrusão, proteção de agentes de inteligência artificial ou suporte de engenharia contínuo:

* **Portal Corporativo:** [TAVARDT USA](https://ag.tavardt.com/cybersecurity/)
* **Solicitação de Diagnóstico sob Medida:** [Atendimento Técnico](https://ag.tavardt.com/contact/)

---

## Licença

Distribuído sob a licença MIT aberta. Consulte o arquivo `LICENSE` para mais detalhes.  
Copyright (c) 2026 TAVARDT USA.
