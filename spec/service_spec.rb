require 'spec_helper'

describe Service do
  include Service

  describe "convert" do
    let(:input) { File.read(file_path "input1") }
    let(:output) { File.read file_path "output1" }
    
    subject { convert(input) }

    it { expect(subject).to eq output }
  end
end
