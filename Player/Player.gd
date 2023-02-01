extends KinematicBody2D

var velocity = Vector2.ZERO

var rotation_speed = 5.0
var speed = 5
var max_speed = 400

onready var bullet = load("res://bullet.tscn")
var nose = Vector2(0,-60)

func _ready():
	pass

func _physics_process(_delta):
	position.x = wrapf(position.x, 0, 1024)
	position.y = wrapf(position.y, 0, 600)
	velocity = velocity.normalized() * clamp(velocity.length(), 0, max_speed)
	velocity = velocity+ get_input()*speed
	velocity = move_and_slide(velocity, Vector2.ZERO)
	
	
	if Input.is_action_pressed("shoot"):
		var Effects = get_node_or_null("/root/Game/Effects")
		if Effects != null:
			var Bullet = bullet.instance()
			Bullet.global_position = global_position + nose.rotated(rotation)
			Bullet.rotation = rotation
			Effects.add_child(Bullet)
			
func get_input():
	var to_return = Vector2.ZERO
	$Exhaust.hide()
	if Input.is_action_pressed("forward"):
		to_return.y -=1
		$Exhaust.show()
	if Input.is_action_pressed("left"):
		rotation_degrees = rotation_degrees - rotation_speed
	if Input.is_action_pressed("right"):
		rotation_degrees = rotation_degrees + rotation_speed
	
	return to_return.rotated(rotation)
