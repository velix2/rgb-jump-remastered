extends Node2D

func _on_player_player_died() -> void:
	var current_highscores = HighScoreFileManager.load_score_and_playtime_from_file()
	
	var current_highscore = current_highscores.x
	var current_besttime = current_highscores.y
	
	var highscore = maxi(ScoreManager.score, current_highscore)
	var besttime = maxi(floori(TimeManager.get_playtime_unix()), current_besttime)
	
	if highscore == current_highscore and besttime == current_besttime:
		return
	
	HighScoreFileManager.save_score_and_playtime_to_file(highscore, besttime)
