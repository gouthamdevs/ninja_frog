extends Node

@onready var points_label: Label = $"../UI/Panel/PointsLabel"
@export var hearts: Array[Node]


var points = 0
var lives=3

func decrease_health():
	lives-=1
	print(lives)
	for h in 3:
		if h<lives:
			hearts[h].show()
		else:
			hearts[h].hide()
	
		
		
func add_points():
	points+=1
	print(points)
	points_label.text="points:" + str(points)
	
func on_death(anim_name:String):
	if anim_name=="death_anim":
		get_tree().reload_current_scene()
	
