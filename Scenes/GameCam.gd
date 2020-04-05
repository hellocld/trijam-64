extends Camera

var target:Node
var offset

func _ready():
	offset = transform.origin


func _process(_delta):
	if target != null:
		transform.origin = offset + target.transform.origin
