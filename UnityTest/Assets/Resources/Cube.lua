local unity = require 'Unity'

return {
    OnMouseDown = function()
        unity.Debug.Log ('Clicked')
    end
}
