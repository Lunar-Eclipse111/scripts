(function()
    if shared.assassinmtbypass then return; end;
    
    local real = getrenv().gcinfo
    
    getrenv().gcinfo = function(...)
        if not checkcaller() then return real(...); end;
        
        local call = getcallingscript();
        if call and tostring(call):find("Animator") then
            local func = ...;
            local con = debug.getconstants(func);
            if con[1] and con[1] == "" and con[2] and con[2]:find"\n" then
                return 2500;
            end
        end
        
        return real(...)
    end
end)();
