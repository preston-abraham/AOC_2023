input = open(io->read(io, String), "inputs/day8.txt")
parts = split(input,"\n\n")
lines = split.(split(parts[2],"\n")," = ")
seq = split(parts[1],"")
paths = Dict(i[1]=>split(replace(i[2],r"[^,0-9A-Z]"=>""),",") for i in lines)

function steps_to_goal(current,dests)
    step_num = 1
    while current ∉ dests
        dir = seq[((step_num -1) % 277) + 1]
        if dir == "R"
            step_num += 1
            current = paths[current][2]
        else
            step_num += 1
            current = paths[current][1]
        end
    end
    return(step_num - 1)
end
print(String("Part 1: $(steps_to_goal("AAA",["ZZZ"]))"))

starts = join.(filter(e->e[3] == "A",split.(keys(paths),"")))
goals = join.(filter(e->e[3] == "Z",split.(keys(paths),"")))
cycles = [steps_to_goal(s, goals) for s in starts]
print(String("\nPart 2: $(lcm(cycles))"))
