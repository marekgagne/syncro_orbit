extends RigidBody3D

@export var periode_rot_s: float
var vitesse_de_rotation = 360 / periode_rot_s

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not transform.is_finite():
		printerr("Invalid transform on: ", name)
		transform = Transform3D.IDENTITY


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation.y += deg_to_rad(delta * vitesse_de_rotation)
