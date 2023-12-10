input = open(io->read(io, String), "inputs/day10.txt")
lines = split.(split(input,"\n"),"")


function find_start_point(lines)
    for i in range(1,size(lines)[1])
        for j in range(1,size(lines[1])[1])
            if lines[i][j] == "S"
                return((i,j))
            end
        end
    end
end

function valid_continuations(point)
    valid = []
    if point[2] < size(lines[1])[1] && lines[point[1]][point[2]+1] ∈ ["-","J","7","S"] && lines[point[1]][point[2]] ∈ ["S","-","L","F"]
        push!(valid,(point[1],point[2]+1))
    end
    if point[2] > 1 && lines[point[1]][point[2]-1] ∈ ["-","F","L","S"] && lines[point[1]][point[2]] ∈ ["S","-","7","J"]
        push!(valid,(point[1],point[2]-1))
    end
    if point[1] > 1 && lines[point[1]-1][point[2]] ∈ ["|","F","7","S"]  && lines[point[1]][point[2]] ∈ ["S","|","J","L"]
        push!(valid,(point[1]-1,point[2]))
    end
    if point[1] < size(lines[1])[1] && lines[point[1]+1][point[2]] ∈ ["|","J","L","S"] && lines[point[1]][point[2]] ∈ ["S","|","F","7"]
        push!(valid,(point[1]+1,point[2]))
    end
    return valid
end

function start_char(start_point)
    options = Dict((start_point[1],start_point[2]+1)=>["-","L","F"],
                   (start_point[1],start_point[2]-1)=>["-","7","J"],
                    (start_point[1]+1,start_point[2])=>["|","F","7"],
                    (start_point[1]-1,start_point[2])=>["|","J","L"])
    vc = valid_continuations(start_point)
    return(intersect(options[vc[1]],options[vc[2]])[1])
end

function define_loop(point)
    loop = [point]
    done = false
    current = point
    while !done
        done = true
        vc = valid_continuations(current)
        for p in vc
            if p ∉ loop
                done = false
                current = p
                push!(loop,p)
                continue
            end
        end
    end
    return loop
end

start_point = find_start_point(lines)
lines[start_point[1]][start_point[2]] = start_char(start_point)
loop = define_loop(start_point)

print(String("\nPart 1: $(size(loop)[1] ÷ 2 + (size(loop)[1] % 2))"))

in_loop = false
in_loop_points = []
for i in range(1,size(lines)[1])
    for j in range(1,size(lines[1])[1])
        if in_loop && (i,j) ∉ loop
            push!(in_loop_points,(i,j))
        end
        if (i,j) ∈ loop && lines[i][j] ∈ ["|","J","L"]
            if in_loop
                in_loop = false
            else
                in_loop = true
            end
        end
    end
end
print(String("\nPart 2: $(size(in_loop_points)[1])"))
