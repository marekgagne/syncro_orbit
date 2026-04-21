extends Camera3D
var pos_initiale = Vector3(3,3,3)
var avant_camera = -global_transform.basis.z
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = pos_initiale 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("déplacement devant"):
		avancer()
	if Input.is_action_just_pressed("déplacement arrière"):
		avancer()


func avancer() -> void :
	position += avant_camera
	
func reculer() -> void :
	position -= avant_camera
