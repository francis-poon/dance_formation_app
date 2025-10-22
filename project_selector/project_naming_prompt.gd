class_name ProjectNamingPrompt
extends Control

signal name_project(project_name: String)

@export var _name_line_edit: LineEdit

func open(project_name: String = ""):
	show()
	_name_line_edit.text = project_name


func _on_cancel_button_pressed() -> void:
	hide()


func _on_rename_button_pressed() -> void:
	name_project.emit(_name_line_edit.text)
	hide()
