sample_input = open(io->read(io, String), "inputs/day16sample.txt")
input = open(io->read(io, String), "inputs/day16.txt")
map = split.(split(input,"\n"),"")

start = (1,1)
direction = (1,0)

visited = []

function valid_loc(location)
    return (location[1] > 0 && location[1] <= size(map)[1] && location[2] > 0 && location[2] <= size(map[1])[1])
end

function beam(start,direction)
    location = start
    direction = direction
    
    start_char = map[start[1]][start[2]]
    
    start_direction = direction
    if start_char == "/"
        if direction == (1,0)
            start_direction = (0,-1)
        elseif direction == (0,-1)
            start_direction = (1,0)
        elseif direction == (-1,0)
            start_direction = (0,1)
        elseif direction == (0,1)
            start_direction = (-1,0)
        end
    end
    if start_char == "\\"
        if direction == (1,0)
            start_direction = (0,1)
        elseif direction == (0,1)
            start_direction = (1,0)
        elseif direction == (-1,0)
            start_direction = (0,-1)
        elseif direction == (0,-1)
            start_direction = (-1,0)
        end
    end
    
    direction = start_direction
    
        
    while valid_loc(location) && (location,direction) ∉ visited
        push!(visited,(location,direction))
        next_step = (location[1] + direction[1],location[2] + direction[2])
        if !valid_loc(next_step)
            break
        end
        new_direction = direction
        next_char = map[next_step[1]][next_step[2]]
        if next_char == "/"
            if direction == (1,0)
                new_direction = (0,-1)
            elseif direction == (0,-1)
                new_direction = (1,0)
            elseif direction == (-1,0)
                new_direction = (0,1)
            elseif direction == (0,1)
                new_direction = (-1,0)
            end
        end
        if next_char == "\\"
            if direction == (1,0)
                new_direction = (0,1)
            elseif direction == (0,1)
                new_direction = (1,0)
            elseif direction == (-1,0)
                new_direction = (0,-1)
            elseif direction == (0,-1)
                new_direction = (-1,0)
            end
        end
        if next_char == "-" && direction[2] == 0
            beam(next_step,(0,1))
            beam(next_step,(0,-1))
            return
        end
        if next_char == "|" && direction[1] == 0
            beam(next_step,(1,0))
            beam(next_step,(-1,0))
            return
        end
        
        location = next_step
        direction = new_direction
    end            
end

beam((1,1),(0,1))
print(String("Part 1: $(size(union([i[1] for i in visited]))[1])"))

tops = []
for i in 1:size(map)[1]
    visited = []
    beam((1,i),(1,0))
    push!(tops,size(union([i[1] for i in visited]))[1])
end
bots = []
for i in 1:size(map)[1]
    visited = []
    beam((size(map)[1],i),(-1,0))
    push!(bots,size(union([i[1] for i in visited]))[1])
end

rights = []
for i in 1:size(map[1])[1]
    visited = []
    beam((i,size(map[1])[1]),(0,-1))
    push!(rights,size(union([i[1] for i in visited]))[1])
end

lefts = []
for i in 1:size(map[1])[1]
    visited = []
    beam((i,1),(0,1))
    push!(lefts,size(union([i[1] for i in visited]))[1])
end

print(String("\nPart 2: $(maximum([maximum(tops),maximum(bots),maximum(rights),maximum(lefts)]))"))
