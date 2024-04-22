extends Button

@export var clicks: int

func _ready() -> void:
	pressed.connect(_click_count)

func _click_count() -> int:
	clicks += 1
	return clicks

func _process(delta: float) -> void:
	text = str(clicks)
