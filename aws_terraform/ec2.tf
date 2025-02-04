# EC2 instance configuration
resource "aws_instance" "tf_server" {
  ami                         = "ami-00bb6a80f01f03502" # change according to region, you can get from creation page
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id] # associate security group
  associate_public_ip_address = true
  key_name                    = "tf_mysql_node_key_pair" # private aws key name
  user_data                   = <<-EOF
                                #!/bin/bash

                                # Git clone 
                                git clone https://github.com/maniadav/tf_mysql_node.git /home/ubuntu/tf_mysql_node
                                cd /home/ubuntu/tf_mysql_node

                                # install nodejs
                                sudo apt update -y
                                sudo apt install -y nodejs npm

                                # edit env vars
                                echo "DB_HOST=${local.rds_endpoint}" | sudo tee .env
                                echo "DB_USER=${aws_db_instance.tf_rds_instance.username}" | sudo tee -a .env
                                sudo echo "DB_PASS=${aws_db_instance.tf_rds_instance.password}" | sudo tee -a .env
                                echo "DB_NAME=${aws_db_instance.tf_rds_instance.db_name}" | sudo tee -a .env
                                echo "TABLE_NAME=users" | sudo tee -a .env
                                echo "PORT=3000" | sudo tee -a .env

                                # start server
                                npm install
                                EOF
  depends_on                  = [aws_s3_bucket.tf_s3_bucket] # attach s3 bucket

  tags = {
    Name = "nodejs-server"
  }
}
