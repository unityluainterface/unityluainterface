## Using LuaInterface with Unity 3D

You will first need a suitable Lua shared library to build against. The LuaUnity/Lua directory has a modified makefile that will build lua51.so and luanet.so (just drop the Lua 5.1.5 sources into this directory, or move the makefile to existing source together with the .c and .h files.)

On 64-bit operating systems, bear in mind that Unity may be a 32-bit application, so that the shared library needs to be built with the equivalent of -m32.

These shared libraries need to be visible system-wide; on OS X, you can put them in /usr/lib.  On Windows, lua51.dll can go in the Windows System directory, or next to the main Unity executable.

The LuaUnity solution has two projects:
 - LuaInterface managed interface with the Lua shared libary
 - LuaUnity glue C# code between Unity and LuaInterface

(There is a configuration for Linux, where the Lua shared library is more typically called liblua5.1.so.)

After building this solution, copy the generated assemblies LuaInterface.dll and LuaUnity.dll to UnityTest/Assets. It should be now possible to build the UnityTest Unity solution.

Open UnityTest in Unity, and things should work!

## A simple Test Project

The UnityTest project has a few simple active objects; a cube, a sphere and a spotlight. Add the NewBehaviourScript .cs component to these objects, and set the 'lua' field to the corresponding Lua scripts, which sit in Assets/Resources: NewBehaviourScript.lua, Sphere.lua, and Spotlight.lua. Also attach to the standard camera in the same way the Camera.lua script.

The scripts move the cube and sphere around by translating them in their Update methods; the camera script allows the arrow keys to be used to change the viewing angle.

Clicking on the cube causes the OnMouseDown method to fire, instantiating new spheres.





