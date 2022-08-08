class_name bullet
extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.playing = true

		
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()



func _on_Area2D_body_entered(body):
		if body is enemy:
			queue_free()
			body.destroy()
			$CollisionShape2D.set_deferred("disabled", true)
