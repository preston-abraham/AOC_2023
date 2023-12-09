input = open(io->read(io, String), "inputs/day9.txt")
lines = split(input,"\n")

function differences(numbers)
    line_size = size(numbers)[1]
    return([numbers[i+1] - numbers[i] for i in range(1,line_size-1)])
end


function sequence_stack(numbers)
    sequences = [numbers]
    difs = differences(numbers)
    while union(difs) != [0]
        push!(sequences,difs)
        difs = differences(difs)
    end
    push!(sequences,difs)
    return sequences
end

function build_from_sequence_stack(sequences,part1)
    if part1
        push!(sequences[end],0)
        seq_size = size(sequences)[1]
        for i in range(1,seq_size-1)
            push!(sequences[seq_size-i],sequences[seq_size-i][end] + sequences[seq_size-i + 1][end])
        end
        return sequences[1][end]
    else
        pushfirst!(sequences[end],0)
        seq_size = size(sequences)[1]
        for i in range(1,seq_size-1)
            pushfirst!(sequences[seq_size-i],sequences[seq_size-i][begin] - sequences[seq_size-i + 1][begin])
        end
        return sequences[1][begin]
    end
end

function score(line,part1)
    numbers = parse.(Int64,split(line," "))
    seq = sequence_stack(numbers)
    return build_from_sequence_stack(seq,part1)
end

print(String("Part 1: $(sum(score.(lines,true)))"))
print(String("\nPart 2: $(sum(score.(lines,false)))"))
