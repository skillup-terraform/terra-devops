module "network" {
  source = "../../"
  disk_name = "abcd"
  disk_size = 1
  my_location = "eastus"
  resource_group_name = "terra-devops"
  public_network_access_enabled = false
  subscription_id = "f154a823-7b49-4f69-a16a-5caf74c6b35a"
}






