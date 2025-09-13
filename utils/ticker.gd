class_name Ticker
extends Node

signal tick

@export var ticks_per_second: float = 30
@export var auto_start: bool = true

var _is_running: bool = false
var _time_since_last_tick: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if auto_start:
		start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not _is_running:
		return
	
	_time_since_last_tick += delta
	if _time_since_last_tick >= 1 / ticks_per_second:
		_time_since_last_tick -= 1 / ticks_per_second
		_tick()

func start():
	_time_since_last_tick = 0
	_is_running = true

func stop():
	_is_running = false

func _tick():
	tick.emit()
