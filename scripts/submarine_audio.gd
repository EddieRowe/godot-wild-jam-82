extends Node2D
class_name SubmarineAudio

@export var sub_prop_audio_stream_player : AudioStreamPlayer
@onready var submarine_take_damage: AudioStreamPlayer = $"Submarine Take Damage"

func _ready() -> void:
	var player : PlayerMovement = get_parent().get_node("RigidBody2D")
	sub_prop_audio_stream_player.volume_db = -999.0
	sub_prop_audio_stream_player.play()
	player.health.tookDamage.connect(_take_damage)

func _start_sub_prop_audio() -> void:
	#if !sub_prop_audio_stream_player.playing:
	var tween = get_tree().create_tween()
	tween.tween_property(sub_prop_audio_stream_player, "volume_db", -5.0, .1)
		#sub_prop_audio_stream_player.play()

func _stop_sub_prop_audio() -> void:
	#if sub_prop_audio_stream_player.playing:
	var tween = get_tree().create_tween()
	tween.tween_property(sub_prop_audio_stream_player, "volume_db", -999.0, .1)
		#sub_prop_audio_stream_player.stop()

func _take_damage() -> void:
	submarine_take_damage.pitch_scale = randf_range(0.8, 1.1)
	submarine_take_damage.play()
