class_name TickBasedTimer
extends Node

signal time_changed(time: float)
signal timeout

@export var wait_time: float = 1
@export var ticks_per_second: float = 30:
	set(value):
		ticks_per_second = value
		_ticker.ticks_per_second = value
@export var auto_start: bool = false

@export var _ticker: Ticker

var current_time: float:
	set(value):
		if value >= wait_time:
			current_time = wait_time
			timeout.emit()
		else:
			current_time = value
		_time_changed = true

var _is_running: bool
var _time_changed: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_ticker.ticks_per_second = ticks_per_second
	_time_changed = false
	current_time = 0
	if auto_start:
		start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if _is_running:
		if current_time + delta >= wait_time:
			stop()
		current_time += delta

func start():
	_is_running = true

func stop():
	_is_running = false

func reset():
	current_time = 0

func set_time(time: float):
	current_time = time

func _on_tick() -> void:
	if _time_changed:
		time_changed.emit(current_time)
