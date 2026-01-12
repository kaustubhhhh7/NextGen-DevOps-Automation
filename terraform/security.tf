# NextGen DevOps - Network Security Foundation (Firewall Rules)

# Public Security Group: Intended for Load Balancers or Gateway Nodes
resource "aws_security_group" "public_sg" {
  name        = "${var.environment}-public-sg"
  description = "Security group for public-facing resources"
  vpc_id      = aws_vpc.main.id

  # Inbound: SSH Access (Restricted to specific CIDR)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_allowed_cidr]
    description = "Allow SSH from restricted CIDR"
  }

  # Inbound: HTTP Access (Public)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP from anywhere"
  }

  # Outbound: All Traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "${var.environment}-public-sg"
  }
}

# Private Security Group: Intended for Backend Application/API Nodes
resource "aws_security_group" "private_sg" {
  name        = "${var.environment}-private-sg"
  description = "Security group for private backend resources"
  vpc_id      = aws_vpc.main.id

  # Inbound: Internal Traffic ONLY from Public Security Group
  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.public_sg.id]
    description     = "Allow all traffic from public-facing security group only"
  }

  # Outbound: All Traffic (Required for patching/updates via NAT)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "${var.environment}-private-sg"
  }
}
