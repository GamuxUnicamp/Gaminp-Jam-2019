extends Node2D

func _ready():
	get_node("Timer").connect("timeout",self,"proxima_cena")
	var os_name = OS.get_name()
	if os_name == "Android" or os_name == "iOS":
		global.is_mobile = true
	set_process_input(true)

func _input(event):
	#proxima_cena()
	if (event is InputEventKey or event is InputEventScreenTouch):
		proxima_cena()
	pass

func proxima_cena():
	get_tree().change_scene("res://scenes/MainMenu.tscn")
