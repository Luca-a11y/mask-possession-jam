extends Node

const SPEED : float = 7.0
const ON_GROUND_ACC : float = 0.6
const IN_AIR_ACC : float = 0.4
const GRAVITY : float = 7.0

var pawn : PhysicsBody3D
var direction : Vector3
var floor_cast : RayCast3D

var target_velocity : Vector3
var velocity : Vector3
var current_velocity : Vector3
var accelleration : float

func _ready() -> void:
	pawn = get_parent()
	
	# set up a flor detector
	floor_cast = RayCast3D.new()
	self.add_child(floor_cast)
	
	print_tree()

func _physics_process(delta: float) -> void:
	# reset last direction
	direction = Vector3.ZERO
	
	# get input direction
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	if Input.is_action_pressed("move_backward"):
		direction.z += 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	
	# normalize direction
	direction = direction.normalized()
	
	# apply gravity
	floor_cast.position = pawn.position + Vector3(0, 0.05, 0)
	floor_cast.target_position = Vector3(0, -0.1, 0)
	var is_in_air : bool = not floor_cast.is_colliding()
	if is_in_air:
		accelleration = IN_AIR_ACC
		direction.y -= GRAVITY
		direction /= 1.2
	else:
		current_velocity.y = 0
		accelleration = ON_GROUND_ACC
	
	# apply movement
	target_velocity = direction * delta * SPEED
	target_velocity.y += current_velocity.y
	velocity.x = move_toward(current_velocity.x, target_velocity.x, accelleration * delta)
	velocity.y = move_toward(current_velocity.y, target_velocity.y, accelleration * delta)
	velocity.z = move_toward(current_velocity.z, target_velocity.z, accelleration * delta)
	
	current_velocity = velocity
	
	pawn.move_and_collide(velocity)
