extends Node

const JUMP_SPEED : float = 12.0
const JUMP_ACC : float = 1.0
const max_jump_time : float = 0.2

var pawn : CharacterBody3D
var floor_cast : RayCast3D
var target_velocity : Vector3

var direction : Vector3
var is_jumping : bool = false
var curr_jump_time : float = 0.0

func _ready() -> void:
	pawn = get_parent()
	
	# set up a flor detector
	floor_cast = RayCast3D.new()
	self.add_child(floor_cast)

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("jump"):
		floor_cast.position = pawn.position + Vector3(0, 0.05, 0)
		floor_cast.target_position = Vector3(0, -0.1, 0)
		floor_cast.force_raycast_update()
		
		if floor_cast.is_colliding():
			direction.y = 1
			is_jumping = true
			curr_jump_time = 0.0
			target_velocity = direction * delta * JUMP_SPEED
	elif is_jumping and Input.is_action_pressed("jump"):
		
		curr_jump_time += delta
		if curr_jump_time >= max_jump_time:
			is_jumping = false
	else:
		target_velocity.x = move_toward(target_velocity.x, 0, JUMP_ACC * delta)
		target_velocity.y = move_toward(target_velocity.y, 0, JUMP_ACC * delta)
		target_velocity.z = move_toward(target_velocity.z, 0, JUMP_ACC * delta)
	
	pawn.move_and_collide(target_velocity)
