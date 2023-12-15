input = open(io->read(io, String), "inputs/day15.txt")
samples = split(input,",")

function hash_score(sample)
    score = 0
    split_sample = reduce(vcat, permutedims.(collect.(sample)))
    for c in split_sample
        score += Int(c)
        score *= 17
        score = score % 256
    end
    return score
end
print(String("Part 1: $(sum(hash_score.(samples)))"))

labels = replace.(samples,r"[^a-z]"=>"")
operations = replace.(samples,r"[a-z]"=>"")
places = hash_score.(labels)

boxes = Dict(i=>[] for i in 0:256)


for i in 1:size(labels)[1]
    label = labels[i]
    place = places[i]
    operation = operations[i]
    if operations[i] == "-"
        filter!(e->e[1] != label,boxes[place])
    else
        focal = parse(Int,replace(operation,r"[^0-9]"=>""))
        
        if label ∈ [e[1] for e in boxes[place]]
            for i in 1:size(boxes[place])[1]
                if boxes[place][i][1] == label
                    boxes[place][i] = (label,focal)
                end
            end
        else
            push!(boxes[place],(label,focal))
        end
    end
end
boxes

function score_boxes(boxes)
    score = 0
    for k in keys(boxes)
        for i in 1:size(boxes[k])[1]
            score += (k+1) * i * boxes[k][i][2]
        end
    end
    return score
end

print(String("\nPart 2: $(score_boxes(boxes))"))
