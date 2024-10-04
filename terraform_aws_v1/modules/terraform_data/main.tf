locals {
  combined_objects = concat(
    flatten([
      for object_type, objects in var.objects : [
        for object_name, params in objects : [
          {
            name        = "${var.env}-${object_type}-${object_name}"
            type        = object_type
            parent_name = lookup(params, "parent_name", null)
            size        = params.size
            db_type     = lookup(params, "db_type", null)
            mem         = lookup(params, "mem", null)
            subenv      = null
            count       = lookup(params, "count", 1)
          }
        ]
      ]
    ]),
    flatten([
      for subenv, subenv_objects in var.subenv_objects : [
        for object_type, objects in subenv_objects : [
          for object_name, params in objects : [
            {
              name        = "${var.env}-${subenv}-${object_type}-${object_name}"
              type        = object_type
              parent_name = lookup(params, "parent_name", null)
              size        = params.size
              db_type     = lookup(params, "db_type", null)
              mem         = lookup(params, "mem", null)
              subenv      = subenv
              count       = lookup(params, "count", 1)
            }
          ]
        ]
      ]
    ])
  )
}
