extends ScrollContainer

@export var timeline_scroll: HScrollBar
@export var timeline: Control
@export var label: Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timeline_scroll.max_value = timeline.size.x


func _on_h_scroll_bar_value_changed(value: float) -> void:
	_update_label(value)
	


func _on_color_rect_2_data_updated() -> void:
	_update_label(timeline_scroll.value)

func _update_label(value):
	var target_idx = timeline.marker_cues.find_custom(func(a): return value < a[0])
	match(target_idx):
		0:
			label.text = ""
		-1:
			label.text = str(timeline.marker_cues[-1][1])
		_:
			label.text = str(timeline.marker_cues[target_idx - 1][1])
