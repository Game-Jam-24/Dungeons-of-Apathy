extends Node

const DEBUG = true
const CELL_SIZE = Vector2(32, 32)
# Enum to represent directions
enum Direction { UP, DOWN, LEFT, RIGHT }

var isControllerConnected: bool

var isArtifactMorphed: bool
