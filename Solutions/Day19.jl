input = open(io->read(io, String), "inputs/day19.txt")
input_parts = split(sample_input,"\n\n")
wfs = split(input_parts[1],"\n")
items = split(input_parts[2],"\n")
items = split.(replace.(items,r"[^0-9,]"=>""),",")
#items = [[parse(Int,i) for i in j] for j in items]
wfs = split.(replace.(wfs,"}"=>""),"{")
wfs = Dict(i[1]=>split(i[2],",") for i in wfs)

function evaluate_part(part)
    current = "in"
    while true
        steps = wfs[current]
        for step in steps
            if ":" in split(step,"")
                conditional = split(step,":")[1]
                target = split(step,":")[2]
                val = replace(conditional,r"[^a-z]"=>"")
                if val == "x"
                    val = part[1]
                elseif val == "m"
                    val = part[2]
                elseif val == "a"
                    val = part[3]
                elseif val == "s"
                    val = part[4]
                end
                
                conditional_statement = val * conditional[2:end]
                if eval(Meta.parse(conditional_statement))
                    if target == "A"
                        return true
                    elseif target == "R"
                        return false
                    else
                        current = target
                        break
                    end
                end
            elseif step == "R"
                return false
            elseif step == "A"
                return true
            else
                current = step
                continue
            end
        end
    end
end

function score_items(score_map)
    score = 0
    for i in 1:size(items)[1]
        if score_map[i] == 1
            score+= sum(parse.(Int,items[i]))
        end
    end
    return score
end

score_items(evaluate_part.(items))
