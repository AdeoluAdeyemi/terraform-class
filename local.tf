resource "local_file" "pet" {
    filename = "/home/adeolu/tf_output/pet.txt"
    content = "We love pets!"
}