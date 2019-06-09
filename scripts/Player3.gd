extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 1500
const JUMP = -800
const WALK = 400
const SHOOT_POS_LEFT = Vector2(70,0)
const SHOOT_POS_RIGHT = Vector2(-70,0)
const BULLET_VEL_LEFT = Vector2(1200,0)
const BULLET_VEL_RIGHT = Vector2(-1200,0)

var velocity = Vector2(0,10)
var sprite
var jump_sound
var die_sound
var kill_monster_sound
var attack_timer
var bullet_scene
var bullet_holder
var shoot_sound

func _ready():
	sprite = get_node("Sprite")
	jump_sound = get_node("JumpSound")
	die_sound = get_node("DieSound")
	shoot_sound = get_node("ShootSound")
	kill_monster_sound = get_node("KilMonsterSound")
	attack_timer = get_node("AttackTimer")
	bullet_scene = load("res://scenes/Bullet.tscn")
	bullet_holder = get_node("BulletHolder")
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
		#chain.position = chain_pos_right
	elif Input.is_action_pressed("ui_right") and (not Input.is_action_pressed("ui_left")):
		velocity.x = WALK
		sprite.set_flip_h(true)
		#chain.position = chain_pos_left
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
	if attack_timer.get_time_left() == 0 and Input.is_action_pressed("ui_attack"):
		var bullet = bullet_scene.instance()
		if sprite.flip_h:
			bullet.position = self.position + SHOOT_POS_LEFT
			bullet.bullet_velocity = BULLET_VEL_LEFT
		else:
			bullet.position = self.position +SHOOT_POS_RIGHT
			bullet.bullet_velocity = BULLET_VEL_RIGHT
		shoot_sound.play()
		get_parent().add_child(bullet)
		reset_timer()
	#Collisions
	for i in get_slide_count(): #um unico movimento pode causar várias colisões
		var collider = get_slide_collision(i).collider
		if collider.is_in_group("instakill"):
			global.lives -= 1
			get_tree().reload_current_scene()
			break
		elif collider.is_in_group("monsters"):
			global.lives -= 1
			get_tree().reload_current_scene()
			break # evita que o personagem morra mais de uma vez se houver mais de 1 colisão
		elif collider.is_in_group("stair"):
			if Input.is_action_pressed("ui_up"):
				velocity.y = WALK
				
func _process(delta):
	pass

func reset_timer():
	attack_timer.set_wait_time(0.5)
	attack_timer.start()
