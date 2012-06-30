## Using LuaInterface with Unity 3D

You will first need a suitable Lua shared library to build against. The LuaUnity/Lua directory has a modified makefile that will build liblua5.1.so and luanet.so (just drop the Lua 5.1.5 sources into this directory, or move the makefile to existing source together with the .c and .h files.)

These shared libraries need to be visible system-wide; on OS X, you can put them in /usr/lib.  On Windows, lua51.dll can go in the Windows System directory, or next to the main Unity executable.

The LuaUnity solution has two projects:
 - LuaInterface managed interface with the Lua shared libary
 - LuaUnity glue C# code between Unity and LuaInterface

If using Windows, first select the 'Windows' configuration so that the native interface looks for lua51.dll, not liblua5.1.so.

After building this solution, copy the generated assemblies LuaInterface.dll and LuaUnity.dll to UnityTest/Assets. It should be now possible to build the UnityTest Unity solution.

Open UnityTest in Unity, and things should work!

