extends Node2D

var portal
var player

func _ready():
	get_node("ParallaxBackground/ParallaxLayer/LivesLabel").text = str("Lives: ", global.lives)
	portal = get_node("Portal")
	player = get_node("Player")
	set_physics_process(true)

func _physics_process(delta):
	if portal.overlaps_body(player):
		global.lives = 3
		get_tree().change_scene("res://scenes/levels/Level4.tscn")