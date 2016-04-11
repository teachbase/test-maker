module Service
  require './services/converter'
  require './services/question'

  def convert(quiz, options = {})
    strings = quiz.split(/[\n\r]/).map do |string|
      string.gsub(/[\n\r]/, '')
    end

    Converter.convert(strings, options)
  end

  def escape_regexp_chars(str)
    pattern = /[\.\+\*\?\(\)]/
    str.gsub(pattern) { |match| '\\' + match }
  end

  def escape_path_chars(str)
    pattern = /[\/\s\\\"]/
    str.gsub(pattern, '_')
  end

  def to_suffix(str)
    '((' + escape_regexp_chars(str) + ')?)'
  end

  def set_quiz_options(quiz)
    quiz["theme"] = "result" if quiz["theme"] == ""
    quiz["option_correct"] = "+|*" if quiz["option_correct"] == ""
    quiz["option_correct"] = to_suffix quiz["option_correct"]
  end

  def set_path(name)
    session[:dirname] ||= SecureRandom.hex(4)
    session[:path] = "/upload/#{session[:dirname]}/#{escape_path_chars name}.txt"
    session[:filename] = "public" + session[:path]
    FileUtils.rm_rf "public/upload/#{session[:dirname]}" if File.exist? "public/upload/" + session[:dirname]
    FileUtils.mkdir_p "public/upload/" + session[:dirname]
  end

  def write_result(questions)
    result = File.open(session[:filename], "w")

    questions.each do |question|
      question.write result
    end

    result.close
  end
end
