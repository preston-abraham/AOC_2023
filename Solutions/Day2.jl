input = open(io->read(io, String), "inputs/day2.txt")
lines = split(input,"\n")
games = [i[2] for i in split.(lines,": ")]
games = split.(replace.(games,";"=>","),",")
function valid(game)
    blue_max = 0
    red_max = 0
    green_max = 0
    for pull in game
        num = parse(Int64,replace(pull,r"[^0-9]"=>""))
        color = replace(pull,r"[^a-z]"=>"")
        if color == "blue"
            if num > blue_max
                blue_max = num
            end
        end
        if color == "green"
            if num > green_max
                green_max = num
            end
        end
        if color == "red"
            if num > red_max
                red_max = num
            end
        end
    end
    if red_max > 12 || blue_max > 14 || green_max > 13
        return false
    end
    return true
end

tot = 0
for i in range(1,100)
    if valid.(games)[i]
        tot += i
    end
end
tot

function power(game)
    blue_min = 0
    red_min = 0
    green_min = 0
    for pull in game
        num = parse(Int64,replace(pull,r"[^0-9]"=>""))
        color = replace(pull,r"[^a-z]"=>"")
        if color == "blue"
            if num > blue_min
                blue_min = num
            end
        end
        if color == "green"
            if num > green_min
                green_min = num
            end
        end
        if color == "red"
            if num > red_min
                red_min = num
            end
        end
    end
    return red_min * blue_min * green_min
end
sum(power.(games))
