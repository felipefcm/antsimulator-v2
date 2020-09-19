extends SteerableBody2D
class_name Predator

# onready var stateMachine = $StateMachine;
onready var sprite = $Sprite;

func _ready():
	add_to_group('predators');
	setMode('Wander');

func _physics_process(_delta):
	adjustSprite();

func adjustSprite():
	if(velocity.x < 0):
		sprite.flip_h = true;
	else:
		sprite.flip_h = false;
