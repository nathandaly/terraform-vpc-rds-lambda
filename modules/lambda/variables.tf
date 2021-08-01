variable "name" {
    type = string
    default = "plotpilotAPI"
}

variable "path_part" {
    type = string
    default = "{proxy+}"
}

variable "rest_api_id" {
    type = string
    default = "apilambda"
}

variable "parent_id" {
    type = string
    default = "root_resource_id"
}

variable "function_name" {
    type = string
    default = "plotpilot_api"
}

variable "authorization" {
    type = string
    default = "NONE"
}

variable "http_method" {
    type = string
    default = "ANY"
}

variable "integration_http_method" {
    description = "(Required) The response method for the API endpoint."
    default = "ANY"
}

variable "s3_bucket" {
    type = string
    default = "igetbucket21"
}

variable "s3_key" {
    type = string
    default = "api.zip"
}

variable "handler" {
    type = string
    default = "api.handler"
}

variable "runtime" {
    type = string
    default = "nodejs12.x"
}

variable "type" {
    type = string
    default = "AWS_PROXY"
}

variable "private_subnets" {

}

variable "security_group_id" {

}
