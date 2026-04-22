variable "log_analytics_workspace" {
  type = map(object({
    workspace_name       = string
    location             = string
    resource_group_name  = string
  }))

}
