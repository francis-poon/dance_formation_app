class_name ProjectReference
extends Resource

@export var id: int
@export var name: String
@export var project_resource_path: String

func _init(p_id: int = -1, p_name: String = "Untitled Project", p_project_resource_path: String = ""):
	id = p_id
	#if id == -1:
		#id = randi()
	name = p_name
	project_resource_path = "{0}{1}.tres".format([Globals.get_project_save_dir(), id])
