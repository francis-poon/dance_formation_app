class_name FormationManagerData
extends Resource

@export var formations: Array[DanceFormationData]

func _init(p_formations: Array[DanceFormationData] = []) -> void:
	formations = p_formations

#func serialize() -> DanceFormationCollection:
	#var serialized = DanceFormationCollection.new(id_formation_dict)
	#for id in id_formation_dict.keys():
		#if id_formation_dict[id] is not PackedScene:
			#var packed_scene: PackedScene = PackedScene.new()
			#for child in id_formation_dict[id].get_children(true):
				#child.owner = id_formation_dict[id]
			#print("Serialize stage children: " + str(id_formation_dict[id].stage.get_children()))
			#packed_scene.pack(id_formation_dict[id])
			#id_formation_dict[id] = packed_scene
	#return serialized
#
#func deserialize() -> void:
	#for id in id_formation_dict.keys():
		#if id_formation_dict[id] is PackedScene:
			#var packed_scene: PackedScene = id_formation_dict[id]
			#id_formation_dict[id] = packed_scene.instantiate()
			#var x = id_formation_dict[id] as DanceFormation
			#print("Deserialize stage children: " + str(x.stage.get_children()))
