extends Panel

func _on_close_button_pressed() -> void:
	visible = false

func _on_settings_button_pressed() -> void:
	visible = !visible
