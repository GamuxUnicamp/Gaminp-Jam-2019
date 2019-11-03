extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 1500
const JUMP = -800
const WALK = 400
const chain_pos_left = Vector2(97,0)
const chain_pos_right = Vector2(-97,0)

var velocity = Vector2(0,10)
var sprite
var jump_sound
var die_sound
var kill_monster_sound
var chain
var sprite_chain
var attack_timer

func _ready():
	sprite = get_node("Sprite")
	jump_sound = get_node("JumpSound")
	die_sound = get_node("DieSound")
	kill_monster_sound = get_node("KilMonsterSound")
	chain = get_node("Chain")
	sprite_chain = get_node("Chain/Sprite")
	attack_timer = get_node("AttackTimer")
	if global.lives < 3:
		die_sound.play()
	set_physics_process(true)
	set_process(true)

func _physics_process(delta):
	#Movement
	self.move_and_slide(velocity,UP)
	if Input.is_action_pressed("ui_left") and (not Input.is_action_pressed("ui_right")):
		velocity.x = -WALK
		sprite.set_flip_h(false)
		chain.position = chain_pos_right
		sprite_chain.set_flip_h(true)
	elif Input.is_action_pressed("ui_right") and (not Input.is_action_pressed("ui_left")):
		velocity.x = WALK
		sprite.set_flip_h(true)
		chain.position = chain_pos_left
		sprite_chain.set_flip_h(false)
	else:
		velocity.x = 0
	if self.is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = JUMP
			jump_sound.play()
		else:
			velocity.y = 10
	else:
		velocity.y += GRAVITY*delta
	if self.is_on_ceiling():
		velocity.y = 1
	#Attack
	if attack_timer.get_time_left() < 0.5:
		chain.visible = false
	if attack_timer.get_time_left() == 0 and Input.is_action_just_pressed("ui_attack"):
		chain.visible = true
		reset_timer()
	if chain.visible:
		var bodies = chain.get_overlapping_bodies()
		for b in bodies:
			if b.is_in_group("monsters"):
				kill_monster_sound.play()
				b.queue_free()
	#Collisions
	for i in get_slide_count(): #um unico movimento pode causar várias colisões
		var collider = get_slide_collision(i).collider
		if collider.is_in_group("instakill"):
			global.lives -= 1
			global.just_died = true
			get_tree().reload_current_scene()
			break
		elif collider.is_in_group("monsters"):
			global.lives -= 1
			global.just_died = true
			get_tree().reload_current_scene()
			break # evita que o personagem morra mais de uma vez se houver mais de 1 colisão

func _process(delta):
	pass

func reset_timer():
	attack_timer.set_wait_time(1)
	attack_timer.start()
