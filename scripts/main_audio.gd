extends Node2D

var music_audio_stream_player : AudioStreamPlayer

func _ready() -> void:
	music_audio_stream_player = get_node("MusicAudioStreamPlayer")
	var player : PlayerMovement = get_parent().get_node("Player/RigidBody2D")
	player.health.healthChanged.connect(_player_health_update)

func _player_health_update(newHealth : int) -> void:
	if newHealth <= 0 and music_audio_stream_player.playing:
		var tween = get_tree().create_tween()
		tween.tween_property(music_audio_stream_player, "pitch_scale", 0, 3)
		tween.tween_callback(music_audio_stream_player.stop)
