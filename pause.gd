extends Control

func _input(event: InputEvent) -> void:
	if event.is_action("ui_cancel") and event.is_pressed():
		switch_pause()



func switch_pause():
	get_tree().paused = !get_tree().paused

func _process(delta: float) -> void:
	match get_tree().paused:
		true:
			show()
		false:
			hide()


func _on_reprendre_pressed() -> void:
	switch_pause()


func _on_quitter_pressed() -> void:
	get_tree().quit()
