extends KinematicBody2D

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
var otherModes;

func _ready():
	if(targetNode):
		target = get_node(targetNode);

func setMode(newMode):
	mode = newMode;
	behaviour = SteeringBehaviours.modes[mode];
	otherModes = [];

func pushMode(newMode):
	otherModes.push_back(newMode);

func setTarget(newTarget):
	target = newTarget;

func _physics_process(delta):
	
	if(behaviour):
		
		var steeringForce = behaviour.calculateSteeringForce(self, target);

		for pushedMode in otherModes:
			var otherMode = SteeringBehaviours.modes[pushedMode];
			var pushedSteeringForce = otherMode.calculateSteeringForce(self, target);
			steeringForce += pushedSteeringForce;

		velocity = velocity + steeringForce.normalized() * maxForce * delta;
	else:
		velocity = Vector2.ZERO;

	if(turnWithVelocity): rotation = velocity.angle();

	velocity = move_and_slide(velocity.normalized() * (maxSpeed + maxSpeedOffset));
