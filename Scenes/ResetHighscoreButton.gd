extends Button

@export var confirmation_text: String = "Are you sure?"
@export var success_text: String = "Reset successful!"

@export var confirm_color: Color
@export var success_color: Color

@onready var original_text: String = text
@onready var original_color: Color = modulate

var is_confirming: bool = false

func _on_pressed() -> void:
	if is_confirming:
		HighScoreFileManager.delete_highscore()
		text = success_text
		modulate = success_color
	else:
		is_confirming = true
		text = confirmation_text
		modulate = confirm_color

func _on_mouse_exited() -> void:
	if not is_confirming:
		return
	text = original_text
	modulate = original_color
	is_confirming = false
