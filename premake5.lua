workspace "sx"
    architecture "x64"
    toolset "msc"

    configurations
    {
        "Debug",
        "Release"
    }

    startproject "sx"

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

include "premake_include.lua"

filter {}

local directories = {
    "./",
}

local function DeleteVSFiles(path)
    os.remove(path .. "*.sln")
    os.remove(path .. "*.vcxproj")
    os.remove(path .. "*.vcxproj.filters")
    os.remove(path .. "*.vcxproj.user")
    print("Deleting VS files for " .. path)
end

newaction
{
    trigger = "clean",
    description = "Remove all binaries, int-binaries, vs files",
    execute = function()
        os.rmdir("./bin")
        print("Successfully removed binaries")
        os.rmdir("./bin-int")
        print("Successfully removed intermediate binaries")
        os.rmdir("./.vs")

        for _, v in pairs(directories) do
            DeleteVSFiles(v)
        end

        print("Successfully removed vs project files")
        print("Done!")
    end
}
