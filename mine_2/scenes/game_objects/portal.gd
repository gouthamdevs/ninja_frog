extends Area2D


@export var target_level : PackedScene

func _on_body_entered(body: Node2D) -> void:
		if (body.name == "CharacterBody2D"):
			body.teleport=true

func on_teleport(anim_name:String):
	if anim_name=="teleport_anim":
		get_tree().change_scene_to_packed(target_level)
