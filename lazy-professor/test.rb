require 'minitest/autorun'
require './lazyprof'

class TestProfessorLaziness < Minitest::Test
  def test_reading_scores
    assert_equal "CDCAC".split(""), read_scores('./test.txt')[0][0...5]
  end

  def test_transposing_rows_to_columns
    assert_equal [["a", "c"], ["b", "d"]], transpose([["a", "b"], ["c", "d"]])
  end

  def test_find_most_frequent_letter
    assert_equal "A", most_frequent_letter("BBEEAAAAACD")
    assert_equal "D", most_frequent_letter("DEEDADAACDE")
  end

  def test_finding_key
    scores = ["ABCCADCB",
              "DDDCAACB",
              "ABDDABCB",
              "AADCAACC",
              "BBDDAACB",
              "ABDCCABB",
              "ABDDCACB"].map{|l| l.split ""}

    assert_equal "ABDCAACB", find_key(scores)
  end
end
