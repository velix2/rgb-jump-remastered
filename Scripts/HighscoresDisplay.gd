extends Label

@export var score_string_template: String = "Highest Score: %05d"
@export var time_string_template: String = "Longest Run: %02d:%02d"

enum State {ANIM_UP, DISPLAY, ANIM_DOWN}
var state: State = State.ANIM_UP

var show_score: bool = true

var score_string: String
var time_string: String

func _init() -> void:
	var scores = HighScoreFileManager.load_score_and_playtime_from_file()
	var score = scores.x
	var time = Time.get_datetime_dict_from_unix_time(scores.y)
	
	score_string = score_string_template % score
	time_string = time_string_template % [time.minute, time.second]
	
	HighScoreFileManager.highscore_deleted.connect(_on_highscore_deleted)

func _process(_d: float) -> void:
	match state:
		State.DISPLAY:
			return
		State.ANIM_UP:
			modify_text_up()
		State.ANIM_DOWN:
			modify_text_down()

func _on_animate_up_timeout() -> void:
	state = State.DISPLAY
	text = score_string if show_score else time_string
	$Display.start()

func _on_animate_down_timeout() -> void:
	state = State.ANIM_UP
	show_score = !show_score
	$AnimateUp.start()

func _on_display_timeout() -> void:
	state = State.ANIM_DOWN
	$AnimateDown.start()
	
func modify_text(text_percentage: float) -> void:
	var whole_string: String = score_string if show_score else time_string
	var num_of_chars_to_show: int = roundi(text_percentage * len(whole_string))
	var shortened_string: String = whole_string.substr(0, num_of_chars_to_show)
	
	text = shortened_string
	
func modify_text_up() -> void:
	var ratio: float = 1 - ($AnimateUp.time_left / $AnimateUp.wait_time)
	modify_text(ratio)
	
func modify_text_down() -> void:
	var ratio: float = $AnimateDown.time_left / $AnimateDown.wait_time
	modify_text(ratio)
	
func _on_highscore_deleted() -> void:
	score_string = score_string_template % 0
	time_string = time_string_template % [0, 0]
