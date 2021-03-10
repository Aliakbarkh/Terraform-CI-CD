resource "aws_internet_gateway" "igw" { 
  vpc_id = aws_instance.main.id 
 
  tags = { 
    Environment = "development" 
  } 
} 
 
resource "aws_route_table" "public" { 
  vpc_id = aws_instance.main.id 
  route { 
    cidr_block = "0.0.0.0/0" 
    gateway_id = aws_internet_gateway.igw.id 
  } 
  tags = { 
    Environment = "development" 
  } 
} 
 
resource "aws_route_table_association" "public" { 
  subnet_id      = aws_subnet.public.id 
  route_table_id = aws_route_table.public.id 
} 
