extends CharacterBody2D
class_name Yordle
@export var detect_zone:Area2D
@export var navigation_agent: NavigationAgent2D
@export var speed: float = 300.0
@export var acceleration: float = 10.0
@export var sprite: Node2D
@export var label:LineEdit
@export var max_dist:float = 10.0
var distance_parcourue: float = 0.0
var last_position: Vector2

var MAPs:Array = []
var states = []

func _ready() -> void:
	last_position = global_position
func _process(delta: float) -> void:
	if snapped((distance_parcourue * 10)/500 , 0.1) == max_dist:
		set_target(self.position)
		velocity = Vector2.ZERO
		
	if navigation_agent.is_navigation_finished():
		velocity = Vector2.ZERO
		last_position = global_position
		return

	var direction = navigation_agent.get_next_path_position() - global_position
	direction = direction.normalized()

	velocity = velocity.lerp(direction * speed, acceleration * delta)
	velocity = velocity.move_toward(direction * speed, acceleration)

	detec_hide()
	move_and_slide()

	# --- Compteur de distance ---
	var delta_dist = global_position.distance_to(last_position)
	distance_parcourue += delta_dist
	last_position = global_position
	if self.label:
		label.text = str(snapped((distance_parcourue * 10)/500 , 0.1))+"mètres"



func detec_hide():
	sprite.modulate.a = 1.0
	for elt in detect_zone.get_overlapping_bodies():
		if elt is TileMapLayer:
			var map_pos = elt.local_to_map(position)
			var tile_data = elt.get_cell_tile_data(map_pos)
			if tile_data and tile_data.has_custom_data("Cachette"):
				var cachette = tile_data.get_custom_data("Cachette")
				sprite.modulate.a = 0.5


func set_target(target: Vector2) -> void:
	navigation_agent.target_position = target
