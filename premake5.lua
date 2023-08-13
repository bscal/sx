project "sx"
    kind "StaticLib"
    language "C++"
    cppdialect "C++11"
    staticruntime "on"
    
    targetdir("%{wks.location}/bin/" .. outputdir .. "/%{prj.name}")
    objdir("%{wks.location}/bin-int/" .. outputdir .. "/%{prj.name}")

    local SrcDir = "src/"
    local IncludeDir = "include/"

    files
    {
        SrcDir .. "*.c",
        IncludeDir .. "sx/*.h"
    }

    removefiles { "gfx.c", "app.c" }

    includedirs
    {
        IncludeDir
    }

    defines
    {
        "_ITERATOR_DEBUG_LEVEL=0",
        "_HAS_EXCEPTIONS=0",
        "_CRT_SECURE_NO_WARNINGS=0"
        "_WINSOCK_DEPRECATED_NO_WARNINGS",
    }

    filter "toolset:clang"
        buildoptions { "-std=C++11", "-fno-rtti", "-fno-exceptions" }

    filter "toolset:msc"
        buildoptions { "/EHsc", "/GR", "/GR-" }

    filter "system:windows"
        defines{ "_WIN32", "PLATFORM_DESKTOP"}
        links { "winmm", "kernel32", "opengl32", "gdi32", "user32" }

    filter "system:linux"
        defines { "PLATFORM_DESKTOP" }
        links { "pthread", "GL", "m", "dl", "rt", "X11" }

    filter {"system:macosx"}
        disablewarnings {"deprecated-declarations"}

    filter "configurations:Debug"
        defines { "DEBUG" }
        symbols "On"
        runtime "Debug"

    filter "configurations:Release"
        defines { "NDEBUG" }
        optimize "On"
        runtime "Release"

    filter { "platforms:x64" }
        architecture "x86_64"

    filter {}
