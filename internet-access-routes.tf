# Internet Access Route A
resource "aws_route" "internet_access_route_a" {
  route_table_id         = "${aws_route_table.public_route_table_a.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.internet_gateway.id}"
}

# Internet Access Route B
resource "aws_route" "internet_access_route_b" {
  route_table_id         = "${aws_route_table.public_route_table_b.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.internet_gateway.id}"
}