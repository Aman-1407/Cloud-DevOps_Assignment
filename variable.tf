variable "region" {
  description = "The AWS region to deploy resources."
  type        = string
  default     = "us-east-1"
}

variable "subnet_ids" {
  description = "List of subnet IDs to deploy resources into."
  type        = list(string)
  default     = ["subnet-053bcec1edece9805", "subnet-008a8214e9a57fee3"]
}

variable "node_subnet_ids" {
  description = "List of subnet IDs for the node group."
  type        = list(string)
  default     = ["subnet-053bcec1edece9805", "subnet-008a8214e9a57fee3"]
}



