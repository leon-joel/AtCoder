require 'rspec' # for non-Rails

describe 'div' do
  it {expect(  0 / 500).to eq 0}
  it {expect(499 / 500).to eq 0}
  it {expect(500 / 500).to eq 1}
end
