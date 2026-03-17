extends RigidBody3D

@export var masse_europe: float 
var temps_orbit: float = 299.819e3
var masse_jupiter: float = 1.989e27
@export var r_p: float
@export var v_p: float 
var k:float = 1e14
var d:float = 249.7e6
var coef_dissip:float = 4e16
@export var centre_de_rotation: RigidBody3D
@export var autre_moitié: RigidBody3D

var G : float = 6.673e-11
var position_relle:float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func calculer_acceleration_gravitationnelle(position_rellee: Vector3) -> Vector3:
	var pos_autre_moitié = Vector3(autre_moitié.poition)
	var r_diff= ( pos_autre_moitié- position_relle)
	var r_diff_unit = Vector3(r_diff) / r_diff
	var facteur = -G * masse_europe * masse_jupiter / (position_rellee.length()**3)
	var force_rappel = k * (r_diff-d) * r_diff_unit
	"faire frict."
	var force = ((position_rellee - centre_de_rotation.position) * facteur)
	return force / masse_europe
