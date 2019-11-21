extends RigidBody2D

onready var Game = get_node("/root/Game")
onready var Starting = get_node("/root/Game/Starting")
onready var Camera = get_node("/root/Game/Camera")
onready var Boing = get_node("/root/Game/Boing")

func _ready():
	contact_monitor = true
	set_max_contacts_reported(4)

func _physics_process(delta):
	# Check for collisions
	var bodies = get_colliding_bodies()
	for body in bodies:
		if body.is_in_group("Tiles"):
			$ColorRect.color.r = rand_range(0,1)
			$ColorRect.color.g = rand_range(0,1)
			$ColorRect.color.b = rand_range(0,1)
			Camera.add_trauma(0.5)
			Boing.playing=true
			Boing.pitch_scale+=0.1
			Game.change_score(body.points)
			body.queue_free()

	if position.y > get_viewport().size.y:
		Game.change_lives(-1)
		Starting.startCountdown(3)
		queue_free()