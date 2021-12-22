resource "aws_internet_gateway" "igw" {
    vpc_id = "${aws_vpc.vpc.id}"
    tags = {
        Name = "terra-igw"
    }
}

resource "aws_route_table" "crt" {
    vpc_id = "${aws_vpc.vpc.id}"
    
    route {
        //associated subnet can reach everywhere
        cidr_block = "0.0.0.0/0" 
        //CRT uses this IGW to reach internet
        gateway_id = "${aws_internet_gateway.igw.id}" 
    }
    
    tags = {
        Name = "terra-crt"
    }
}

resource "aws_route_table_association" "crta"{
    subnet_id = "${aws_subnet.subnet.id}"
    route_table_id = "${aws_route_table.crt.id}"
}

resource "aws_security_group" "sg" {
    vpc_id = "${aws_vpc.vpc.id}"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        // This means, all ip address are allowed to ssh ! 
        // Do not do it in the production. 
        // Put your office or home address in it!
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    tags = {
        Name = "terra-sg"
    }
}