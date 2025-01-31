extends CharacterBody2D

@export var animated_sprite_2d: AnimatedSprite2D

var speed = 50
var has_aggro = false
var player : CharacterBody2D = null

func _physics_process(delta: float) -> void:
	if has_aggro:
		var direction = (player.position - position).normalized()
		
		# Get the angle and convert to degrees
		var angle = direction.angle()
		
		# Convert angle to degrees and normalize it
		var degrees = rad_to_deg(angle)
		if degrees < 0:
			degrees += 360
			
		# Check which quadrant we're in
		if degrees >= 315 or degrees < 45:
			animated_sprite_2d.play("walk_right")
		elif degrees >= 45 and degrees < 135:
			animated_sprite_2d.play("walk_front")
		elif degrees >= 135 and degrees < 225:
			animated_sprite_2d.play("walk_left")
		elif degrees >= 225 and degrees < 315:
			animated_sprite_2d.play("walk_back")
		
		velocity = direction * speed
		move_and_slide()
	else:
		animated_sprite_2d.play("idle_front")
		


func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	has_aggro = true


func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	has_aggro = false
