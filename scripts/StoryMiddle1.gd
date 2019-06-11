extends Node2D

func _ready():
	get_node("Timer").connect("timeout",self,"proxima_cena")


func proxima_cena():
	get_tree().change_scene("res://scenes/Instructions2.tscn")
