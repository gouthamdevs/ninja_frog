extends Node
@onready var points_label: Label = $"../sceneObjects/UI/Panel/PointsLabel"

var points = 0
func add_points():
	points+=1
	print(points)
	points_label.text=str("Points: ",points)
	
