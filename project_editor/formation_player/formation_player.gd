class_name FormationPlayer
extends Control

@export var formation_display: FormationDisplay

func get_timeline_data():
	pass

func load_project(project_data: Resource):
	
	pass


func _on_formation_timeline_display_formation(id: int) -> void:
	if id == -1:
		formation_display.clear_display()
	else:
		formation_display.display_formation(id)
