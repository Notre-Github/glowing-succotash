extends TextureButton

var id = -1
var main

func set_id(given_id:int, base_node:Node) -> void:
	id = given_id
	get_node("text").text = str(id)
	main = base_node
	position = Vector2(-150 + (((1152 /2.5) / 2) * id), 648 / 2)

func blink():
	hide()
	await get_tree().create_timer(0.5).timeout
	show()
	await get_tree().create_timer(0.25).timeout

func _pressed() -> void:
	main._button_pressed(id)
