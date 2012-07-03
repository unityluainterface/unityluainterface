local unity = require 'Unity'

return {
    Update = function(self)
        if unity.Input.GetButtonDown 'Jump' then
            local target = unity.GameObject.Find 'Sphere'
            self.this.transform:LookAt(target.transform)
        end
    end
}
