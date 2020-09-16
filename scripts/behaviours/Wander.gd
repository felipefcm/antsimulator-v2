
var circleDistance := 50;
var circleRadius := 15;
var maxAngleChange := deg2rad(10);

func calculateSteeringForce(steeringObj, target):

	if(!steeringObj.behaviourParams.has('wanderAngle')):
		steeringObj.behaviourParams.wanderAngle = rand_range(0, PI * 2);

	var wanderAngle = steeringObj.behaviourParams.wanderAngle;

	if(steeringObj.velocity.length() <= 5):
		steeringObj.velocity = Vector2(randf(), randf());
	
	var circleCenter = steeringObj.velocity.normalized() * circleDistance;
	var displacement = (Vector2(0, 1) * circleRadius).rotated(wanderAngle);

	steeringObj.behaviourParams.wanderAngle += rand_range(-maxAngleChange, maxAngleChange);
	
	return circleCenter + displacement;
	
