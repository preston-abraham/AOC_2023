sample_input = """32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483"""
input = open(io->read(io, String), "inputs/day7.txt")
lines = split.(split(input,"\n")," ")
cards = [i[1] for i in lines]
bets = Dict(i[1]=>parse(Int64,i[2]) for i in lines)


card_values = Dict('A'=>14,'K'=>13,'Q'=>12,'J'=>11,'T'=>10,'9'=>9,'8'=>8,'7'=>7,'6'=>6,'5'=>5,'4'=>4,'3'=>3,'2'=>2,'J'=>0)
values = Dict("five"=>6,"four"=>5,"full"=>4,"three"=>3,"two pair"=>2,"pair"=>1,"cardhigh"=>0)

function joker_count(card)
    jokers = 0
    for c in card
        if c == 'J'
            jokers += 1
        end
    end
    return jokers
end


function card_type(card)
    card_items = split(card,"")
    number_of_jokers = joker_count(card)
    num_uniques = size(union(card_items))[1]
    
    joker_max = 1
    joker_check = Dict(i=>0 for i in union(card_items))
    for i in card_items
        if i != "J"
            joker_check[i] += 1
            if joker_check[i] > joker_max
                joker_max = joker_check[i]
            end
        end
    end
    for k in keys(joker_check)
        if joker_check[k] == joker_max
            card_items = replace(card_items,"J"=>k)
        end
    end
    
    num_uniques = size(union(card_items))[1]
    
    
    if num_uniques == 1
        return "five"
    end
    if num_uniques == 2
        max = 1 + number_of_jokers
        check = Dict(i=>0 for i in union(card_items))
        for i in card_items
            check[i] += 1
            if check[i] > max
                max = check[i]
            end
        end
        if max == 4
            return "four"
        end
        return "full"
    end
    if num_uniques == 3
        max = 1 + number_of_jokers
        check = Dict(i=>0 for i in union(card_items))
        for i in card_items
            check[i] += 1
            if check[i] > max
                max = check[i]
            end
        end
        if max == 2
            return "two pair"
        end
        return "three"
    end
    if num_uniques == 4
        return "pair"
    end
        
    if num_uniques == 5
        return "cardhigh"
    end
end

function card_is_less(card1,card2)
    card1_value = values[card_type(card1)]
    card2_value = values[card_type(card2)]
    if card1_value < card2_value
        return true
    end
    if card1_value > card2_value
        return false
    end
    
    
    for i in range(1,5)
        if card_values[card1[i]] < card_values[card2[i]]
            return true
        end
        if card_values[card1[i]] > card_values[card2[i]]
            return false
        end
    end
    return "error"
end
sorted_cards = sort(cards,lt=card_is_less)

tot = 0
for i in range(1,1000)
    tot += i * bets[sorted_cards[i]]
end
tot
