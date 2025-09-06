class_name FormationManager
extends Node

@export var formation_scene: PackedScene

var data: DanceFormationCollection

func _ready():
	load_data()

#func _gui_input(event: InputEvent) -> void:
	#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT \
	 #and event.is_pressed() and current_formation:
		#current_formation.add_dancer(event.position)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("save"):
			save_data()

func get_formation(id: int) -> DanceFormation:
	if data.id_formation_dict.has(id):
		return data.id_formation_dict[id]
	return null

func get_new_formation() -> DanceFormation:
	var new_formation: DanceFormation = formation_scene.instantiate()
	while data.id_formation_dict.has(new_formation.data.id):
		new_formation.request_rand_id()
	data.id_formation_dict[new_formation.data.id] = new_formation
	return new_formation

func has_formation(id: int) -> bool:
	return data.id_formation_dict.has(id)

func add_formation(formation: DanceFormation) -> void:
	while data.id_formation_dict.has(formation.data.id):
		formation.request_rand_id()
	data.id_formation_dict[formation.data.id] = formation

#func _on_formation_selector_select_formation(id: int) -> void:
	#if current_formation:
		#current_formation.hide()
	#if id < 0:
		#current_formation = null
		#return
	#current_formation = id_formation_dict[id]
	#current_formation.show()
#
#
#func _on_add_formation_button_pressed() -> void:
	#var new_formation: DanceFormation = formation_scene.instantiate()
	#formations_container.add_child(new_formation)
	## TODO: Check if formation needs a new id
	#id_formation_dict[new_formation.data.id] = new_formation
	#formation_selector.add_formation(new_formation.data.id)
	#if current_formation:
		#current_formation.hide()
	#current_formation = new_formation
	#current_formation.show()

func save_data():
	ResourceSaver.save(data.serialize(), "temp.tres")

func load_data():
	data = ResourceLoader.load("temp.tres")
	if not data or data is not DanceFormationCollection:
		data = DanceFormationCollection.new()
		return
	data.deserialize()
