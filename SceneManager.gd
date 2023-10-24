extends Node

@export var PlayerScene : PackedScene
var red_score = 0
var blue_score = 0
@onready var red_s = get_node("red_Score")
@onready var blue_s = get_node("blue_Score")

# Called when the node enters the scene tree for the first time.
func _ready():
	var index = 0
	for i in GameManager.Players:
		var currentPlayer = PlayerScene.instantiate()
		currentPlayer.name = str(GameManager.Players[i].id)
		add_child(currentPlayer)
		for spawn in get_tree().get_nodes_in_group("PlayerSpawnGroup"):
			if spawn.name == str(index):
				currentPlayer.global_position = spawn.global_position
		index += 1
	pass # Replace with function body.

func correct_score_dropped_frames():
	if blue_score == 0:
		blue_s.global_position.x = 1000
	elif blue_score == 1:
		blue_s.global_position.x = 1100
	elif blue_score == 2:
		blue_s.global_position.x = 1200
	else:
		blue_s.global_position.x = 2000
	pass
	
	if red_score == 0:
		red_s.global_position.x = 100
	elif red_score == 1:
		red_s.global_position.x = 200
	elif red_score == 2:
		red_s.global_position.x = 300
	else:
		red_s.global_position.x = 2000

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	correct_score_dropped_frames()
	var puck = get_node("puck")
	var index = 0
	
	if puck.global_position.x <= 5:
		puck.global_position = get_node("PuckSpawnLocations/0").global_position
		puck.angular_velocity = 0.0
		puck.linear_velocity = Vector2.ZERO
		blue_s.global_position.x += 100
		blue_score += 1
		
		
	if puck.global_position.x >= 1275:
		puck.global_position = get_node("PuckSpawnLocations/0").global_position
		puck.angular_velocity = 0.0
		puck.linear_velocity = Vector2.ZERO
		red_s.global_position.x += 100
		red_score += 1
		
	if puck.global_position.y <= 13:
		puck.global_position = get_node("PuckSpawnLocations/0").global_position
		puck.angular_velocity = 0.0
		puck.linear_velocity = Vector2.ZERO
	
	if puck.global_position.y >= 707:
		puck.global_position = get_node("PuckSpawnLocations/0").global_position
		puck.angular_velocity = 0.0
		puck.linear_velocity = Vector2.ZERO
		
	if blue_score == 3:
		var scene = load("res://blue_wins.tscn").instantiate()
		get_tree().root.add_child(scene)
		
	
	if red_score == 3:
		var scene = load("res://red_wins.tscn").instantiate()
		get_tree().root.add_child(scene)
		
	pass
