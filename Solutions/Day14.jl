input = open(io->read(io, String), "inputs/day14.txt")
map = split.(split(input,"\n"),"")
split_rocks = map

function p1_split(map)
    rocks = join.(reverse.([[c[i] for c in map] for i in 1:size(map)[1]]))
    split_rocks = split.(rocks,"#")
    split_rocks = [[vcat(sort(split(i,"")),["#"]) for i in r] for r in split_rocks]
    split_rocks = [filter(e -> e != "", collect(Iterators.flatten(i))) for i in split_rocks]
    return split_rocks
end

function cycle(split_rocks)
    for n in 1:4
        rocks = join.(reverse.([[c[i] for c in split_rocks] for i in 1:size(split_rocks)[1]]))
        split_rocks = split.(rocks,"#")
        split_rocks = [[vcat(sort(split(i,"")),["#"]) for i in r] for r in split_rocks]
        split_rocks = [filter(e -> e != "", collect(Iterators.flatten(i))) for i in split_rocks]
    end
    return split_rocks
end

function score(line)
    score = 0
    for i in 1:size(line)[1] - 1
        if line[i] == "O"
            score += i
        end
    end
    return score
end

# Find a Cycle to avoid brute forcing
seen = Dict(hash(split_rocks) => 0)
loop_start = 0
loop_stop = 0
for i in 1:1000000000
    split_rocks = cycle(split_rocks)
    hashed_split_rocks = hash(split_rocks)
    if haskey(seen, hashed_split_rocks)
        loop_start = seen[hashed_split_rocks]
        loop_stop = i
        break
    else
        seen[hashed_split_rocks] = i
    end
end

# Number af cycles after start of loop % length of the loop gives how much of the loop is left after the last full loop
loop_piece_left = (1000000000 - loop_start) % (loop_stop - loop_start)  

# Just run the cycles for what is left
for _ in 1:loop_piece_left
    split_rocks = cycle(split_rocks)
end

# Another scoring function because the cycle ends by rolling east but the output wants to be scored from the north
function north_score(split_rocks)
    score = 0
    for i in 1:size(split_rocks)[1]
        for e in split_rocks[i]
            if e == "O"
                score += (size(split_rocks)[1] + 1 - i)
            end
        end
    end
    return score
end

print(String("Part 1: $(sum(score.(p1_split(map))))"))
print(String("\nPart 2: $(north_score(split_rocks))"))
