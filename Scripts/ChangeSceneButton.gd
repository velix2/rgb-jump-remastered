extends Button

@export var scene_to_load_path: String

func _on_pressed() -> void:
	get_tree().change_scene_to_file(scene_to_load_path)
