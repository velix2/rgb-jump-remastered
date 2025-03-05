extends Node

signal score_changed(new_score: int)

var _score: int = 0

func add_score(added_score: int) -> void:
	_score += added_score
	score_changed.emit(_score)
