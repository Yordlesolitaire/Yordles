extends Camera2D



func _process(delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		position = get_global_mouse_position()
