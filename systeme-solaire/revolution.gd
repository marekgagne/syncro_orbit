extends Node3D

@export var masse_kg: float
@export var v_p_ms: float
@export var r_p_m: float
@export var v_a_ms: float
@export var r_a_m: float
@export var centre_rotation: Node3D
@export var periode_revolution_s: float
@export var etapes_calcul_par_ecran: int
@export var v_ms: Vector3
@export var r_m: Vector3

var position_réelle = r_p_m
var G = 6.67e-11
var r_a_sim = log(r_a_m) / log(10)
var r_p_sim = log(r_p_m) / log(10)
var r_i: Vector3
var v_i: Vector3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	r_i = r_m
	position = conv_position(r_i)
	v_i = v_ms
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	appliquer_rk(delta)
	position = conv_position(r_i)

func calculer_acceleration_gravitationnelle(position_rellee: Vector3) -> Vector3:
	var facteur = -G * masse_kg * centre_rotation.masse / (position_rellee.length()**3)
	var force = (position_rellee - centre_rotation.r_i) * facteur
	return force / masse_kg
	
func conv_position(position_reelle : Vector3) -> Vector3:
	var distance_relle = position_reelle.length()
	var ratio_distance = inverse_lerp(r_p_m, r_a_m,
	distance_relle)
	var facteur_distance_simulee = lerp (r_p_sim, r_a_sim,
	ratio_distance)
	return position_reelle.normalized() * facteur_distance_simulee
	
func appliquer_rk(temps_dernier_ecran: float) -> void:
	var nb_periode = temps_dernier_ecran  * periode_revolution_s
	var h = nb_periode / etapes_calcul_par_ecran
	var a_i = calculer_acceleration_gravitationnelle(r_i)
	var vk1 = v_i * a_i
	var vk2 = a_i * ((vk1 * (h/2)) + v_i)
	var vk3 = a_i * ((vk2 * (h/2)) + v_i)
	var vk4 = a_i * ((vk3 * h) + v_i)
	var v_plus_un = v_i + ((h/6) * (vk1 + 2 * vk2 + 2 * vk3 + vk4))
	
	var rk1 = r_i * v_plus_un
	var rk2 = v_plus_un * (vk1 * (h/2) + r_i)
	var rk3 = v_plus_un * (vk2 * (h/2) + r_i)
	var rk4 = v_plus_un * ((rk3 * h) + v_i)
	var r_plus_un = r_i + ((h/6) * (rk1 + 2 * rk2 + 2 * rk3 + rk4))
	
	r_i = r_plus_un
	v_i = v_plus_un
