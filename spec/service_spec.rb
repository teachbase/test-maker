require 'spec_helper'

describe Service do
  include Service

  xdescribe "convert" do
    let(:options) { {} }
    let(:result) { File.open file_path("result"), "w" }
    subject do
      convert(input, options).each { |q| q.write(result) }
      result.close
      File.read file_path "result"
    end

    context "default" do
      let(:input) { File.read file_path "input1" }
      let(:output) { File.read file_path "output1" }

      it { expect(subject).to eq output }
    end

    context "with options" do
      let(:input) { File.read file_path "input2" }
      let(:output) { File.read file_path "output2" }

      let(:options) do
        { option_prefix: '^\s*\d\)',
          option_correct: '(\+?)' }
      end

      it { expect(subject).to eq output }
    end
  end
end
