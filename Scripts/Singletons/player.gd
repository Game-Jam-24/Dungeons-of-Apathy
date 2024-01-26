extends Node

var speed = 150
var movementAcceleration = 13
var gridSpeed = 32
var isInDash: bool
var isSprinting: bool = false
var maxHealth: int = 100
var health: int = maxHealth
var maxStamina: int = 400
var stamina: int = maxStamina

var collectableCounter: int = 0
