extends Label

var base_string: String

func _ready() -> void:
	ScoreManager.score_changed.connect(self._on_score_changed)
	base_string = text
	update_text(0)
	
func _on_score_changed(score: int):
	update_text(score)
	
func update_text(score: int):
	text = base_string % score


func _on_player_player_died() -> void:
	visible = false
