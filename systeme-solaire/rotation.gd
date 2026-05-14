extends RigidBody3D

@export var periode_rot_s: float
@onready var parent_node = get_parent()
var mult:float
var acceleration_temps: float
var vitesse_de_rotation: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mult = parent_node.mult_jour_s
	acceleration_temps = mult * 24 * 60 * 60
	vitesse_de_rotation = 360 * acceleration_temps / periode_rot_s
	if not transform.is_finite():
		printerr("Invalid transform on: ", name)
		transform = Transform3D.IDENTITY


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation.y += deg_to_rad(delta * vitesse_de_rotation)
