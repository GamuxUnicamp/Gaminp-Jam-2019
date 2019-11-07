extends Node2D

var portal
var player

func _ready():
	get_node("CanvasLayer/LivesLabel").text = str("Lives: ", global.lives)
	if global.just_died:
		get_node("ParallaxBackground/ParallaxLayer/background1/AnimationPlayer").play("glitch")
		global.just_died = false
	portal = get_node("Portal")
	player = get_node("Player")
	if global.is_mobile:
		var mobile_buttons = load("res://scenes/mobile/MobileButtons3.tscn").instance()
		get_node("CanvasLayer").add_child(mobile_buttons)
	set_physics_process(true)

func _physics_process(delta):
	if portal.overlaps_body(player):
		get_tree().change_scene("res://scenes/StoryEnd.tscn")
	for stair in $Stairs.get_children():
		if stair.overlaps_body(player):
			player.velocity.y = player.JUMP
