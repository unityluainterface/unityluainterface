-- interactive console support
local append,concat = table.insert, table.concat
unity = require 'Unity'

--- any useful utility stuff goes here
-- returns the game object by name
find = unity.GameObject.Find


--- we override the global print() function
local lines = {}
local linesep = '\n' --'\002'

function print(...)
    local args,n = {...},select('#',...)
    local line = {}
    for i = 1,n do
        line[i] = tostring(args[i])
    end
    append(lines,concat(line,' '))
end

function collect_print()
    local res = concat(lines,linesep)..'\n'
    lines = {}
    return res
end

--[[
print(10,nil,'hello')
print 'dolly'
io.write(collect_print())
print(10,nil,'hello')
print 'dolly'
io.write(collect_print())
for i = 1,10 do print(i) end
io.write(collect_print())
--]]



