class_name DanceFormation
extends Control

@export var dancer_scene: PackedScene
@export var stage: Control

@export var data: DanceFormationData = DanceFormationData.new()
#@export var stage_size: Vector2 = Vector2(400, 500):
	#set(value):
		#stage_size = value
		#stage.size = stage_size
@export var _preview_modulation: Color

func get_data():
	data.dancer_positions = []
	for dancer in get_children():
		data.dancer_positions.append(dancer.position)
	
	return data

func request_rand_id() -> void:
	data.id = randi()

func load_data(p_data: DanceFormationData):
	data = p_data
	for dancer_pos in data.dancer_positions:
		add_dancer(dancer_pos)

func add_dancer(pos: Vector2):
	var new_dancer: Dancer = dancer_scene.instantiate()
	stage.add_child(new_dancer)
	new_dancer.global_position = pos

func get_preview() -> Control:
	var preview: DanceFormationPreview = DanceFormationPreview.new()
	var preview_stage: Control = stage.duplicate()
	var stage_dancers = preview_stage.get_children()
	for dancer in stage_dancers:
		preview_stage.remove_child(dancer)
		dancer = dancer as Dancer
		var dancer_sprite = dancer.get_sprite()
		preview_stage.add_child(dancer_sprite)
		dancer_sprite.position = dancer.position
	
	preview.set_preview(data.id, preview_stage)
	preview_stage.position = -0.5 * preview_stage.get_rect().size
	preview.scale = Vector2(0.25, 0.25)
	preview.modulate = _preview_modulation
	return preview
