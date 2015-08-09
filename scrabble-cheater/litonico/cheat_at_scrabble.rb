class Trie < Hash
  def initialize
    super
  end

  def insert s
    s.each_char.reduce self do |trie_so_far, char|
      trie_so_far[char] ||= Trie.new
      # TODO(Lito): This works, but I don't understand the return value here.
      # Need to ask Aja about this.
    end
  end

  # TODO(Lito): Also need to ask Aja about whether a trie *should* have a
  # way to check prefixes- e.g. 'dog' accepted if 'dogs' is in the trie
  def check s
    begin

    fin = s.each_char.reduce self do |node, char|
      node = node[char]
    end
    return fin == {}

    rescue NoMethodError
      false
    end
  end

end


ScrabbleError = StandardError.new(
  "I dunno what game you're playing, but it's not Scrabble"
)

def build_dictionary_trie dictionary
  trie = Trie.new
  dictionary.each do |word|
    trie.insert word
  end
  trie
end

def check_valid tiles
  unless tiles.length == 7 &&
         tiles =~ /[a-z]/
    raise ScrabbleError
  end
end

def possible_words trie, tiles
  possibles = (0..tiles.length).flat_map do |size|
    tiles.each_char.to_a.permutation(size).map(&:join)
  end
  words = possibles.select do |p|
    trie.check p
  end
  words.uniq
end

def cheat_at_scrabble dictionary, tiles
  check_valid tiles
  trie = build_dictionary_trie dictionary
  words = possible_words trie, tiles
  words.sort_by { |word| word.length }.reverse
end

words = File.readlines("/usr/share/dict/words").map(&:chomp).map(&:downcase)
puts "What tiles do you have?"
tiles = gets.chomp
puts cheat_at_scrabble words, tiles
