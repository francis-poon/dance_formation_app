extends Control

@export var formation_display: FormationDisplay

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_formation_timeline_display_formation(id: int) -> void:
	print(id)
	if id == -1:
		formation_display.clear_display()
	else:
		formation_display.display_formation(id)
