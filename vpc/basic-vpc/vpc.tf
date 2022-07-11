resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "terraform-kukim-vpc"
    }
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.10.0/24"

    availability_zone = "ap-northeast-2a"

    tags = {
        Name = "terraform-kukim-public-subnet"
    }
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.11.0/24"

    tags = {
        Name = "terraform-kukim-private-subnet"
    }
}


resource "aws_internet_gateway" "igw" {

    vpc_id = aws_vpc.main.id

    tags = {
        Name = "terraform-kukim-igw"
    }
}

resource "aws_eip" "nat" {
    vpc  = true
    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_nat_gateway" "nat_gateway" {
    allocation_id = aws_eip.nat.id

    subnet_id = aws_subnet.private_subnet.id

    tags = {
        Name = "NAT-GW-1"    
    }
}

# inner rule 사용한 public 라우팅테이블 설정 : 게이트웨이 - public 서브넷
## https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "terraform-kukim-rt-public"    
    }
}

resource "aws_route_table" "private" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "terraform-kukim-rt-private"    
    }
}

resource "aws_route_table_association" "route_table_association_public" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "route_table_association_private" {
    subnet_id = aws_subnet.private_subnet.id
    route_table_id = aws_route_table.private.id
}

# 바깥에서 private 라우팅테이블 설정 : NAT - private 서브넷
## inner rule 보단 바깥으로 빼는 것이 확장성이 좋다.
## https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route
resource "aws_route" "private_nat" {

    route_table_id = aws_route_table.private.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
}
