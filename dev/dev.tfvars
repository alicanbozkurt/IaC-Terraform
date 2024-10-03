environment = "dev"
subenv      = "integration"

objects = {
  db1 = {
    type          = "db"
    size          = "small"
    name          = "rdb"
    db_type       = "mysql"
    instance_count = 1
  }
  db2 = {
    type          = "db"
    size          = "small"
    name          = "nsdb"
    db_type       = "nosql"
    instance_count = 1
  }
  instance1 = {
    type          = "instance"
    size          = "small"
    name          = "wks"
    instance_count = 1
  }
  container1 = {
    type          = "container"
    name          = "svc1"
    instance_count = 1
  }
    container2 = {
    type          = "container"
    name          = "svc2"
    instance_count = 1
  }
  k8s_cluster1 = {
    type          = "k8s_cluster"
    size          = "small"
    name          = "kcls"
    instance_count = 1
  }
}
