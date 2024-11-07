resource "random_integer" "random" {
    min = 1
    max = 10
}


resource "aws_vpc" "complex_vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
        Name = "vpc-${var.environment}"
        Environment = var.environment
    }

    lifecycle {
        create_before_destroy = true
    }
}

data "aws_availability_zones" "available" {}

resource "aws_internet_gateway" "complex_igw" {
    vpc_id = aws_vpc.complex_vpc.id

    tags = {
        Name = "igw-${var.environment}"
        Environment = var.environment
    }
}

resource "aws_subnet" "complex_public_subnets" {
    count = var.public_sn_count
    vpc_id = aws_vpc.complex_vpc.id
    cidr_block = "10.0.${count.index + 1}.0/24"
    map_public_ip_on_launch = true
    availability_zone = data.aws_availability_zones.available.names[count.index]

    tags = {
        Name = "public_subnet-${count.index + 1}-${var.environment}"
        Environment = var.environment
    }
}

resource "aws_route_table" "complex_pub_rt" {
    vpc_id = aws_vpc.complex_vpc.id
    tags = {
        Name = "complex-pub-rt-${var.environment}"
        Environment = var.environment
    }
}

resource "aws_route" "complex_pub_route" {
    route_table_id = aws_route_table.complex_pub_rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.complex_igw.id
}

resource "aws_route_table_association" "complex_pub_rt_assoc" {
  count = var.public_sn_count
  subnet_id = aws_subnet.complex_public_subnets.*.id[count.index]
  route_table_id = aws_route_table.complex_pub_rt.id
}

resource "aws_eip" "complex_nat_eip" {
    domain = "vpc"

    tags = {
      Name = "eip-${var.environment}"
      Environment = var.environment
    }
}

resource "aws_nat_gateway" "complex_ngw" {
    allocation_id = aws_eip.complex_nat_eip.id
    subnet_id = aws_subnet.complex_public_subnets[0].id

    tags = {
        Name = "complex-ngw-${var.environment}"
        Environment = var.environment
    }
}

resource "aws_subnet" "complex_private_subnets" {
    count = var.private_sn_count
    vpc_id = aws_vpc.complex_vpc.id
    cidr_block = "10.0.${count.index + 3}.0/24"
    map_public_ip_on_launch = false
    availability_zone = data.aws_availability_zones.available.names[count.index]

    tags = {
        Name = "complex-private-${count.index + 5}-${var.environment}"
        Environment = var.environment
    }
}

resource "aws_route_table" "complex_private_rt" {
  vpc_id = aws_vpc.complex_vpc.id

  tags = {
    Name = "complex-private-rt-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_route" "complex_private_route" {
  route_table_id = aws_route_table.complex_private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.complex_ngw.id
}

resource "aws_route_table_association" "complex_private_rt_assoc" {
  count = var.private_sn_count
  route_table_id = aws_route_table.complex_private_rt.id
  subnet_id = aws_subnet.complex_private_subnets.*.id[count.index]
}

resource "aws_subnet" "complex_db_subnets" {
  count = var.private_sn_count
  vpc_id = aws_vpc.complex_vpc.id
  cidr_block = "10.0.${count.index + 5}.0/24"
  map_public_ip_on_launch = false
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "complex_db_${count.index + 5}-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_route_table" "complex_db_rt" {
  vpc_id = aws_vpc.complex_vpc.id

  tags = {
    Name = "complex_db_rt-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_route" "complex_db_route" {
  route_table_id = aws_route_table.complex_db_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.complex_ngw.id
}

resource "aws_route_table_association" "complex_db_rt_assoc" {
  count = var.private_sn_count
  route_table_id = aws_route_table.complex_db_rt.id
  subnet_id = aws_subnet.complex_db_subnets.*.id[count.index]
}

resource "aws_db_subnet_group" "complex_rds_subnetgroup" {
  count      = var.db_subnet_group == true ? 1 : 0
  name       = "complex_rds_subnetgroup"
  subnet_ids = [aws_subnet.complex_db_subnets[0].id, aws_subnet.complex_db_subnets[1].id]

  tags = {
    Name = "complex_rds_sng-${var.environment}"
    Environment = var.environment
  }
}



