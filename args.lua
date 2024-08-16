local parser = {}

function parser:new()
    local obj = {
        flags = {},
        options = {},
        parsed = {flags = {}, options = {}, args = {}}
    }
    self.__index = self
    return setmetatable(obj, self)
end

function parser:addFlag(...)
    local variants = {...}
    for _, variant in ipairs(variants) do
        self.flags[variant] = false
    end
end

function parser:addOption(...)
    local variants = {...}
    for _, variant in ipairs(variants) do
        self.options[variant] = nil
    end
end

function parser:parse(args)
    local i = 1
    while i <= #args do
        local arg = args[i]
        if self.flags[arg] ~= nil then
            self.parsed.flags[arg] = true
        elseif self.options[arg] ~= nil then
            if i + 1 <= #args then
                self.parsed.options[arg] = args[i + 1]
                i = i + 1
            else
                error("Option " .. arg .. " expects a value")
            end
        else
            table.insert(self.parsed.args, arg)
        end
        i = i + 1
    end
end

function parser:getFlags()
    local result = {}
    for variant, value in pairs(self.parsed.flags) do
        if value then
            for canonical, _ in pairs(self.flags) do
                if self.flags[canonical] == false then
                    result[canonical] = true
                end
            end
            result[variant] = true
        end
    end
    return result
end

function parser:getOptions()
    local result = {}
    for variant, value in pairs(self.parsed.options) do
        for canonical, _ in pairs(self.options) do
            if self.options[canonical] == nil then
                result[canonical] = value
            end
        end
        result[variant] = value
    end
    return result
end

function parser:getArgs()
    return self.parsed.args
end

return parser
