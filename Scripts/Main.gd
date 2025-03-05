extends Node2D

@export var wall_scene: PackedScene
@export var top_bottom_padding: float = 100

func spawn_wall() -> void:
	var wall: Node2D = wall_scene.instantiate()
	wall.position.x = get_viewport_rect().size.x * 1.1
	wall.position.y = randf_range(top_bottom_padding, get_viewport_rect().size.y - top_bottom_padding)
	wall.scale.y = randf_range(0.6, 1.25)
	wall.set_pass_color(randi() % 3)

	add_child(wall)

func _on_wall_timer_timeout() -> void:
	spawn_wall()
	# Reset the timer with random time
	$WallTimer.wait_time = randf_range(3, 6)
	$WallTimer.start()
