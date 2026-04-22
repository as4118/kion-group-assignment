variable "vnets" {
  type = map(object({
    virtual_network_name = string
    address_space        = list(string)
    location             = string
    resource_group_name  = string
  }))
}
