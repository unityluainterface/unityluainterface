local unity = require 'Unity'

local Sphere = {}

local delta = unity.Time.deltaTime

function Sphere.Init(this)
    return {
        velocity = {0,0,0},
        this = this
    }
end

function Sphere:Start()
	unity.Debug.Log("sphere starting")
end

function Sphere:Update()
    local v = self.velocity
    if not v.scaled then
        v.scaled = true
        v[1],v[2],v[3] = delta*v[1],delta*v[2],delta*v[3]
    end
	self.this.transform:Translate(v[1],v[2],v[3])
end

function Sphere:OnMouseDown()
    unity.Debug.Log("sphere clicked")
end

return Sphere
