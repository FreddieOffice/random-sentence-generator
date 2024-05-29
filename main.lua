-- VERSION 1.0

local nouns = {
    ["proper"] = {"john", "johnson", "jim", "mike", "noah", "isaac"}, -- names, countries, etc
    ["common"] = {"cat", "dog", "sun", "steel", "orange", "money", "cheese", "food"}
}
local modifiers = {
    ["adjectives"] = {"orange", "red", "yellow", "blue", "green", "epic", "hillarious", "funny", "stupid", "happy", "great"},
    ["adverbs"] = {"randomly", "politely", "greatly", "rapidly", "accidentaly"}
}
local verbs = {
    ["normal"] = {"runs", "eats", "melts", "plays", "jumps", "complains"},
    ["linking"] = {"is", "felt", "seemed", "seems", "looked"}, -- linking/copular verbs
    ["modal"] = {"can", "may", "should", "must", "would", "will"}
}
local prep = {"with", "above", "under", "near", "around"} -- prepositions
local conjuctions = {"or", "and", "for"}

local thingamabobs = {".", "!", "-"} -- characters to put at the end of the sentence

local maxAdjectives = 1 -- how many adjectives to use
local sentenceAmount = 1 -- how many sentences to print

-- function to make life easier
function randitem(arr)
    return arr[math.random(#arr)]
end

function nounPhrase()
    local phrase = ""
    local pickCommon = false

    if math.random(0, 1) == 1 then
        phrase = "the "
        pickCommon = true
    end

    if pickCommon == false then
        phrase = phrase..randitem(nouns["proper"])
    else
        if math.random(0, 1) == 1 then
            for i = 1, maxAdjectives do
                phrase = phrase..randitem(modifiers["adjectives"]).." "
            end
        end
        phrase = phrase..randitem(nouns["common"])
    end

    return phrase
end

function prepPhrase()
    local phrase = ""

    if math.random(0, 1) == 1 then
        phrase = randitem(prep).." "..nounPhrase().." "..randitem(conjuctions).." "..nounPhrase()
    else
        phrase = randitem(prep).." "..nounPhrase()
    end

    return phrase
end

function verbPhrase()
    local phrase = ""
    local rn = math.random(0, 1)
    local link = math.random(1, 4) -- linking verb chance
    local modal = math.random(1, 4) -- modal verb chance

    if not link == 1 or not modal == 1 then
        if math.random(0, 1) == 1 then
            phrase = randitem(modifiers["adverbs"]).." "
        end
    end

    if link == 1 then
        if modal == 1 then
            phrase = randitem(verbs["linking"]).." "..randitem(modifiers["adjectives"])..", "
        else
            phrase = randitem(verbs["linking"]).." "..randitem(modifiers["adjectives"])
        end
    end
    if modal == 1 then
        phrase = phrase..randitem(verbs["modal"]).." "..string.sub(randitem(verbs["normal"]), 1, -2) -- i probably have to change this line if i want to make a good sentence generator, it just takes off the "s" from the normal verbs
    end

    if rn == 1 then
        if link == 1 or modal == 1 then
            phrase = phrase.." "..prepPhrase()
        else
            phrase = phrase..randitem(verbs["normal"]).." "..prepPhrase()
        end
    else
        if link == 1 or modal == 1 then
        else
            phrase = phrase..randitem(verbs["normal"])
        end
    end

    return phrase
end

function makeSentence()
    local sentence = ""
    sentence = nounPhrase().." "..verbPhrase()

    if math.random(1, 6) == 1 then
        sentence = sentence..randitem(thingamabobs)
    end

    return sentence
end

for i = 1, sentenceAmount do
    print(makeSentence()) -- print the sentence
end
