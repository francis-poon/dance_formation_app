extends Node2D

@export var dancer_containers: Array[Node]
@export var target_times: Array[float]

var dancers: Array

func _ready() -> void:
	dancers = []
	
	for dancer_container in dancer_containers:
		var dancer = dancer_container.find_child("Dancer")
		var targets = dancer_container.find_child("Targets")
	
		dancers.append(dancer)
		var n = 0
		for target in targets.get_children():
			dancer.add_target(target.position, target_times[n])
			n += 1
		dancer.set_time(0)


func _on_h_slider_value_changed(value: float) -> void:
	for dancer in dancers:
		dancer.set_time(value)
