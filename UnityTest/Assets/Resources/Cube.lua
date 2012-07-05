local unity = require 'Unity'

local function Update(self)

end

local function OnMouseDown(self)
    unity.Debug.Log ('Clicked')
end

local Init = function(this)
    return {
        Update = Update;
        OnMouseDown = OnMouseDown;
        obj_ = this
    }
end

return {
    Init = Init
}
