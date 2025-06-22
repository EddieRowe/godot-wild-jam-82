extends CanvasLayer

var current_run_time : float = 0.0
@onready var timer_rich_text_label: RichTextLabel = $PanelContainer/TimerRichTextLabel
var running = false
@onready var animation_player: AnimationPlayer = $PanelContainer/TimerRichTextLabel/AnimationPlayer
var finish_line : Area2D 
@onready var finished_level_panel: PanelContainer = $Finished_Level_Panel

func _ready() -> void:
	var player : PlayerMovement = get_parent().get_node("Player/RigidBody2D")
	player.health.healthChanged.connect(_player_health_update)
	animation_player.play("timer_run")
	finish_line = get_parent().get_node("FinishLine")
	finish_line.finished_level.connect(_finished_level)
	player.game_started_signal.connect(_game_started)

func _player_health_update(newHealth : int) -> void:
	if newHealth <= 0 and running:
		running = false
		animation_player.play("timer_dead")

func _finished_level():
	running = false
	finished_level_panel.visible = true

func _game_started():
	running = true

func _process(delta: float) -> void:
	if running:
		current_run_time += delta
		_update_ui()
	
func _update_ui() -> void:
	if (!running):
		return
	timer_rich_text_label.text = _format_float_to_string(current_run_time)

func _format_float_to_string(time : float) -> String:
	var seconds : float = fmod(time , 60.0)
	var minutes : int   =  int(time / 60.0) % 60
	var mmss_string : String = "%02d:%05.2f" % [minutes, seconds]
	return mmss_string

func _pause_timer() -> void:
	running = false
