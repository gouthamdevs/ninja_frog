extends Area2D
@onready var game_manager: Node = %GameManager


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(_delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if(body.name== "CharacterBody2D"):
		queue_free()
		game_manager.add_points()
