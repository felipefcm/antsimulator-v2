extends KinematicBody2D
class_name SteerableBody2D

export (int) var maxSpeed = 70;
export (float) var maxForce = 800;
export (NodePath) var targetNode;
export (bool) var turnWithVelocity = true;

var mode;
var velocity = Vector2.ZERO;
var target;

var maxSpeedOffset = 0;
var behaviourParams = {};

var behaviour;
var otherModes = [];
var otherTargets = [];

func _ready():
	if(targetNode):
		target = get_node(targetNode);

func setMode(newMode):
	mode = newMode;
	behaviour = SteeringBehaviours.modes[mode];
	otherModes = [];
	otherTargets = [];

func pushMode(newMode, optTarget = null):
	otherModes.push_back(newMode);
	otherTargets.push_back(optTarget);

func setTarget(newTarget, idx = 0):
	if(idx == 0): 
		target = newTarget;
	# else:
	# 	otherTargets[idx - 1] = newTarget;

func _physics_process(delta):
	
	if(behaviour):
		
		var steeringForce = behaviour.calculateSteeringForce(self, target);

		# var i = 0;
		# for pushedMode in otherModes:
		# 	print('will process additional state ', pushedMode);
		# 	var otherMode = SteeringBehaviours.modes[pushedMode];
		# 	var otherTarget = otherTargets[i];
		# 	var pushedSteeringForce = otherMode.calculateSteeringForce(self, otherTarget);
		# 	steeringForce += pushedSteeringForce;

		velocity += steeringForce.normalized() * maxForce * delta;
	else:
		velocity = Vector2.ZERO;

	if(turnWithVelocity): rotation = velocity.angle();

	velocity = move_and_slide(velocity.normalized() * (maxSpeed + maxSpeedOffset));
