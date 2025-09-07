class_name DanceFormation
extends Control

signal formation_changed(dancer_positions: Array[Vector2])

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
	new_dancer.id = stage.get_children().size()
	stage.add_child(new_dancer)
	new_dancer.global_position = pos
	new_dancer.dancer_moved.connect(_on_dancer_moved)
	new_dancer.dancer_deleted.connect(_on_dancer_deleted)
	data.dancer_positions.append(new_dancer.position)
	formation_changed.emit(data.dancer_positions)

func get_preview() -> Control:
	var preview: DanceFormationPreview = DanceFormationPreview.new()
	preview.set_preview(data.id, data.dancer_positions, stage.size)
	formation_changed.connect(preview._on_formation_changed)
	return preview

func _on_dancer_moved(dancer_id: int, position: Vector2):
	data.dancer_positions[dancer_id] = position
	formation_changed.emit(data.dancer_positions)

func _on_dancer_deleted(dancer_id: int):
	# make it first
	# make it first
	# make it first
	# just make it
	# make it exist
	# make it work
	# make it first
	# make it be real
	# get it out of your head
	# get it to people
	# get something that works
	# get anything works 
	# it doesn't have to be good
	# it doesn't have to work well
	# it doesn't even have to work all the time
	# it doesn't even have to work correctly
	# get something that does something, anything at all
	# we can make it better from there
	# that's the part youre good at
	# making things work better
	# don't worry about that right now
	# don't worry about it being good right now
	# there's no doubt that you can make it good
	# you will make it good
	# just make it bad right now
	# please im begging you francis make it at all
	# don't keep letting everything you are
	# stop you
	# you aren't strong enough to stop yourself
	# from doing all the things you want to do
	# so go do them
	data.dancer_positions.remove_at(dancer_id)
	for dancer in stage.get_children():
		dancer = dancer as Dancer
		if dancer.id > dancer_id:
			dancer.id -= 1
	formation_changed.emit(data.dancer_positions)
