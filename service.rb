module Service
  require './services/converter'
  require './services/question'

  def convert(strings, options = {})
    strings = Converter.convert(strings, Array.new, options)
    
    result = File.new("result.txt", "w")
    strings.each do |string|
      result.write string + "\n"
    end
    result.close
  end
end
