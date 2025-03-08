extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -900.0
@onready var game_manager: Node = %GameManager
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var hit_sprite: Sprite2D = $hit_sprite
@onready var bounce_timer: Timer = $bounceTimer
@onready var death_sprite: Sprite2D = $death_sprite
@onready var portal: Area2D = %portal
@onready var teleport_sprite: Sprite2D = $teleport_sprite

var hit=false
var is_bouncing=false
var teleport=false

func jump():
	velocity.y=JUMP_VELOCITY

func jump_side(x):
	is_bouncing=true
	bounce_timer.start(0.3)
	velocity.y=-400
	velocity.x=x
	move_and_slide()
	

	
func _physics_process(delta: float) -> void:
	
	if is_bouncing:
		if not is_on_floor():
			velocity += get_gravity() * delta
			if hit==true:
				sprite_2d.hide()
				hit_sprite.show()
				$AnimationPlayer.play("hit_anim")
				$AnimationPlayer.animation_finished.connect(on_hit,CONNECT_ONE_SHOT)
		move_and_slide()
		return
			
	if(velocity.x>1||velocity.x<-1):
		sprite_2d.animation="running"
	else:
		sprite_2d.animation="default"

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if not is_on_floor():
			sprite_2d.animation="jumping"
	if game_manager.lives==0:
		sprite_2d.hide()
		death_sprite.show()
		hit_sprite.hide()
		$AnimationPlayer.play("death_anim")
		$AnimationPlayer.animation_finished.connect(game_manager.on_death,CONNECT_ONE_SHOT)
	if teleport==true:
		sprite_2d.hide()
		teleport_sprite.show()
		$AnimationPlayer.play("teleport_anim")
		$AnimationPlayer.animation_finished.connect(portal.on_teleport,CONNECT_ONE_SHOT)

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0,12)
	var isLeft =velocity.x<0
	sprite_2d.flip_h=isLeft

	move_and_slide()
	
func on_hit(anim_name:String):
	if anim_name=="hit_anim":
		hit=false
		hit_sprite.hide()
		sprite_2d.show()
		
	
	


func _on_bounce_timer_timeout() -> void:
	is_bouncing=false # Replace with function body.
