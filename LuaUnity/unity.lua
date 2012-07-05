-- Simple remote console for Unity Lua
-- Based on LuaSocket example talker.lua by Diego Nehab
local socket = require("socket")
local host = "localhost"
local port = 2020
print("Connecting to host '" ..host.. "' and port " ..port.. "...")
local c,e = socket.connect(host, port)
if not c then return print(e) end
io.write 'Unity Lua\n'
io.write '> '
local l = io.read()
while l do
	local expr = l:match '^%s*= (.+)'
	if expr then
	   l = 'print('..expr..')'
    end
	assert(c:send(l .. "\n"))
    if l == 'quit' then break end
	local line = c:receive()
    if line == nil then break end
    -- this is how the server encodes multiple lines..
    line = line:gsub('\002','\n')
	print(line)
    io.write '> '
	l = io.read()
end
c:send 'quit\n'
c:close()
