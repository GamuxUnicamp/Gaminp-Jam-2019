extends Node2D

onready var credits_panel = get_node("CreditsPanel")

func _ready():
	get_node("PlayButton").connect("button_down",self,"_on_play_down")
	get_node("CreditsButton").connect("button_down",self,"_on_credits_down")
	get_node("CreditsPanel/CloseButton").connect("button_down",self,"_on_close_down")

func _on_play_down():
	get_tree().change_scene("res://scenes/Instructions1.tscn")

func _on_credits_down():
	credits_panel.visible = true

func _on_close_down():
	credits_panel.visible = false