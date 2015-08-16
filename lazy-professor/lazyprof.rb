require 'matrix'

def read_scores filename
  File.readlines(File.expand_path(filename)).map {|s| s.split ""}
end

def transpose grid
  # Reads each row as a column of a matrix, transposing it.
  m = Matrix.columns grid
  m.to_a
end

def most_frequent_letter chararray
  letters = ["A", "B", "C", "D"]
  letters.max_by { |letter| chararray.count(letter) }
end

def find_key raw_scores
  transpose(raw_scores).map{ |c| most_frequent_letter c }.join
end

if __FILE__ == $0
  scores = read_scores('./test.txt')
  puts find_key scores
end
