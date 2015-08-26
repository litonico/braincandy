def hue degree
  degree = degree % 360
  main_color = 1 * 255 # Let chroma (saturation * brightness) always == 1
  second_strongest_color = ((1 - (degree/60.0 % 2 - 1).abs) * 255).floor

  case degree
  when 0..60
    [main_color, second_strongest_color, 0]
  when 61..120
    [second_strongest_color, main_color, 0]
  when 121..180
    [0, main_color, second_strongest_color]
  when 181..240
    [0, second_strongest_color, main_color]
  when 241..300
    [second_strongest_color, 0, main_color]
  when 301..360
    [main_color, 0, second_strongest_color]
  end
end


def rgb_to_ansi r, g, b
  16 + 36*r + 6*g + b
end

def scale rgb
  rgb.map {|c| (c/255.0 * 5).floor }
end

def color token, degree
  r, g, b = scale hue(degree*20)
  color_code = rgb_to_ansi r, g, b
  "\e[38;5;#{color_code}m#{token}\e[0m"
end

def rainbowize text
  quot = false
  matches = {
    ")" => "(",
    "]" => "[",
    "}" => "{"
  }
  braces = {
    "(" => 0,
    "[" => 0,
    "{" => 0
  }
  output = []

  text.split(/([()\[\]{}"])/).each do |token|
    case token

    when "(", "[", "{"
      output << (color token, braces[token])
      unless quot
        braces[token] += 1
      end

    when ")", "]", "}"
      if braces[matches[token]] <= 0 && !quot
        abort "Unbalanced parens"
      else
        braces[matches[token]] -= 1
      end
      output << (color token, braces[matches[token]])

    when '"'
      quot = !quot
      output << token

    else
      output << token
    end
  end

  if braces.values.reduce(:+) > 0
    abort "Unbalanced parens"
  end
  if quot
    abort "Unclosed quote"
  end

  output.join
end

if __FILE__ == $0
  puts "Write some code"
  code = gets.chomp
  puts rainbowize(code)
end
