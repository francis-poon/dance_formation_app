class_name ProjectSelectButton
extends Control

signal select_project(button: ProjectSelectButton)

var project_id: int
var project_name: String

func load_data(p_id: int, p_name: String):
	project_id = p_id
	project_name = p_name

func _on_pressed() -> void:
	select_project.emit(self)
