extends Node

const SPEED : float = 5.0
const ACCELLERATION  : float = 0.02
const GRAVITY : float = 40.0

var pawn : PhysicsBody3D
var direction : Vector3
var floor_cast : RayCast3D

var target_velocity : Vector3
var velocity : Vector3
var current_velocity : Vector3

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
	if not floor_cast.is_colliding():
		direction.y -= GRAVITY * delta
	
	# apply movement
	target_velocity = direction * delta * SPEED
	velocity.x = move_toward(current_velocity.x, target_velocity.x, ACCELLERATION * delta)
	velocity.x = move_toward(current_velocity.y, target_velocity.y, ACCELLERATION * delta)
	velocity.x = move_toward(current_velocity.z, target_velocity.z, ACCELLERATION * delta)
	current_velocity = velocity
	pawn.move_and_collide(target_velocity)
