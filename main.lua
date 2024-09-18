-- VERSION 1.31

local nouns = {
    ["proper"] = {"john", "johnson", "jim", "mike", "noah", "isaac", "billy", "bob", "james"}, -- names, countries, etc. phrases with proper nouns dont start with an article
    ["common"] = {"cat", "dog", "sun", "steel", "orange", "money", "cheese", "food", "moon", "rock", "house", "car", "train", "burger", "teapot", "beef", "pot"} -- basically any object. phrases with common nouns will start in an article
}
local modifiers = {
    ["adjectives"] = {"orange", "red", "yellow", "blue", "green", "epic", "hillarious", "funny", "stupid", "happy", "great", "silly", "curious", "unfathomable", "cool"},
    ["adverbs"] = {"randomly", "politely", "greatly", "rapidly", "accidentaly"}
}
local verbs = {
    ["normal"] = {"runs", "eats", "melts", "plays", "jumps", "complains"},
    ["linking"] = {"is", "felt", "seemed", "seems", "looked"}, -- linking/copular verbs
    ["modal"] = {"can", "may", "should", "must", "would", "will"}
}
local prep = {"with", "above", "under", "near", "around"} -- prepositions
local conjuctions = {"or", "and", "for"}
local articles = {"the", "that", "this", "my", "their"} -- placed before a common noun

local endings = {"!", "?", "!?"} -- symbols that may be put at the end of the sentence

local maxAdjectives = 1 -- how many adjectives to use
local sentenceAmount = 1 -- how many sentences to print
local addDot = true -- add dot to end of sentence if an ending hasnt been chosen
local addEndings = true

-- function to make life easier
function randitem(arr)
    return arr[math.random(#arr)]
end

function nounPhrase()
    local phrase = ""
    local pickCommon = false

    if math.random(0, 1) == 1 then
        phrase = randitem(articles).." "
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

    if link == 1 then
        if modal == 1 then
            phrase = randitem(verbs["linking"]).." "..randitem(modifiers["adjectives"])..", "
        else
            phrase = randitem(verbs["linking"]).." "..randitem(modifiers["adjectives"])
        end
    end
    if modal == 1 then
        phrase = phrase..randitem(verbs["modal"]).." "..string.sub(randitem(verbs["normal"]), 1, -2) -- i probably have to change this line if i want to make a good sentence generator, it just takes off the "s" from the normal verbs
        if math.random(0, 1) == 1 then
            phrase = phrase.." "..randitem(modifiers["adverbs"])
        end
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
    local ending = math.random(1, 6)
    sentence = nounPhrase().." "..verbPhrase()

    if ending == 1 and addEndings == true then
        sentence = sentence..randitem(endings)
    elseif ending ~= 1 and addDot == true then
        sentence = sentence.."."
    end

    return sentence
end

for i = 1, sentenceAmount do
    print(makeSentence()) -- print the sentence
end
