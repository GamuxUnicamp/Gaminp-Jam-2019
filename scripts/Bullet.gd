extends KinematicBody2D

var bullet_velocity = Vector2(0,0)

onready var kill_monster_sound = $KillMonsterSound

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	var collision = self.move_and_collide(delta*bullet_velocity)
	if collision:
		var collider = collision.collider
		if collider.is_in_group("monsters"):
			kill_monster_sound.play()
			collider.queue_free()
		self.queue_free()
