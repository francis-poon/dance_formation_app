class_name DanceFormationCollection
extends Resource

#@export var formations: Array[DanceFormationData]
@export var id_formation_dict: Dictionary

func _init(p_id_formation_dict: Dictionary = {}) -> void:
	id_formation_dict = p_id_formation_dict
	deserialize()

func serialize() -> DanceFormationCollection:
	var serialized = DanceFormationCollection.new(id_formation_dict)
	for id in id_formation_dict.keys():
		if id_formation_dict[id] is not PackedScene:
			var packed_scene: PackedScene = PackedScene.new()
			for child in id_formation_dict[id].get_children():
				child.owner = id_formation_dict[id]
			packed_scene.pack(id_formation_dict[id])
			id_formation_dict[id] = packed_scene
	return serialized

func deserialize() -> void:
	for id in id_formation_dict.keys():
		if id_formation_dict[id] is PackedScene:
			var packed_scene: PackedScene = id_formation_dict[id]
			id_formation_dict[id] = packed_scene.instantiate()
