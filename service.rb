module Service
  require './services/converter'
  require './services/question'

  def convert(quiz, options = {})
    strings = quiz.split(/[\n\r]/).map do |string|
      string.gsub(/[\n\r]/) { |_| '' }
    end

    Converter.convert(strings, Array.new, options).join('')
  end

  def escape_regexp_chars(str)
    pattern = /[\.\+\*\?]/
    str.gsub(pattern) { |match| '\\' + match }
  end

  def to_suffix(str)
    '(' + escape_regexp_chars(str) + '?)'
  end
end
