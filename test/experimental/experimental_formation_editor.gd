extends Control

@export var sub_viewport_container: SubViewportContainer
@export var sprite_temp: Sprite2D
@export var target: Control

func _ready():
	remove_child(sprite_temp)

#func _input(event: InputEvent) -> void:
	#if event is InputEventMouseButton and event.is_pressed():
		#var new_sprite: Sprite2D = sprite_temp.duplicate()
		##new_sprite.position = event.global_position - target.global_position
		##new_sprite.global_position = event.global_position
		##target.add_child(new_sprite)
		#sub_viewport_container.add_sprite(event.global_position)


func _on_dancer_manager_dancer_dropped(dancer_id: int, pos: Vector2) -> void:
	sub_viewport_container.add_sprite(pos)
