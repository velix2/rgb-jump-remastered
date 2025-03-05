extends Node2D

@export var wall_speed: float = 400

const player_colors = [Color.RED, Color.GREEN, Color.BLUE]
var current_color: int = 0

func set_pass_color(colorNumber: int) -> void:
	$Passthrough/Sprite2D.modulate = player_colors[colorNumber]
	current_color = colorNumber

func get_color_number() -> int:
	return current_color

func _process(delta: float) -> void:
	position.x -= wall_speed * delta

func _on_wall_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.kill()

func _on_passthrough_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.current_color == current_color:
			print("Passed")
		else:
			body.kill()

func _on_passthrough_body_exited(body:Node2D) -> void:
	if body.is_in_group("player"):
		pass