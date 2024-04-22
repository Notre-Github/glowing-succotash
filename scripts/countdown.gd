extends Label

func _ready() -> void:
	await countdown(3)
	await timer(5)
	end()

func countdown(time: int) -> void:
	get_tree().paused = true
	for i in time:
		text = str(time - i)
		await get_tree().create_timer(1.0).timeout
		if i == time - 1:
			text = ""
	get_tree().paused = false

func timer(time: int) -> void:
	for i in time:
		text = str(time - i)
		await get_tree().create_timer(1.0).timeout
		if i == time - 1:
			text = "STOP"

func end() -> void:
	get_tree().paused = true
	label_settings.font_size = 100
	text = "Bravo pour ces " + str(get_node("../Button").clicks) + " cliques !"
	await get_tree().create_timer(3.0).timeout
	get_tree().quit()
