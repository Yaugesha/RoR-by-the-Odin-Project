# Task:
# Implement a method #substrings that takes a word as the first argument and then an array of valid substrings
# (your dictionary) as the second argument. It should return a hash listing each substring (case insensitive)
# that was found in the original string and how many times it was found.

def substrings string, dictionary
  words_in_string = string.downcase.split(" ")
  result = Hash.new(0)
  words_in_string.each do |word_in_string|
    dictionary.each { |word_in_dictionary| result[word_in_dictionary] += 1 if word_in_string.match?(word_in_dictionary) }
  end
  puts result
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

substrings("Howdy partner, sit down! How's it going?", dictionary)
