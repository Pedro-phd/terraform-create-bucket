# 🪣 AutoBucket – Criação Automática de Buckets com Issues + Terraform

![Terraform](https://img.shields.io/badge/Terraform-1.6+-5C4EE5?logo=terraform)
![AWS](https://img.shields.io/badge/AWS-S3-FF9900?logo=amazonaws&logoColor=white)
![GitHub Actions](https://img.shields.io/github/actions/workflow/status/seu-usuario/autobucket/issue-bucket.yml?label=Auto%20Bucket%20CI)

## 🚀 Visão Geral

Este projeto permite criar **buckets S3 automaticamente ao abrir uma issue** no GitHub, utilizando **Terraform** + **GitHub Actions**. Ideal para equipes que desejam provisionar recursos sob demanda, com fluxo de infraestrutura como código e integração com repositórios.

---

## 📦 O que está incluso?

- 🎯 Bucket S3 criado via Terraform
- 🧠 GitHub Action que escuta `issues` e executa o Terraform
- 🔒 Permissões e segurança integradas
- 📁 Cada bucket é nomeado de acordo com o título da issue (slug)
