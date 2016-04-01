require './service'

Cuba.plugin Service

Cuba.define do
  on get do
    on "new" do
      res.write partial("new")
    end
  end

  on post do
    on root do
      on param(:quiz), param(:question_prefix),
                       param(:option_prefix),
                       param(:option_correct, "(\\+|\\*?)") do |quiz, qp, op, oc|
        oc = to_suffix oc

        @string = convert(quiz, question_prefix: qp, option_prefix: op, option_correct: oc)

        res.write partial("gift")
      end

      on true do
        res.write "Error"
      end
    end
  end
end
