# Day 25
input = open(io->read(io, String), "inputs/day25_22.txt")
numbers = split.(split(input,"\n"),"")
code = Dict("1" => 1,"2" => 2,"0" => 0,"-" => -1,"=" => -2)
reverse_code = Dict(1 => "1",2 => "2",0 => "0",4 => "-",3 => "=")

function to_decimal(snafu)
    total = 0
    for i in range(1,size(snafu)[1])
        total += code[(reverse(snafu))[i]] * (5^(i-1))
    end
    return(total)
end

function get_maximum_multiplier(x)
    max_mult = 1
    done = false
    while !done
        if x >= 3*max_mult || x <= -3*max_mult
            max_mult *= 5
        else
            done = true
            return max_mult
        end
    end
end

function determine_symbol(x)
    max_mult = get_maximum_multiplier(x)
    
    if x > max_mult * 1.5
        return "2"
    elseif x > max_mult * 0.5
        return "1"
    elseif x > max_mult * -.5
        return "0"
    elseif x > max_mult * -1.5
        return "-"
    else
        return "="
    end
end

function to_snafu(decimal)
    snafu_string = ""
    num = decimal
    done = false
    most_recent_mult = get_maximum_multiplier(num)
    while !done
        if get_maximum_multiplier(num) == 1
            done = true
        end
        most_recent_mult = get_maximum_multiplier(num)
        snafu_string *= determine_symbol(num)
        num -= (code[determine_symbol(num)] * get_maximum_multiplier(num))
        
        
        while (get_maximum_multiplier(num) * 5 != most_recent_mult) && most_recent_mult != 1
            snafu_string *= "0"
            most_recent_mult /= 5
        end
    end
    return(snafu_string)
end

to_snafu(sum(to_decimal.(numbers)))