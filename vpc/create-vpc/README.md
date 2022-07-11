# VPC

- - [책 따라하며 배우는 AWS 네트워크 입문 3장 VPC 고급- 저 김원일, 서종호](http://www.yes24.com/Product/Goods/93887402) 2장의 아키텍처를 Terraform으로 구현해보았습니다.
- 아래 그림의 ec2 제외하고 VPC, public/private subnet, 인터넷 게이트웨이/NAT 게이트웨이 구현하는 terraform source 입니다.

![아키텍처](https://i.imgur.com/dR2J1lJ.jpg)

```bash
terraform plan

terraform apply

terraform destroy
```