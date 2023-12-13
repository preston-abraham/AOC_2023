# My Original Attempt
input = open(io->read(io, String), "inputs/day12.txt")
lines = split(sample_input,"\n")
seqs = [split(split(i," ")[2],",") for i in lines]
springs = [split(split(i," ")[1],"") for i in lines]
function line_sequence(line)
    seq = []
    count = 0
    last_broken = false
    for i in 1:size(line)[1]
        if line[i] == "#"
            count += 1
            last_broken = true
        end
        if line[i] ∈ [".","?"]
            if last_broken
                push!(seq,string(count))
            end
            count = 0
            last_broken = false
        end
        
    end
    if last_broken
        push!(seq,string(count))
    end
    return seq
end


function line_options(line)
    unknowns = []
    options = []
    for i in 1:size(line)[1]
        if line[i] == "?"
            push!(unknowns,i)
        end
    end
    combos  = [[".","#"] for i in 1:size(unknowns)[1]]
    
    for c in vec(collect(Iterators.product(combos...)))
        push!(options,replace_questions(line,c))
    end
    return options
end

function replace_questions(line,combo)
    combo_i = 1
    new_line = copy(line)
    for i in 1:size(line)[1]
        if new_line[i] == "?"
            new_line[i] = combo[combo_i]
            combo_i += 1
        end
    end
    return(new_line)
end
        
function valid_options(line,target_seq)
    option_seqs = line_sequence.(line_options(line))
    valid_count = 0
    for os in option_seqs
        if os == target_seq
            valid_count += 1
        end
    end
    return(valid_count)
end

tot = 0
for i in 1:size(springs)[1]
    tot += valid_options(springs[i],seqs[i])
end
tot


function expand_seq(seq,use_separator,separator)
    new_seq = copy(seq)
    for i in 1:4
        if use_separator
            new_seq = vcat(new_seq,separator)
        end
        new_seq = vcat(new_seq,seq)
    end
    return new_seq
end

expanded_springs = expand_seq.(springs,true,["?"])
expanded_seqs = expand_seq.(seqs,false,[","])

tot = 0
for i in 1:size(expanded_springs)[1]
    tot += valid_options(expanded_springs[i],expanded_seqs[i])
end
tot

##############################################################################################################################################

# Day 12 Re-write
#        (Treat as completely separate code from above)
using Memoization
input = open(io->read(io, String), "inputs/day12.txt")
lines = split(input,"\n")
seqs = [split(split(i," ")[2],",") for i in lines]
springs = [split(split(i," ")[1],"") for i in lines]

function expand_seq(seq,use_separator,separator)
    new_seq = copy(seq)
    for i in 1:4
        if use_separator
            new_seq = vcat(new_seq,separator,seq)
        else
            new_seq = vcat(new_seq,seq)
        end
    end
    return new_seq
end

@memoize function recursive_solve(spring,seq,consecutive=0)
    if size(spring)[1] == 0
        if (size(seq)[1] == 0 && consecutive == 0)
            return 1
        elseif (size(seq)[1] == 1 && consecutive == parse(Int64,seq[1]))
            return 1
        else
            return 0
        end
    end

    count = 0
    condition = spring[1]
    if condition ∈ ["#","?"]
        count += recursive_solve(spring[2:end],seq,consecutive+1)
    end
    if condition ∈ [".","?"]
        if size(seq)[1] > 0 && parse(Int64,seq[1]) == consecutive
            count += recursive_solve(spring[2:end],seq[2:end])
        elseif consecutive == 0
            count += recursive_solve(spring[2:end],seq)
        end
    end
    return count
end

expanded_springs = expand_seq.(springs,true,["?"])
expanded_seqs = expand_seq.(seqs,false,[","])

print(String("Part 1: $(sum([recursive_solve(vcat(springs[i],["."]),seqs[i],0) for i in 1:size(springs)[1]]))"))
print(String("\nPart 2: $(sum([recursive_solve(vcat(expanded_springs[i],["."]),expanded_seqs[i],0) for i in 1:size(expanded_springs)[1]]))"))
