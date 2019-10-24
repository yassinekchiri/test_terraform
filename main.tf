resource "local_file" "myfile" {
  content  = "hello !"
  filename = "/tmp/monfic.txt"
}
