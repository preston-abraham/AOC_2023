inp = open("inputs/day21.txt","r").read()
garden = [list(i) for i in sample_inp.split("\n")]
garden_size = (len(garden),len(garden[0]))
start_loc = (-1,-1)
for i in range(garden_size[0]):
    for j in range(garden_size[1]):
        if garden[i][j] == "S":
            start_loc = (i,j)
start_loc

def valid_point(point):
    return point[0] >= 0 and point[0] < garden_size[0] and point[1] >= 0 and point[1] < garden_size[1]

def neighbors(point,part2):
    n = []
    for d in [(-1,0),(1,0),(0,-1),(0,1)]:
        neighbor = (point[0] + d[0],point[1]+d[1])
        if (part2 or valid_point(neighbor)) and garden[neighbor[0] % garden_size[0]][neighbor[1] % garden_size[1]] != "#":
            n.append(neighbor)
    return n

def steps(start_point,num,part2):
    n = [start_point]
    for _ in range(num):
        new_n = []
        for i in n:
            for p in neighbors(i,part2):
                new_n.append(p)
        n = list(set(new_n))
    return len(n)

print("Part 1: " + str(steps(start_loc,10,False)))
print("Part 2: " + str(steps(start_loc,100,True)))
