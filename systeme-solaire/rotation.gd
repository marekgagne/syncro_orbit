extends RigidBody3D

@export var rayon_m: float
@export var periode_rot_s: float
var circ = 2 * PI * rayon_m
var vitesse_de_rotation = 360 / periode_rot_s

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation.y += deg_to_rad(delta * vitesse_de_rotation)
