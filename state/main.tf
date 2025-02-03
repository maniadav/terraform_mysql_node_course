resource "local_sensitive_file" "example1" {
  content  = "manish_yadav"
  filename = "${path.module}/sensitive.txt"
}
