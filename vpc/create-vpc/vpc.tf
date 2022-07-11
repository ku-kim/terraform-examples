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

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id

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