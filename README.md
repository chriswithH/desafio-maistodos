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

## Para atualizar a aplicação Django:

Certifique-se de ter o Docker e Docker compose instalados.

1. Navegue até o diretório da aplicação Django:
```bash
cd app
```
2. Configure suas credenciais da AWS:

```bash
aws configure
```

3. Faça suas alterações e envie uma nova versão da imagem para o ECR
```bash
aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 590183821071.dkr.ecr.us-east-2.amazonaws.com
docker build -t django-app .    
docker tag django-app:latest 590183821071.dkr.ecr.us-east-2.amazonaws.com/django-app:latest
docker push 590183821071.dkr.ecr.us-east-2.amazonaws.com/django-app:latest
```


## CI/CD
Este repositório inclui integração e entrega contínuas (CI/CD) para o Terraform usando GitHub Actions. As ações estão configuradas no arquivo .github/workflows/terraform-cicd.yml.