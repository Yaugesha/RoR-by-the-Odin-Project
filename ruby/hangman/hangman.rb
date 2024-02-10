STAGES = [
  '
    +---+
    |   |
        |
        |
        |
        |
  =========',

  '
    +---+
    |   |
    O   |
        |
        |
        |
  =========',

  '
    +---+
    |   |
    O   |
    |   |
        |
        |
  =========',

  '
    +---+
    |   |
    O   |
   /|   |
        |
        |
  =========',

  '
    +---+
    |   |
    O   |
   /|\  |
        |
        |
  =========',

  '
    +---+
    |   |
    O   |
   /|\  |
   /    |
        |
  =========',

  '
    +---+
    |   |
    O   |
   /|\  |
   / \  |
        |
  =========']

puts "Choose min length of word: "
min_length = gets.chop.to_i
puts "Choose max length of word: "
max_length = gets.chop.to_i

word = File.readlines('google-10000-english-no-swears.txt').select{ |word| word.length.between?(min_length, max_length) }.shuffle[0].chomp

guess = []

fails = 0

while fails <= 5
  puts STAGES[fails]
  print "word: "
  word.split("").each { |char| print guess.any?(char) ? char : "_"}
  print "\n"
  print "guess letter: "
  letter = gets.chop
  if word.match?(letter)
    guess << letter
    word.split("").count { |char| guess.any? {|letter| letter == char}} == word.length ? return : next
  else
    fails += 1
    puts STAGES[fails]
  end
end

puts fails == 6 ? "You loose, word: #{word}" : "You win, word: #{word}"
