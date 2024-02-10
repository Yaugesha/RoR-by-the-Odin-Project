def caesar_cipher string, step

  result = ""

  string.each_codepoint do |char|
    if (char >= 65 && char <= 90-step) || (char >= 97 && char <= 122-step)
      new_char = char + step
      result << new_char.chr
    elsif (char >= 90-step && char <= 90)
      result << (64 + char + step - 90).chr
    elsif (char >= 122-step && char <= 122)
      result << (96 + char + step - 122).chr
    else
      result << char.chr
    end
  end

  puts result

end

caesar_cipher("What a string!", 5)
