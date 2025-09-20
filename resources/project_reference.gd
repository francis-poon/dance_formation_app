class_name ProjectReference
extends Resource

var id: int
var name: String
var project_resource_path: String

func _init(p_id: int = -1, p_name: String = "", p_project_resource_path: String = ""):
	id = p_id
	name = p_name
	project_resource_path = p_project_resource_path
