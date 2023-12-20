import re
input = open("inputs/day20.txt","r").read()
lines = input.split("\n")
flips = {i.split(" ")[0][1:]:False for i in lines if i[0] == "%"}
conjunctions = {i.split(" ")[0][1:]:{} for i in lines if i[0] == "&"}
sorted_lines = sorted(lines,reverse=True)
targets = {re.sub(r"[^a-z]","",i.split(" -> ")[0]):[j.strip() for j in i.split(" -> ")[1].split(",")] for i in lines}

for l in lines:
    if l.split(" -> ")[1] in conjunctions.keys():
        conjunctions[l.split(" -> ")[1]][l.split(" -> ")[0][1:]] = "low"

def pulse(name,freq,source):
    pulses = []
    if name == 'broadcaster':
        for s in targets[name]:
            pulses.append([s,"low"])
        return [i + [name] for i in pulses]
    if name in flips.keys():
        if freq == "low":
            if not(flips[name]):
                for s in targets[name]:
                    pulses.append([s,'high'])
            else:
                for s in targets[name]:
                    pulses.append([s,'low'])
            flips[name] = not(flips[name])
            return [i + [name] for i in pulses]
        return []
    elif name in conjunctions.keys():
        conjunctions[name][source] = freq
        if set(conjunctions[name].values()) == {'high'}:
            for s in targets[name]:
                pulses.append([s,'low'])
        else:
            for s in targets[name]:
                pulses.append([s,'high'])
        return [i + [name] for i in pulses]
        
def propogate():
    pulses = pulse('broadcaster','low','button')
    new_p = []
    output = []
    while len(pulses) > 0:
        output.append(pulses)
        new_p = []
        for p in pulses:
            new_pulse = pulse(p[0],p[1],p[2])
            if new_pulse != None:
                new_p += new_pulse
        pulses = new_p
        
    return output
  
def evaluate(prop_out):
    low = 1
    high = 0
    for line in prop_out:
        for pul in line:
            if pul[1] == "low":
                low += 1
            else:
                high += 1
    return (low,high)
lows = 0
highs = 0
for i in range(1000):

    p = evaluate(propogate())
    lows += p[0]
    highs += p[1]
    
print(lows * highs)
