# Desafio Mais Todos - Terraform Infrastructure with Django Application

Este repositório contém a configuração do Terraform para provisionar a infraestrutura na AWS, incluindo uma VPC, RDS, ALB, ECR e ECS, juntamente com uma aplicação Django.

## Pré-requisitos

Antes de começar, verifique se você tem os seguintes pré-requisitos instalados:

- Terraform
- AWS CLI configurado com credenciais adequadas
- Docker (opcional para desenvolvimento local)

## Configuração

1. Clone este repositório:

```bash
git clone git@github.com:chriswithH/desafio-maistodos.git
```

2. Navegue até o repositório
```bash
cd desafio-maistodos
```

3. Configure suas credenciais da AWS:

```bash
aws configure
```

## Uso

1. Inicialize o diretório do Terraform:
```bash
terraform init
```

2. Visualize as mudanças planejadas:
```bash
terraform plan
```

3. Aplique as mudanças:
```bash
terraform apply
```

## Para desenvolvimento local da aplicação Django:

Certifique-se de ter o Docker e Docker compose instalados.

1. Navegue até o diretório da aplicação Django:
```bash
cd django-sem-sql
```
2. Execute o seguinte comando para iniciar a aplicação:
```bash
docker-compose up
```
A aplicação estará acessível em http://localhost:8000.


