extends Position2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const BULLET_VELOCITY = 500
const Bullet = preload ("res://src/Bullet.tscn")
onready var timer = $Cooldown
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
const VELOCITY_BASE = 1000
func shoot(rotation):
	if not timer.is_stopped():
		return false
	var bullet = Bullet.instance()
	bullet.rotation_degrees = rotation
	bullet.global_position = global_position
	if rotation == 0:
		bullet.linear_velocity = Vector2(1,0)*VELOCITY_BASE
	elif rotation == 45:
		bullet.linear_velocity = Vector2(1,1).normalized()*VELOCITY_BASE
	elif rotation == 90:
		bullet.linear_velocity = Vector2(0,1)*VELOCITY_BASE
	elif rotation == 135:
		bullet.linear_velocity = Vector2(-1,1).normalized()*VELOCITY_BASE
	elif rotation == 180:
		bullet.linear_velocity = Vector2(-1,0)*VELOCITY_BASE
	elif rotation == 225:
		bullet.linear_velocity = Vector2(-1,-1).normalized()*VELOCITY_BASE
	elif rotation == 270:
		bullet.linear_velocity = Vector2(0,-1)*VELOCITY_BASE
	elif rotation == 315:
		bullet.linear_velocity = Vector2(1,-1).normalized()*VELOCITY_BASE
	

	bullet.set_as_toplevel(true)
	add_child(bullet)
	timer.start()
	return true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
