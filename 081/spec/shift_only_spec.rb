require 'rspec' # for non-Rails

describe 'bit shift' do
  it {expect(5 & 1).to eq 1}
  it {expect(6 & 1).to eq 0}

  it "with shift" do
    a = 6
    expect(a & 1).to eq 0
    a >>= 1 # 3
    expect(a & 1).to eq 1
    a >>= 1 # 1
    expect(a & 1).to eq 1
  end

  it "bit pos check" do
    a = 6
    expect(a[0]).to eq 0
    expect(a[1]).to eq 1
    expect(a[2]).to eq 1
  end
end
