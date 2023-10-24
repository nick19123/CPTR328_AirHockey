extends CharacterBody2D

var score = 0

const m_sp = 400
const a = 2000
const uk = 500 

var input = Vector2.ZERO

var screen_size 
var syncPos = Vector2(0, 0)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _ready():
	$MultiplayerSynchronizer.set_multiplayer_authority(str(name).to_int())
	#screen_size = get_viewport_rect().size 

func _physics_process(delta):
	player_movement(delta)
	
func get_input():
	input.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	input.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	return input.normalized()

func player_movement(delta):
	if $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		input = get_input()
		if input == Vector2.ZERO:
			if velocity.length() > (uk * delta):
				velocity -= velocity.normalized() * (uk * delta)
			else:
				velocity = Vector2.ZERO
		else:
			velocity += (input * a * delta)
			velocity = velocity.limit_length(m_sp)
		move_and_slide()
		syncPos = global_position
	else:
		syncPos = global_position
		global_position = global_position.lerp(syncPos, 0.5)
	
