
export (float) var circleDistance := 3;
export (float) var circleRadius := 6;
export (float) var maxAngleChange := 0.1;

func calculateSteeringForce(steeringObj, target):

	if(!steeringObj.behaviourParams.has('wanderAngle')):
		steeringObj.behaviourParams.wanderAngle = rand_range(0, PI * 2);

	var wanderAngle = steeringObj.behaviourParams.wanderAngle;

	if(steeringObj.velocity.length() <= 5):
		steeringObj.velocity = Vector2(randf(), randf());
	
	var circleCenter = steeringObj.velocity.normalized() * circleDistance;
	var displacement = (Vector2(0, 1) * circleRadius).rotated(wanderAngle);

	wanderAngle += rand_range(0, maxAngleChange);
	
	return circleCenter + displacement;
	
