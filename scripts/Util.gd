extends Node

func closestNode(nodes: Array, position: Vector2):

	if(nodes.size() <= 0): return null;

	var closest;
	var closestDstSq;

	for node in nodes:
		var dstSq = position.distance_squared_to(node.position);
		if(!closest || dstSq < closestDstSq):
			closest = node;
			closestDstSq = dstSq;

	return closest;

