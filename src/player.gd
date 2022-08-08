extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal hit
export var speed = 400
var screen_size
var rotation_degree

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	screen_size = get_viewport_rect().size 
	
	
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	$AnimatedSprite.animation = "default"
	
	if velocity.x > 0 and velocity.y == 0:
		rotation_degrees = 0
	elif velocity.x > 0 and velocity.y > 0:
		rotation_degrees = 45
	elif velocity.x == 0 and velocity.y > 0:
		rotation_degrees = 90
	elif velocity.x < 0 and velocity.y > 0:
		rotation_degrees = 135
	elif velocity.x < 0 and velocity.y ==0:
		rotation_degrees = 180
	elif velocity.x < 0 and velocity.y < 0:
		rotation_degrees = 225
	elif velocity.x == 0 and velocity.y < 0:
		rotation_degrees = 270	
	elif velocity.x > 0 and velocity.y < 0:
		rotation_degrees = 315
	var is_shooting 
	if Input.is_action_just_pressed("shoot"):
		is_shooting = $Canon.shoot(rotation_degrees)


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func _on_player_body_entered(body):
	if body is enemy:
		hide() # Player disappears after being hit.
		emit_signal("hit")
		# Must be deferred as we can't change physics properties on a physics callback.
		$CollisionShape2D.set_deferred("disabled", true)
	
