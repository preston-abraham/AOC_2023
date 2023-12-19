import re
from copy import deepcopy

input = open("inputs/day19.txt","r").read()
input_parts = input.split("\n\n")
wfs = input_parts[0].split("\n")
items = input_parts[1].split("\n")
items = [j.split(",") for j in [re.sub(r"[^0-9,]","",i) for i in items]]
items = [[int(i) for i in j] for j in items]
wfs = [(i.replace("}","")).split("{") for i in wfs]
wfs = {i[0]:i[1].split(",") for i in wfs}

def evaluate_part(part):
    current = "in"
    while True:
        steps = wfs[current]
        for step in steps:
            if ":" in step:
                conditional = step.split(":")[0]
                target = step.split(":")[1]
                val = re.sub(r"[^a-z]","",conditional)
                if val == "x":
                    val = part[0]
                elif val == "m":
                    val = part[1]
                elif val == "a":
                    val = part[2]
                elif val == "s":
                    val = part[3]
                
                conditional_statement = str(val) + conditional[1:]
                if eval(conditional_statement):
                    if target == "A":
                        return True
                    elif target == "R":
                        return False
                    else:
                        current = target
                        break
            elif step == "R":
                return False
            elif step == "A":
                return True
            else:
                current = step
                continue

def score_items(score_map):
    score = 0
    for i in range(len(items)):
        if score_map[i] == 1:
            score+= sum([int(j) for j in items[i]])
    return score

print("Part 1: " + str(score_items([evaluate_part(p) for p in items])))


def range_size(ranges):
    size = 1
    for i in ranges.values():
        size*= i[1]-i[0]+1
    return size

def combos(ranges,wf):
    num = 0
    for i in wfs[wf]:
        if ":" in i:
            conditional,target = i.split(":")
            if ">" in conditional:
                a,b = conditional.split(">")
                new_ranges = deepcopy(ranges)
                if new_ranges[a][1] > int(b):
                    new_ranges[a][0] = max(new_ranges[a][0],int(b)+1)
                    if target == "A":
                        num += range_size(new_ranges)
                    elif target != "R":
                        num += combos(new_ranges,target)
                    ranges[a][1] = min(ranges[a][1],int(b))
            if "<" in conditional:
                a,b = conditional.split("<")
                new_ranges = deepcopy(ranges)
                if new_ranges[a][0] < int(b):
                    new_ranges[a][1] = min(new_ranges[a][1],int(b)-1)
                    if target == "A":
                        num += range_size(new_ranges)
                    elif target != "R":
                        num += combos(new_ranges,target)
                    ranges[a][0] = max(ranges[a][0],int(b))
        else:
            if i == "A":
                num += range_size(ranges)
            elif i != "R":
                num += combos(ranges,i)
    return num

print("Part 2: " + str(combos({"x":[1,4000],"m":[1,4000],"a":[1,4000],"s":[1,4000]},"in")))
