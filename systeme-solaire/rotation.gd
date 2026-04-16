extends RigidBody3D

@export var vitesse_de_rotation: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation.y += deg_to_rad(delta * vitesse_de_rotation)
	if rotation.y >= deg_to_rad(180):
		print(rotation.y)
