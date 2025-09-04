extends HSlider

var playing: bool

func _ready():
	playing = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("spacebar_toggle"):
		playing = !playing

func _process(delta: float) -> void:
	if playing:
		value += delta
