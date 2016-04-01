require 'spec_helper'

describe Service do
  include Service

  describe "convert" do
    let(:input) { File.read(file_path "input") }
    let(:output) { File.read file_path "output" }
    
    subject { convert(input) }

    it { expect(subject).to eq output }
  end
end
