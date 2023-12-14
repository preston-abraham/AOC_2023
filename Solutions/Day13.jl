input = open(io->read(io, String), "inputs/day13.txt")
samples = split.(split(input,"\n\n"),"\n")
samples[1]

function find_mirror(s,already_split = false)
    if !already_split
        sample = split.(s,"")
    else
        sample = s
    end
    height = size(sample)[1]
    width = size(sample[1])[1]
    
    cols = [[c[i] for c in sample] for i in 1:width]
    candidate_rows = []
    candidate_cols = []
    for i in 1:height-1
        if sample[i] == sample[i+1]
            push!(candidate_rows,(i,i+1))
        end
    end
    for i in 1:width-1
        if cols[i] == cols[i+1]
            push!(candidate_cols,(i,i+1))
        end
    end
    
    
    
    solutions = []
    for row in candidate_rows
        valid = true
        low = row[1] - 1
        high = row[2] + 1
        while low > 0 && high < height + 1
            if sample[low] != sample[high]
                valid = false
                break
            end
            low -= 1
            high += 1
        end
        if valid
            push!(solutions,("row",row[1],row[2]))
        end
    end
    for col in candidate_cols
        valid = true
        low = col[1] - 1
        high = col[2] + 1
        while low > 0 && (high < (width + 1))
            if cols[low] != cols[high]
                valid = false
                break
            end
            low -= 1
            high += 1
        end
        if valid
            push!(solutions,("col",col[1],col[2]))
        end
    end
    return solutions
end

function swap(c)
    if c == "#"
        return "."
    elseif c == "."
        return "#"
    else
        return c
    end
end

function locate_smudge(s)
    sample = split.(s,"")
    height = size(sample)[1]
    width = size(sample[1])[1]
    
    for i in 1:height
        for j in 1:width
            old_solution = find_mirror(sample,true)
            sample[i][j] = swap(sample[i][j])
            new_solution = find_mirror(sample,true)
            if size(new_solution)[1] > 0 && old_solution != new_solution
                return (i,j,old_solution)
                break
            end
            sample[i][j] = swap(sample[i][j])
        end
    end
end

function smudge_solutions(s)
    sample = split.(s,"")
    smudge = locate_smudge(s)
    sample[smudge[1]][smudge[2]] = swap(sample[smudge[1]][smudge[2]])
    new_solution = []
    for solution in find_mirror(sample,true)
        if solution != smudge[3][1]
            push!(new_solution,solution)
        end
    end
    return(new_solution)
end
    

function summarize_notes(solution)
    solution = solution[1]
    if solution[1] == "row"
        return 100 * (solution[2])
    else
        return (solution[2])
    end
end
print(String("Part 1: $(sum(summarize_notes.(find_mirror.(samples))))"))
print(String("\nPart 2: $(sum(summarize_notes.(smudge_solutions.(samples))))"))
