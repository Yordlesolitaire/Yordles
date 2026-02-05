extends CharacterBody2D

@export var target:Vector2 = self.position

var speed = 300
var acceleration = 7

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

func _ready() -> void:
	print(target)

func _physics_process(delta):
	navigation_agent.target_position = target
	var direction = Vector2.ZERO
	
	direction = navigation_agent.get_next_path_position() - global_position
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * speed, acceleration * delta)
	if navigation_agent.is_navigation_finished():
		return
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		target = get_global_mouse_position()
		print(get_global_mouse_position())
