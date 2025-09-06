extends Node

# Experimental code for transitioning dancer between formations

#var is_move: bool
#var cur_move_time: float
#var move_time: float = 2
#var targets: Array

#func _ready():
	#cur_move_time = 0
	#is_move = false
	#targets = []

#func _process(delta: float) -> void:
	#if is_move:
		#cur_move_time += delta
		#cur_move_time = clampf(cur_move_time, 0, move_time)
		#if cur_move_time >= move_time:
			#is_move = false
		#position = lerp(start_pos, destination, cur_move_time/move_time)

#func add_target(p_target: Vector2):
	#targets.append(p_target)

#func set_time(time: float):
	## I need to find the first targets who's time is less than the set time?
	## say its 10 seconds rn, i have two targets, one at 5 seconds and another at 11
	## Actually no, find the first one that's greater than the set time
	## if not greater one is found, use the last element and set postion to that
	## if one is found, lerp between that and the previous target
	#var target_index = targets.find_custom(func(a) -> bool: return a[1] >= time)
	#if target_index == -1:
		#if targets.size() == 0:
			#return
		#position = targets[0][0]
	#else:
		#if target_index == 0:
			#position = targets[0][0]
			#return
		#var target_a = targets[target_index - 1]
		#var target_b = targets[target_index]
		#var lerp_val = (time - target_a[1]) / (target_b[1] - target_a[1]) 
		#
		#position = lerp(target_a[0], target_b[0], lerp_val)
#
#func add_target(p_target: Vector2, p_target_time: float):
	#targets.append([p_target, p_target_time])
	#targets.sort_custom(_sort_target_time)
#
#func _sort_target_time(a, b) -> bool:
	#return a[1] < b[1]

#func move(p_destination: Vector2):
	#cur_move_time = 0
	#is_move = true
	#destination = p_destination
	#start_pos = position


#func _on_h_slider_value_changed(value: float) -> void:
	#if targets.size() == 0:
		#return
	#if targets.size() == 1:
		#position = targets[0]
		#return
	#var value_packet_size = 100/(targets.size() - 1)
	#var target_a: Vector2 = targets[int(value/value_packet_size)]
	#var target_b: Vector2 = targets[int(value/value_packet_size) + 1]
	#
	#
	#position = lerp(target_a, target_b, fmod(value, value_packet_size)/value_packet_size)
