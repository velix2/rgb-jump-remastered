extends Node

var start_time: float

func reset_start_time() -> void:
	start_time = Time.get_unix_time_from_system()

func get_time_interval_since_start_unix(timestamp_unix: float) -> float:
	return timestamp_unix - start_time
	
func get_playtime_unix() -> float:
	return get_time_interval_since_start_unix(Time.get_unix_time_from_system())
