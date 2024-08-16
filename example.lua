local arg_parser = require("args")

-- Creates new instance of parser
local parser = arg_parser:new()

-- Define flags (supports variants)
parser:addFlag("--help", "-h")
parser:addFlag("--verbose", "-v")

-- Same goes with options
parser:addOption("--output", "-o")
parser:addOption("--input", "-i")

-- Parse args itself like this
parser:parse({ ... })

-- Extract flags and options
local flags = parser:getFlags()
local options = parser:getOptions()

-- You can also store other positional arguments
--local args = parser:getArgs()

if flags["--help"] then
  print("Usage: example.lua [options] [arguments]")
  print("Options:")
  print("  --help, -h       Show this message")
  print("  --verbose, -v    Enable verbose mode")
  print("  --output, -o     Specify output file")
  print("  --input, -i      Specify input file")
  return
end

-- this is how you check for flags
if flags["--verbose"] then
  print("Verbose is on!")
end

-- same with options, but they have actual value while flags just store boolean
if options["--output"] then
  print("Output will be saved to " .. options["--output"])
end

if options["--input"] then
  print("Input will be read from " .. options["--input"])
end

-- this are other arguments (not specified higher)
if #args > 0 then
  print("Positional args:")
  for _, v in ipairs(args) do
    print("  " .. arg)
  end
end
