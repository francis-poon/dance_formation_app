class_name CreateProjectPrompt
extends Control

signal create_project(project_name: String)
signal cancel

@export var _name_line_edit: LineEdit

func open(project_name: String = ""):
	show()
	_name_line_edit.text = project_name

func _on_create_button_pressed() -> void:
	create_project.emit(_name_line_edit.text)
	hide()

func _on_cancel_button_pressed() -> void:
	cancel.emit()
	hide()
