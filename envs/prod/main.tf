module "network" {
  source = "../../"
  disk_name = "abcd"
  disk_size = 1
  my_location = "eastus"
  resource_group_name = "terra-devops"
  public_network_access_enabled = false
  subscription_id = "625212d8-b50c-4d34-91c2-acce39814b8b"
}