Cuba.define do
  on get do
    on "hello" do
      res.write partial("hello")
    end

    on "file" do
      res.write partial("file")
    end
  end

  on post do
    on root do
      on param(:quiz) do |quiz|
        strings = quiz.split(/[\n\r]/).map do |string|
          string.gsub(/[\n\r]/) { |_| '' }
        end

        @quiz = convert(strings)

        res.write partial("gift")
      end

      on true do
        res.write "Error"
      end
    end
  end
end
