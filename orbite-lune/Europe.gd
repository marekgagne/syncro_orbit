extends RigidBody3D

@export var masse_europe: float 
var temps_orbit: float = 299.819e3
var masse_jupiter: float = 1.989e27
@export var r_p_reelle: float
@export var v_p_reelle: float
var k:float = 1e14
var d:float = 249.7e6
var coef_dissip:float = 4e16
@export var centre_de_rotation: RigidBody3D
@export var autre_moitié: RigidBody3D

var G : float = 6.673e-11
var r_i : Vector3
var excentricite: float = (((v_p_reelle ** 2) * r_p_reelle)/(G * masse_jupiter))
var r_a_reelle: float = ((-1*excentricite*(r_p_reelle) - r_p_reelle)/(excentricite - 1))
var r_p_simulee: float = log(r_p_reelle) / log(10)
var r_a_simulee: float = log(r_a_reelle) / log(10)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	r_i = r_p_reelle * Vector3(1, 0, 0)
	position = conv_position_reelle_a_simulee(r_i)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func calculer_acceleration(position_reelle: Vector3) -> Vector3:
	var pos_autre_moitié = Vector3(autre_moitié.poition)
	var r_diff= ( pos_autre_moitié- position_reelle)
	var r_diff_unit = Vector3(r_diff) / r_diff
	var facteur = -G * masse_europe * masse_jupiter / (position_reelle.length()**3)
	var force_rappel = k * (r_diff-d) * r_diff_unit
	"faire frict."
	var force = ((position_reelle - centre_de_rotation.position) * facteur) + force_rappel
	return force / masse_europe

func conv_position_reelle_a_simulee(position_reelle : Vector3) -> Vector3:
	var distance_relle = position_reelle.length()
	var ratio_distance = inverse_lerp(r_p_reelle, r_a_reelle,
	distance_relle)
	var facteur_distance_simulee = lerp (r_p_simulee, r_a_simulee,
	ratio_distance)
	return position_reelle.normalized() * facteur_distance_simulee
