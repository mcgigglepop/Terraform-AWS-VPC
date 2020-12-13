# Explicitly associate the newly created route tables to the private subnets (so they don't default to the main route table)
resource "aws_route_table_association" "private_route_table_association_a" {
  subnet_id      = "${aws_subnet.private_subnet_a.id}"
  route_table_id = "${aws_route_table.private_route_table_a.id}"
}

# Explicitly associate the newly created route tables to the private subnets (so they don't default to the main route table)
resource "aws_route_table_association" "private_route_table_association_b" {
  subnet_id      = "${aws_subnet.private_subnet_b.id}"
  route_table_id = "${aws_route_table.private_route_table_b.id}"
}

# Explicitly associate the newly created route tables to the public subnets (so they don't default to the main route table)
resource "aws_route_table_association" "public_route_table_association_a" {
  subnet_id      = "${aws_subnet.public_subnet_a.id}"
  route_table_id = "${aws_route_table.public_route_table_a.id}"
}

# Explicitly associate the newly created route tables to the public subnets (so they don't default to the main route table)
resource "aws_route_table_association" "public_route_table_association_b" {
  subnet_id      = "${aws_subnet.public_subnet_b.id}"
  route_table_id = "${aws_route_table.public_route_table_b.id}"
}