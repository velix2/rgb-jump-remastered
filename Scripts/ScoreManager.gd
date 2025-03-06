extends Node

signal score_changed(new_score: int)

var score: int = 0

func add_score(added_score: int) -> void:
	score += added_score
	score_changed.emit(score)
