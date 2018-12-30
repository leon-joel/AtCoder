require 'rspec'
require 'active_support/core_ext/kernel/reporting'  # to suppress warning
require_relative "../BIT"

describe "BIT spec" do
  it 'test' do
    bit = BIT.new(10)
    expect(bit.sum(1)).to eq 0
    expect(bit.sum(9)).to eq 0
    expect(bit.sum(10)).to eq 0
    # expect(bit.sum(11)).to eq 0 # これは範囲外
    expect(bit.range_sum(1, 10)).to eq 0
    expect(bit.count(10)).to eq 0

    bit.add(1, 1)
    expect(bit.sum(1)).to eq 1
    expect(bit.sum(10)).to eq 1
    expect(bit.range_sum(1, 1)).to eq 1
    expect(bit.range_sum(1, 10)).to eq 1
    expect(bit.range_sum(2, 10)).to eq 0
    expect(bit.count(1)).to eq 1
    expect(bit.count(2)).to eq 0

    bit.add(3, 10)
    expect(bit.sum(2)).to eq 1
    expect(bit.sum(3)).to eq 11
    expect(bit.sum(10)).to eq 11
    expect(bit.range_sum(1, 3)).to eq 11
    expect(bit.count(3)).to eq 10
    expect(bit.count(4)).to eq 0

    bit.add(10, 100)
    expect(bit.sum(9)).to eq 11
    expect(bit.sum(10)).to eq 111
    expect(bit.range_sum(3, 10)).to eq 110
    expect(bit.range_sum(1, 10)).to eq 111
    expect(bit.range_sum(0, 10)).to eq 111
    expect(bit.count(10)).to eq 100
    expect(bit.count(9)).to eq 0

    bit.add(9, -200)
    expect(bit.sum(9)).to eq -189
    expect(bit.sum(10)).to eq -89
    expect(bit.range_sum(5, 9)).to eq -200
    expect(bit.range_sum(9, 10)).to eq -100
    expect(bit.range_sum(10, 10)).to eq 100
    expect(bit.count(9)).to eq -200
    expect(bit.count(10)).to eq 100

    # bit.add(0, 1000)  # これは無限ループ
  end
end

shared_examples "test_main" do |input, expected|
  it do
    # stdin_org = $stdin
    stdout_org = $stdout

    # 警告 already initialized constant を抑止するため active_support の silence_warnings を使用している
    Kernel::silence_warnings do
      ARGF = StringIO.new(input)
    end
    $stdout = StringIO.new
    Solver.new.main
    output = $stdout.string.chomp
    # $stdin = stdin_org
    $stdout = stdout_org

    expect(output).to eq expected
  end
end

describe "main_test0" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
5
3 1 5 4 2
  EOS_INPUT
5
  EOS_EXPECTED
end

describe "main_test1" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
6
1 2 3 4 5 6
  EOS_INPUT
0
  EOS_EXPECTED
end

describe "main_test2" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
7
7 6 5 4 3 2 1
  EOS_INPUT
21
  EOS_EXPECTED
end

describe "main_test3" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
20
19 11 10 7 8 9 17 18 20 4 3 15 16 1 5 14 6 2 13 12
  EOS_INPUT
114
  EOS_EXPECTED
end
