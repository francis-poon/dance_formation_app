extends Button

signal play
signal pause

@export var play_icon: Texture2D
@export var pause_icon: Texture2D

var is_play: bool = false:
	set(value):
		is_play = value
		if is_play:
			icon = pause_icon
		else:
			icon = play_icon


func _on_pressed() -> void:
	is_play = !is_play
	if is_play:
		play.emit()
	else:
		pause.emit()
