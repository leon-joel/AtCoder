require 'rspec' # for non-Rails

describe 'range' do
  # 末尾を含む
  it {expect((0..100).include?(-1)).to eq false}
  it {expect((0..100).include?(0)).to eq true}
  it {expect((0..100).include?(99)).to eq true}
  it {expect((0..100).include?(100)).to eq true}
  it {expect((0..100).include?(101)).to eq false}

  # 末尾は含まない
  it {expect((0...100).include?(99)).to eq true}
  it {expect((0...100).include?(100)).to eq false}
end
