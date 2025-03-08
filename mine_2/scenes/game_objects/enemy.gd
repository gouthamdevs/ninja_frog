extends CharacterBody2D

@onready var character_body_2d: CharacterBody2D = %CharacterBody2D
@onready var game_manager: Node = %GameManager
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D


var speed = -100
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta 
		
	if $RayCast2D.is_colliding():
		speed*=-1
		scale.x =abs(scale.x)*-1 
		
		
	velocity.x=speed
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name=="CharacterBody2D"):
		var y_delta= position.y-body.position.y
		var x_delta= body.position.x-position.x
		if (y_delta>80):
			body.hit=false
			print("destory enemy")
			animated_sprite_2d.hide()
			body.jump()
			speed=0
			sprite_2d.show()
			$AnimationPlayer.play("enemy_death")
			collision_shape_2d.set_deferred("disabled",true)
			collision_mask &= ~(1<<0)
			collision_layer &= ~(1<<0)
			$AnimationPlayer.animation_finished.connect(on_death,CONNECT_ONE_SHOT)		
		else:
			body.hit=true
			print("reduce player health")
			game_manager.decrease_health()
			if x_delta>0:
				body.jump_side(300)
			else:
				body.jump_side(-300)

			
func on_death(anim_name:String)->void:
	if anim_name=="enemy_death":
		queue_free()
		
