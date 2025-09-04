extends SubViewportContainer

@export var sprite_template: Sprite2D
@export var sub_viewport: SubViewport
@export var label: Label

var sprite: Sprite2D

func _ready():
	remove_child(sprite_template)
	#sprite = sprite_template.duplicate()
	#sub_viewport.add_child(sprite)
	#print(sub_viewport.get_camera_2d().get_canvas_transform())
	

#func _process(delta: float) -> void:
	#sprite.global_position = sub_viewport.get_camera_2d().get_global_mouse_position()
	#label.text = str(sub_viewport.get_camera_2d().get_global_mouse_position())

func add_sprite(pos: Vector2):
	var new_sprite = sprite_template.duplicate()
	sub_viewport.add_child(new_sprite)
	new_sprite.position = sub_viewport.get_camera_2d().get_global_transform_with_canvas().affine_inverse() * pos
	

	#print(pos)
	#print(get_global_mouse_position())
	#print(get_viewport().get_screen_transform() * get_global_transform_with_canvas() * pos)
	#print(sub_viewport.get_camera_2d().get_global_transform_with_canvas() * pos)
	#print(sub_viewport.get_camera_2d().get_global_mouse_position())
	#new_sprite.position = sub_viewport.get_viewport().get_camera_2d().to_local(pos)
