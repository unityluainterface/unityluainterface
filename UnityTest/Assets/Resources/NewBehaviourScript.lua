local unity = require 'Unity'
local log = unity.Debug.Log

log('Application data '..unity.Application.dataPath)

local delta = unity.Time.deltaTime
local transform

-- constructor for objects of this kind
local Init = function(this)
    transform = this.transform
    return { this = this }
end

local sphere

local Start = function(self)
	local this = self.this
    --this.transform:Rotate(0,20,0)
    sphere = unity.GameObject.Find('Sphere')
end

local Update = function (self)
    transform:Translate(0,0,0.1*delta)
end

local OnMouseDown = function(self)
    log ('Clicked')
    -- we have to refer to static methods explicitly like this
    unity.MonoBehaviour.Instantiate(sphere,transform.position,transform.rotation)
end


return {Init = Init, Start = Start, Update = Update, OnMouseDown = OnMouseDown}


