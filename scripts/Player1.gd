extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 2900
const JUMP = -1500
const WALK = 400

var velocity = Vector2(0,10)
var jump_sound
var die_sound
var kill_monster_sound
var sprite

func _ready():
	jump_sound = get_node("JumpSound")
	die_sound = get_node("DieSound")
	kill_monster_sound = get_node("KilMonsterSound")
	sprite = get_node("Sprite")
	if global.lives < 3:
		die_sound.play()
	set_physics_process(true)

func _physics_process(delta):
	#Movement
	self.move_and_slide(velocity,UP)
	if Input.is_action_pressed("ui_left") and (not Input.is_action_pressed("ui_right")):
		velocity.x = -WALK
		sprite.set_flip_h(false)
	elif Input.is_action_pressed("ui_right") and (not Input.is_action_pressed("ui_left")):
		velocity.x = WALK
		sprite.set_flip_h(true)
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
	#Collisions
	for i in get_slide_count(): #um unico movimento pode causar várias colisões
		var collider = get_slide_collision(i).collider
		if collider.is_in_group("instakill"):
			global.lives -= 1
			global.just_died = true;
			get_tree().reload_current_scene()
			break
		elif collider.is_in_group("monsters"):
			if self.global_position.y + 48 < collider.global_position.y:
				kill_monster_sound.play()
				velocity.y = JUMP
				collider.queue_free()
			else:
				global.lives -= 1
				global.just_died = true
				get_tree().reload_current_scene()
				break # evita que o personagem morra mais de uma vez se houver mais de 1 colisão
