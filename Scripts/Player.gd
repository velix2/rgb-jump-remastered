extends RigidBody2D

signal player_died

const player_colors = [Color.RED, Color.GREEN, Color.BLUE]

@export var jump_strength: float = 20
var current_color: int = 0

@onready var screen_size = get_viewport_rect().size

var is_dead: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_color_display()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# If the player is dead, don't do anything
	if is_dead:
		return
	
	if Input.is_action_just_pressed("switch"):
		# Cycle through the colors on switch
		current_color = (current_color + 1) % player_colors.size()
		update_color_display()

	if Input.is_action_just_pressed("jump"):
		jump()
	
	# Check if the player has passed the screen borders
	passed_screen_borders()

func update_color_display() -> void:
	$CurrentColorTexture.modulate = player_colors[current_color]

func jump() -> void:
	linear_velocity = Vector2.ZERO
	apply_impulse(Vector2.UP * jump_strength)

func passed_screen_borders() -> void:
	if position.y > screen_size.y or position.y < 0:
		kill()

func kill() -> void:
	is_dead = true
	player_died.emit()
	print("Player is dead!")
