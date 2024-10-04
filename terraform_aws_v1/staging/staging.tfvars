env     = "staging"
objects = {}

subenv_objects = {
  "integration" = {
    kcls = {
      "container-svc1" = {
        size  = "large"
        count = 1
      }
      "container-svc2" = {
        size  = "large"
        count = 1
      }
    }
    rdb = {
      "mysql" = {
        size    = "large"
        db_type = "mysql"
        count   = 1
      }
    }
    nsdb = {
      "nosql" = {
        size    = "large"
        db_type = "nosql"
        count   = 1
      }
    }
    instance = {
      "wks" = {
        size  = "large"
        count = 1
      }
    }
  }
  "performance" = {
    kcls = {
      "container-svc1" = {
        size  = "large"
        mem   = 2048
        count = 1
      }
      "container-svc2" = {
        size  = "large"
        mem   = 4096
        count = 1
      }
    }
    rdb = {
      "mysql" = {
        size    = "large"
        db_type = "mysql"
        count   = 1
      }
    }
    nsdb = {
      "nosql" = {
        size    = "large"
        db_type = "nosql"
        count   = 1
      }
    }
    instance = {
      "wks" = {
        size  = "large"
        count = 1
      }
    }
  }
}

# Added variables for the RDS database module
#db_username         = "admin"  
#db_password         = "Password"  
db_subnet_ids       = ["subnet-05ea8a0b8c5d68524", "subnet-05c7d60280efa8266"]  

# Remove or comment out this line
# ec2_subnet_id = "subnet-12345678"

# Added variables for the ECS service module
ecs_subnet_ids         = ["subnet-05ea8a0b8c5d68524", "subnet-05c7d60280efa8266"] 
ecs_security_group_ids = ["sg-0343b9eedfeccac8b"]                      

