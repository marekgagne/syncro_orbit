extends RigidBody3D
var masse: float = 6.4185e23
var p_x = Vector3(1,0,0)
var r_p : float = 206655000000
var r_a : float = 249230000000
var r_i = r_p * p_x
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
