input = open(io->read(io, String), "inputs/day11.txt")
lines = split.(split(input,"\n"),"")

function empty_rows(lines)
    empty_rows = []
    for i in range(1,size(lines)[1])
        if union(lines[i]) == ["."]
            push!(empty_rows,i)
        end
    end
    return empty_rows
end

function empty_columns(lines)
    empty_columns = []
    for i in range(1,size(lines[1])[1])
        if union([l[i] for l in lines]) == ["."]
            push!(empty_columns,i)
        end
    end
    return empty_columns
end

function find_galaxies(space_grid)
    galaxies = []
    for i in range(1,size(space_grid)[1])
        for j in range(1,size(space_grid[1])[1])
            if space_grid[i][j] == "#"
                push!(galaxies,(i,j))
            end
        end
    end
    return galaxies
end

function galaxy_dist(g1,g2,expansion)
    row_dist = abs(g1[1] - g2[1])
    lower_row = min(g1[1],g2[1])
    higher_row = max(g1[1],g2[1])
    for r in empty_row_nums
        if r > lower_row && r < higher_row
            row_dist += expansion
        end
    end 
    col_dist = abs(g1[2] - g2[2])
    lower_col = min(g1[2],g2[2])
    higher_col = max(g1[2],g2[2])
    for c in empty_col_nums
        if c > lower_col && c < higher_col
            col_dist += expansion
        end
    end
    return row_dist + col_dist 
end

function galaxy_distance_sums(num_expansions)
    tot = 0
    for g1 in galaxies
        for g2 in galaxies
            tot += galaxy_dist(g1,g2,num_expansions-1)
        end
    end
    return(tot ÷ 2)
end

galaxies = find_galaxies(lines)
empty_row_nums = empty_rows(lines)
empty_col_nums = empty_columns(lines)

print(String("Part 1: $(galaxy_distance_sums(2))"))
print(String("\nPart 2: $(galaxy_distance_sums(1000000))"))
