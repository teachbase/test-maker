module Service
  require './services/converter'
  require './services/question'

  def convert(quiz, options = {})
    strings = quiz.split(/[\n\r]/).map do |string|
      string.gsub(/[\n\r]/) { |_| '' }
    end

    Converter.convert(strings, options)
  end

  def escape_regexp_chars(str)
    pattern = /[\.\+\*\?]/
    str.gsub(pattern) { |match| '\\' + match }
  end

  def to_suffix(str)
    '(' + escape_regexp_chars(str) + '?)'
  end

  def set_quiz_options(quiz)
    quiz["theme"] = "result" if quiz["theme"] == ""
    quiz["option_correct"] = "+|*" if quiz["option_correct"] == ""
    quiz["option_correct"] = to_suffix quiz["option_correct"]
  end

  def set_path(name)
    session[:path] ||= "/upload/#{SecureRandom.hex(4)}/#{name}.txt"
    session[:filename] = "public" + session[:path]
    FileUtils.mkdir_p File.dirname session[:filename]
  end

  def write_result(questions)
    result = File.open(session[:filename] , "w")

    questions.each do |question|
      question.write result
    end

    result.close
  end
end
