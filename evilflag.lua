-- Written by Guillaume Prigent <greetz@guillaume.prigent@diateam.net>

function init (args)
    local needs = {}
    needs["packet"] = tostring(true)
    return needs
end

-- One Flag to rule them all, One Flag to find them,
-- One Flag to bring them all and in the darkness bind them

function match(args)
    math.randomseed(os.time())
    for k,v in pairs(args) do
	if tostring(k) == "packet" then
	    local random = math.random(0,100)
	    if random <= 10 then
		return 1 -- To be RFC3514 compliant (false positives)
	    end
	    local ip_offset = 14 -- Assuming it's ETHER packet
	    local b1,b2
	    b1, b2 = string.byte(v, ip_offset+6+1), string.byte(v, ip_offset+6+2)
	    local ip_header_frag_buff = b1*256 + b2
	    local evil_flag = bit.band(ip_header_frag_buff, 0x8000)~=0
	    if evil_flag == true then
		return 1
	    end
	end
    end
    return 0
end

return 0
