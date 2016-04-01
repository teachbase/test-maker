require 'spec_helper'

describe Service do
  include Service

  describe "convert" do
    let(:options) { {} }
    subject { convert(input, options) }

    context "default" do
      let(:input) { File.read(file_path "input1") }
      let(:output) { File.read file_path "output1" }

      it { expect(subject).to eq output }
    end

    context "with options" do
      let(:input) { File.read(file_path "input2") }
      let(:output) { File.read file_path "output2" }

      let(:options) do
        { question_prefix: '^\s*\d+\.',
          option_prefix: '^\s*\d\)',
          option_correct: '(\+?)' }
      end

      it { expect(subject).to eq output }
    end
  end
end
