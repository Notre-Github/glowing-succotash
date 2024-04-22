extends Node

var button_scene = preload("res://res/objects/yosyo_roule_en_velo/button.tscn")
var buttons = []

var	input = []
var score = 0
signal input_recieved()

func countdown(value:int) -> void:
	get_tree().paused = true
	for i in value:
		get_node("ScreenInformations").text = str(value - i)
		await get_tree().create_timer(1).timeout
		if i == value - 1:
			get_node("ScreenInformations").text = ""
	get_tree().paused = false

func _ready() -> void:
	for i in range(4):
		buttons.append(button_scene.instantiate())
		buttons[i].set_id(i + 1, self)
	await countdown(3)
	for button in buttons:
		add_child(button)
	while (1):
		await _game()

func show_countdown(order:Array) -> void:
	get_node("banger").playing = false
	get_node("banger").playing = true
	get_node("ScreenInformations").text = "FOCUS"
	await get_tree().create_timer(0.5).timeout
	for v in order:
		await buttons[v - 1].blink()
	get_node("ScreenInformations").text = ""

func _game() -> void:
	var order = []
	for v in range(1 + score):
		order.append((randi() % 4) + 1)
	print(order)
	await show_countdown(order)
	input = []
	while (len(order) > len(input)):
		await(input_recieved)
		for i in range(len(input)):
			if input[i] != order[i]:
				get_node("banger").playing = false
				get_node("bruh").playing = true
				while (1):
					i+=1
	if order == input:
		score += 1
		get_node("ScoreLabel").text = "score : " + str(score)
	else:
		get_node("banger").playing = false
		get_node("bruh").playing = true
		while (1):
			score+=1

func _button_pressed(num:int) -> void:
	input.append(num)
	input_recieved.emit()
