local unity = require 'Unity'

local Sphere = {}

local delta = unity.Time.deltaTime

function Sphere:Start()
	unity.Debug.Log("sphere starting")
end

function Sphere:Update()
	self.this.transform:Translate(0,0.01*delta,0)
end

return Sphere
