local function debounce(func, wait)
    local timer = vim.loop.new_timer()
    return function(...)
        local args = { ... }
        timer:start(wait, 0, function()
            timer:stop()
            vim.schedule(function()
                func(unpack(args))
            end)
        end)
    end
end

return {
    debounce = debounce,
}
