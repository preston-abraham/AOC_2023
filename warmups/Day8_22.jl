# Day 8 2022

# Read Input
input = open(io->read(io, String), "inputs/day8_22.txt")

# Build Forest From Input
forest = [parse.(Int64,r) for r in split.(split(input,"\n"),"")]
all_cords = [(x,y) for x in range(1,99) for y in range(1,99)]

# Check if Tree is Visible From Each Side
function visible((x,y))
    height = forest[x][y]
    if(x == 1 
            || x == 99 
            || y == 1 
            || y == 99)
        return 1
    end
    
    if(height > maximum([line[y] for line in forest[1:x-1]]) 
            || height > maximum([line[y] for line in forest[x+1:99]]) 
            || height > maximum(forest[x][1:y-1]) 
            || height > maximum(forest[x][y+1:99]))
        return 1
    end
    return 0
end

# Print Number of Visible Trees
print(sum.([visible.(all_cords)]))


# Function to Determine Number of Visible Trees in a Line
function num_visible_trees(trees_in_direction,height)
    if size(trees_in_direction)[1] == 0
        return 0
    end
    
    blocking_tree = findfirst(tree -> tree >= height,trees_in_direction)
    if isnothing(blocking_tree)
        return size(trees_in_direction)[1]
    end
    return blocking_tree
    
end

# Test Each Direction and Multiply the Score
function scenic_score((x,y))
    score = 1
    height = forest[x][y]
    # Left
    if x != 1
        score *= num_visible_trees(reverse([line[y] for line in forest[1:x-1]]),height) # Reverse since moving towards tree
    end
    
    # Right
    if x != 99
        score *= num_visible_trees([line[y] for line in forest[x+1:99]],height)
    end
        
    # Top
    if y != 1
        score *= num_visible_trees(reverse(forest[x][1:y-1]),height) # Reverse since moving towards tree
    end
        
    # Bottom
    if y != 99
        score *= num_visible_trees(forest[x][y+1:99],height)
    end
    
    return score
end

# Print Maximum Scenic Score
print(maximum.([scenic_score.(all_cords)]))