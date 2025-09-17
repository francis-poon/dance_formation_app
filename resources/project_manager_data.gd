extends Resource

class ProjectReference:
	var id: int
	var name: String
	var resource_path: String
	
	func _init(p_id: int, p_name: String, p_resource_path: String):
		id = p_id
		name = p_name
		resource_path = p_resource_path

class ATest:
	var a: int
	
	func _init(p_a: int = 0):
		a = p_a

func _init():
	resource_path
#@export var test: ATest

# Okay what do i need in this
# So project id, project name, and name of project resource file

# I can store these in a dictionary that has the inner class as its value
# and the id as the key?
# So say im in the project manager rn
# for each value in my dict
# 	data: Data.InnerClass = value
#	
