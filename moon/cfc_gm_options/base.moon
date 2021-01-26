export CFCOptions

class CFCOption
    new: (@name, @parent) =>
        @displayName = @name
        @helpText = ""
        @isEphemeral = false
        timer.Simple 0, -> @setup!

    makeDefault: () => error "Not implemented"
    validate: (val) => error "Not implemented"

    displayName: (name) =>
        error "Expected string got #{type(name)}" unless isstring name
        @displayName = name
        return self

    help: (text) =>
        error "Expected string got #{type(text)}" unless isstring text
        @helpText = text
        return self

    ephemeral: () =>
        @isEphemeral = true
        return self

    default: (val) =>
        valid, reason = @validate val
        error "Invalid default value: #{reason}" unless valid
        @default = val
        return self

    setup: () =>
        @default or= @makeDefault!

    get: () =>
        print "got value"
        10

class CFCOptionString extends CFCOption
    validate: (val) => if isstring val then true else false, "Value not a string"
    makeDefault: () => ""

class CFCOptions
    @String = CFCOptionString

    new: (@id) =>
        @options = {}
        options = @options
        mt = getmetatable @
        mt.__index = (_, k) ->
            options[k]\get! if options[k] else CFCOptions.__base[k]

    add: (name, constructor) =>
        error "Option with name #{name} already exists" if @options[name]
        @options[name] = constructor name self
        return @options[name]
