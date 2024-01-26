extends Node

const DEBUG: bool = true
const CELL_SIZE: int = 32
# Enum to represent directions
enum Direction { UP, DOWN, LEFT, RIGHT }

var isControllerConnected: bool

var isArtifactMorphed: bool
var artifactStaminaRunout: bool

var cellsHit = Vector2i(0,0)
var cellsNotHit: bool
