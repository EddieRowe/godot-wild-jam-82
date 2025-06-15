extends Node2D
class_name SubmarineAudio

@export var sub_prop_audio_stream_player : AudioStreamPlayer

func _ready() -> void:
	sub_prop_audio_stream_player.volume_db = -999.0

func _start_sub_prop_audio() -> void:
	if !sub_prop_audio_stream_player.playing:
		var tween = get_tree().create_tween()
		tween.tween_property(sub_prop_audio_stream_player, "volume_db", -5.0, .1)
		sub_prop_audio_stream_player.play()

func _stop_sub_prop_audio() -> void:
	if sub_prop_audio_stream_player.playing:
		var tween = get_tree().create_tween()
		tween.tween_property(sub_prop_audio_stream_player, "volume_db", -999.0, .1)
		sub_prop_audio_stream_player.stop()
