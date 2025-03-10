extends Node

var file_path: String = "user://scores.dat"

signal highscore_deleted

func save_score_and_playtime_to_file(score: int, playtime_in_secs: int) -> void:
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	file.store_string(str(score) + "," + str(playtime_in_secs))
	file.close()
	
func load_score_and_playtime_from_file() -> Vector2i:
	if not FileAccess.file_exists(file_path):
		return Vector2i(0,0)
	var file = FileAccess.open(file_path, FileAccess.READ)
	var contents: String = file.get_as_text()
	file.close()
	var contentsArr: PackedStringArray = contents.split(",", true, 1)
	return Vector2i(int(contentsArr[0]), int(contentsArr[1]))

func delete_highscore() -> void:
	if not FileAccess.file_exists(file_path):
		return
	save_score_and_playtime_to_file(0,0)
	highscore_deleted.emit()
