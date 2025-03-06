extends Label

@export var time_increase_per_sec: int = 1
var time_current: float = 0
var time_target: float

var animate_time: bool = false

@onready var base_text: String = text

func _on_visibility_changed() -> void:
	if not visible:
		return
	animate_time = true
	time_target = TimeManager.get_playtime_unix()
	print(time_target)
	update_text_display()

func _process(delta: float) -> void:
	if not animate_time:
		return
	var anim_speed = delta * 0.01 * (time_target - time_current) * time_increase_per_sec
	time_current = min(time_current + ceil(anim_speed), time_target)
	update_text_display()
	
	animate_time = ceil(time_current) < ceil(time_target)

func update_text_display() -> void:
	var time_dict = Time.get_datetime_dict_from_unix_time(ceil(time_current))
	text = base_text % [time_dict.minute, time_dict.second]
