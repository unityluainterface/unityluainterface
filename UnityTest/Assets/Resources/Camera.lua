local unity = require 'Unity'
local delta = unity.Time.deltaTime
local Input = unity.Input

local Update = function(self)
    local x = Input.GetAxis('Horizontal') * delta
    local y = Input.GetAxis('Vertical') * delta
    self.this.transform:Translate(x,y,0)
end

return { Update = Update }
