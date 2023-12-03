input = open(io->read(io, String), "inputs/day3.txt")
lines = split.(split(input,"\n"),"")

function valid_coord(point)
    if point[1] <= 0 || point[1] > 140 || point[2] <= 0 || point[2] > 140
        return false
    end
    return true
end

function get_number(point)
    if lines[point[1]][point[2]] ∉ ["0","1","2","3","4","5","6","7","8","9"]
        return(".",[point])
    end
    points = [point]
    base = lines[point[1]][point[2]]
    x = 1
    while valid_coord((point[1],point[2]-x)) && lines[point[1]][point[2]-x] ∈ ["0","1","2","3","4","5","6","7","8","9"]
        base = lines[point[1]][point[2]-x] * base
        push!(points,(point[1],point[2]-x))
        x+= 1
    end
    x = 1
    while valid_coord((point[1],point[2]+x)) && lines[point[1]][point[2]+x] ∈ ["0","1","2","3","4","5","6","7","8","9"]
        base *= lines[point[1]][point[2]+x]
        push!(points,(point[1],point[2]+x))
        x+= 1
    end
    return (parse(Int64,base),sort(points))
    
end 


function check_surroundings(point)
    for x ∈ [-1,0,1]
        for y ∈ [-1,0,1]
            if valid_coord((point[1] + x,point[2] + y))
                if lines[point[1] + x][point[2] + y] ∉ [".","0","1","2","3","4","5","6","7","8","9"]
                    return 1
                end
            end
        end
    end
    return 0
end

function gear_ratio(point)
    neighbors = []
    for x ∈ [-1,0,1]
        for y ∈ [-1,0,1]
            if valid_coord((point[1] + x,point[2] + y))
                if lines[point[1] + x][point[2] + y] ∈ ["0","1","2","3","4","5","6","7","8","9"]
                    push!(neighbors,get_number((point[1] + x,point[2] + y)))
                end
            end
        end
    end
    neighbors = union(neighbors)
    if size(neighbors)[1] == 2
        return neighbors[1][1] * neighbors[2][1]
    end
    return 0
end



numbers = []
number_coords = []
already_checked = []
for c in all_coords
    if c ∉ already_checked
        if lines[c[1]][c[2]] ∈ ["0","1","2","3","4","5","6","7","8","9"]  
            push!(numbers,get_number(c)[1])
            push!(number_coords,get_number(c)[2])
            for p in get_number(c)[2]
                push!(already_checked,p)
            end
        end
    end
end

tot = 0
for i in range(1,size(numbers)[1])
    if sum(check_surroundings.(number_coords[i])) > 0
        tot += numbers[i]
    end
end
print(String("Part 1: $(tot)"))

gear_coords = []
for c in all_coords
    if lines[c[1]][c[2]] == "*"
        push!(gear_coords,c)
    end
end

print(String("\nPart 2: $(sum(gear_ratio.(gear_coords)))"))
