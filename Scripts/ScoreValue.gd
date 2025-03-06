extends Label

@export var score_increase_per_sec: int = 5
var score_current: int = 0
var score_target: int

var animate_score: bool = false

@onready var base_text: String = text

func _on_visibility_changed() -> void:
	if not visible:
		return
	animate_score = true
	score_target = ScoreManager.score
	update_text_display()

func _process(delta: float) -> void:
	if not animate_score:
		return
	var anim_speed = delta * 0.01 * (score_target - score_current) * score_increase_per_sec
	score_current = min(score_current + ceil(anim_speed), score_target)
	update_text_display()
	
	animate_score = score_current != score_target

func update_text_display() -> void:
	text = base_text % score_current


func _on_time_value_visibility_changed() -> void:
	pass # Replace with function body.
