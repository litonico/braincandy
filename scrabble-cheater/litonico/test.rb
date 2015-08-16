require 'minitest/autorun'
require './cheat_at_scrabble'

class TestTrie < Minitest::Test
  def setup
    @trie = Trie.new
  end

  def test_insertion_into_new_trie
    @trie.insert "dags"
    assert_equal @trie['d']['a']['g'], {'s' => Trie.new}
  end

  def test_insertion_into_existing_trie
    @trie.insert "dags"
    @trie.insert "dogs"
    assert_equal ({'s' => Trie.new}), @trie['d']['a']['g']
    assert_equal ({'s' => Trie.new}), @trie['d']['o']['g']
  end

  def test_checking_if_word_in_trie
    @trie.insert "dogs"
    assert_equal true,  @trie.check("dogs"), "word not found in trie"
    assert_equal false,  @trie.check("dog"), "`check` accepts partial strings"
    assert_equal false,  @trie.check("dags"), "oh, dogs. yeah, I like dogs"
    @trie.insert "dog"
    # assert_equal true,  @trie.check("dog"), "trie can't find a word's prefix"
  end
end

class TestCheating < Minitest::Test
  def test_possible_words_base_case
    trie = build_dictionary_trie ["hello", "world"]
    tiles = ""
    assert_equal [], possible_words(trie, tiles)
  end

  def test_possible_words_next_case
    trie = build_dictionary_trie ["l"]
    assert_equal trie, {"l" => {}}
    tiles = "l"
    assert_equal ["l"], possible_words(trie, tiles)
  end

  def test_possible_words_inductive_case
    trie = build_dictionary_trie ["hi", "world"]
    tiles = "hi"
    assert_equal ["hi"], possible_words(trie, tiles)
  end

  def test_longer_possible_words
    # TODO(Lito): This will work when the trie impl can deal with prefixes
    # trie = build_dictionary_trie ["hi", "hid", "hew"]
    trie = build_dictionary_trie ["hid", "hew"]
    tiles = "wedhi"
    assert_equal ["hid", "hew"].sort , possible_words(trie, tiles).sort
  end

  def test_cheating
    dict = ["hello", "world", "hew"]
    tiles = "lelhwro"
    assert_equal ["hello", "hew"], cheat_at_scrabble(dict, tiles)
  end

end
