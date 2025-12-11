module "network" {
  source = "../../"
  disk_name = "abcd"
  disk_size = 1
  my_location = "eastus"
  resource_group_name = "terra-devops"
  public_network_access_enabled = false
}






