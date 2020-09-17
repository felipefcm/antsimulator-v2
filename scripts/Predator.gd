extends Node2D

onready var steeringObj = $SteerableBody2D;
# onready var stateMachine = $StateMachine;
onready var sprite = steeringObj.get_node('Sprite');

func _ready():
	add_to_group('predators');
	steeringObj.setMode('Wander');

func _physics_process(_delta):
	adjustSprite();

func adjustSprite():
	if(steeringObj.velocity.x < 0):
		sprite.flip_h = true;
	else:
		sprite.flip_h = false;
