module "network" {
  source = "../../"
  disk_name = "abcd"
  disk_size = 1
  my_location = "eastus"
  resource_group_name = "terra-devops"
  public_network_access_enabled = false
  subscription_id = "c6bf0c50-70f6-4f9d-a082-2f4acf6c08a9"
}