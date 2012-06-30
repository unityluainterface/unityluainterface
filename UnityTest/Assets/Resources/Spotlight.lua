local unity = require 'Unity'

return {
    Update = function(self)
        if unity.Input.GetButtonDown 'Jump' then
            local target = unity.GameObject.Find 'Cube'
            self.this.transform:LookAt(target.transform)
        end
    end
}
