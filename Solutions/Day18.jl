input = open(io->read(io, String), "inputs/day18.txt")
steps = split.(split(input,"\n")," ")

current = (1,1)
walls = []
perim = 0
for s in steps
    dir = (0,1)
    if s[1] == "D"
        dir = (1,0)
    elseif s[1] == "U"
        dir = (-1,0)
    elseif s[1] == "L"
        dir = (0,-1)
    end
    dist = parse(Int,s[2])
    new_point = (current[1] + dir[1] * dist,current[2]+dir[2] * dist)
    perim += dist
    push!(walls,new_point)
    current = new_point
end
function shoelace(walls)
    wall_size = size(walls)[1]
    ret = 0
  
    for i in 1:wall_size-1
        ret += walls[i][1] *  walls[i+1][2] - (walls[i][2] *  walls[i+1][1])
    end
    
    ret += walls[end][1]*walls[1][2] - walls[1][1]*walls[end][2]  
    
    return ((abs(ret) + perim) / 2)  + 1
end
print(String("Part 1: $(shoelace(reverse(walls)))"))

current = (1,1)
walls = []
perim = 0
for s in steps
    dir = (0,1)
    hex_code = replace(s[3],r"[^a-z0-9]"=>"")
    dir_code = split(hex_code,"")[end]
    steps_code = join(split(hex_code,"")[1:end-1])
    dist = parse(Int,replace(steps_code,r"[^a-z0-9]"=>""),base=16)
    if dir_code == "1"
        dir = (1,0)
    elseif dir_code == "3"
        dir = (-1,0)
    elseif dir_code == "2"
        dir = (0,-1)
    end
    new_point = (current[1] + dir[1] * dist,current[2]+dir[2] * dist)
    perim += dist
    push!(walls,new_point)
    current = new_point
end
print(String("\nPart 2: $(shoelace(walls))"))
