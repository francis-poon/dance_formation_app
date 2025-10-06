class_name FormationManager
extends Node

signal new_data_loaded

@export var _formation_scene: PackedScene

var _id_formation_dict: Dictionary = {}

func save_data() -> FormationManagerData:
	var formation_data_array: Array[DanceFormationData] = []
	formation_data_array.resize(_id_formation_dict.size())
	var formation_array: Array[DanceFormation] = []
	formation_array.assign(_id_formation_dict.values())
	for c in range(formation_array.size()):
		formation_data_array[c] = formation_array[c].save_data()
	
	return FormationManagerData.new(formation_data_array)

func load_data(data: FormationManagerData):
	_id_formation_dict = {}
	
	for dance_formation_data in data.formations:
		var dance_formation: DanceFormation = _formation_scene.instantiate()
		dance_formation.load_data(dance_formation_data)
		_id_formation_dict[dance_formation.id] = dance_formation
	new_data_loaded.emit()

func _ready():
	print("TODO: Add FormationManager to AutoLoad.")

func get_formation(id: int) -> DanceFormation:
	if _id_formation_dict.has(id):
		return _id_formation_dict[id]
	return null

func get_all_formations() -> Array[DanceFormation]:
	var formation_array: Array[DanceFormation] = []
	formation_array.assign(_id_formation_dict.values())
	return formation_array

func get_new_formation() -> DanceFormation:
	var new_formation: DanceFormation = _formation_scene.instantiate()
	while _id_formation_dict.has(new_formation.id):
		new_formation.request_rand_id()
	_id_formation_dict[new_formation.id] = new_formation
	return new_formation

func has_formation(id: int) -> bool:
	return _id_formation_dict.has(id)

func add_formation(formation: DanceFormation) -> void:
	while _id_formation_dict.has(formation.id):
		formation.request_rand_id()
	_id_formation_dict[formation.id] = formation
