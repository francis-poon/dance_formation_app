class_name ProjectManagerData
extends Resource

@export var project_dict: Dictionary

func _init(p_project_dict: Dictionary = {}):
	project_dict = p_project_dict


#@export var test: ATest

# Okay what do i need in this
# So project id, project name, and name of project resource file

# I can store these in a dictionary that has the inner class as its value
# and the id as the key?
# So say im in the project manager rn
# for each value in my dict
# 	data: Data.InnerClass = value
#	
