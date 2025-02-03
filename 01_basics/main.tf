# simple file resource
resource "local_file" "tf_example1" {
  filename = "/Users/manishyadav/Downloads/terraform_mysql_node_course/01_basics/example-${count.index}.txt"
  content  = "I am trying to test terraform!"
  count = 3
}