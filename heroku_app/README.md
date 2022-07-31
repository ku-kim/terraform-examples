# Infra Provisioning for BE

### Infra Architecture

- Heroku 단일 앱서버

### RUN

- 준비물
  - install Teraform
  - Heroku
    - heroku email
    - heroku private api key
    - heroku app name

```bash
# terraform setup
terraform init

# terraform 계획 확인
terraform plan

# terraform 프로비저닝 적용
terraform apply

# 프로비저닝 자원 제거
terraform destroy
```

### Reference

- https://registry.terraform.io/providers/heroku/heroku/latest/docs
- https://www.heroku.com/
