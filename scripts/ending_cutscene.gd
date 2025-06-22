extends Node
@onready var submarine: Sprite2D = $Submarine
@onready var prop_sprite_2d: Sprite2D = $Submarine/PropSprite2D
@onready var prop_sprite_animation_player: AnimationPlayer = $Submarine/PropSprite2D/PropSpriteAnimationPlayer
@onready var sub_animation_player: AnimationPlayer = $Submarine/SubAnimationPlayer
@onready var animation_player: AnimationPlayer = $Environment/JellyfishPink2/AnimationPlayer
@onready var animation_player2: AnimationPlayer = $Environment/ColorRect/JellyfishPink/AnimationPlayer
@onready var animation_player3: AnimationPlayer = $Submarine2/AnimationPlayer

func _ready() -> void:
	prop_sprite_animation_player.play("propellor_anim")
	sub_animation_player.play("sub_ending")
	animation_player.play("bg_jellyanim1")
	animation_player2.play("jly2anim")
	animation_player3.play("sub_rocks")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
