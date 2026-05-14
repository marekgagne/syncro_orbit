extends Camera3D
var pos_initiale = Vector3(3,3,3)
var rot_initiale = Vector3.ZERO
var vitesse = 10
var vitesse_rotation = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not transform.is_finite():
		printerr("Invalid transform on: ", name)
		transform = Transform3D.IDENTITY
	position = pos_initiale 
	rotation = rot_initiale


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Déplacements
	if Input.is_action_pressed("déplacement devant"):
		avancer(delta)
	if Input.is_action_pressed("déplacement arrière"):
		reculer(delta)
	if Input.is_action_pressed("déplacement droite"):
		droite(delta)
	if Input.is_action_pressed("déplacement gauche"):
		gauche(delta)
		
	#Rotation
	if Input.is_action_pressed("rotation gauche"):
		rotation_gauche(delta)
	if Input.is_action_pressed("rotation droite"):
		rotation_droite(delta)
	
	
	#Inclinaison
	if Input.is_action_pressed("Inclinaison bas"):
		inclinaison_bas(delta)
	if Input.is_action_pressed("inclinaison haut"):
		inclinaison_haut(delta)
		
	#Reset
	if Input.is_action_just_pressed("Reset"):
		reset_cam()
		
func avancer(delta):
	"""
	Déplace l'objet interpellé vers l'avant
		
	Paramètre :
	position -- position de la caméra
	"""
	
	position -= global_transform.basis.z * vitesse * delta

func reculer(delta):
	"""
	Déplace l'objet interpellé vers l'arrière
		
	Paramètre :
	position -- position de la caméra
	"""
	
	position += global_transform.basis.z * vitesse * delta

func droite(delta):
	"""
	Déplace l'objet interpellé vers la droite
		
	Paramètre :
	position -- position de la caméra
	"""
	
	position += global_transform.basis.x * vitesse * delta

func gauche(delta):
	"""
	Déplace l'objet interpellé vers la gauche
		
	Paramètre :
	position -- position de la caméra
	"""
	
	position -= global_transform.basis.x * vitesse *  delta

func rotation_gauche(delta):
	"""
	Fait tourner l'objet sur lui-même vers la gauche
	"""
	
	rotate_y(vitesse_rotation * delta)
	
func rotation_droite(delta):
	"""
	Fait tourner l'objet sur lui-même vers la droite
	"""
	
	rotate_y(-vitesse_rotation * delta)
	
func inclinaison_bas(delta):
	"""
	Fait tourner l'objet sur lui-même vers le bas
	"""
	
	rotate_x(-vitesse_rotation * delta)
	
func inclinaison_haut(delta):
	"""
	Fait tourner l'objet sur lui-même vers le haut
	"""
	
	rotate_x(vitesse_rotation * delta)
	
func reset_cam():
	"""
	Réinitialise la position et la rotation de la caméra
		
	Paramètre :
	position -- position de la caméra
	rotation -- rotation de la caméra
	"""
	
	position = pos_initiale 
	rotation = rot_initiale
