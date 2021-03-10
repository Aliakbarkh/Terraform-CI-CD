resource "aws_subnet" "private" {
  vpc_id     = aws_instance.main.id 
  cidr_block = "10.0.1.0/24"
 
  tags = { 
    Environment = "development" 
    Access = "private" 
  } 
} 
 
resource "aws_subnet" "public" {  
  vpc_id     = aws_instance.main.id 
  cidr_block = "10.0.2.0/24" 
 
  tags = { 
    Environment = "development" 
    Access = "public" 
  } 
} 
