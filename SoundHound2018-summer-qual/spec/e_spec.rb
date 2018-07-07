require 'rspec'
require 'active_support/core_ext/kernel/reporting'  # to suppress warning
require_relative "../E/main"

shared_examples "test_main" do |input, expected|
  it do
    # stdin_org = $stdin
    stdout_org = $stdout

    # 警告 already initialized constant を抑止するため active_support の silence_warnings を使用している
    Kernel::silence_warnings do
      ARGF = StringIO.new(input)
    end
    $stdout = StringIO.new
    main
    output = $stdout.string.chomp
    # $stdin = stdin_org
    $stdout = stdout_org

    expect(output).to eq expected
  end
end

describe "base" do
  it "TPoint" do
    p = TPoint.new(1, 1..3, nil)
    expect(p.idx).to eq 1
    expect(p.range).to eq 1..3
    expect(p.nodes.count).to eq 0
  end
end

using RangeExtension
describe "Range" do
  it "intersection" do
    expect((1..3).intersection(2..4)).to eq 2..3
    expect((1..3).intersection(3..4)).to eq 3..3
    expect((1..3).intersection(4..4)).to be_nil
  end
end

describe "main_test" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
3 3
1 2 3
2 3 5
1 3 4
  EOS_INPUT
1
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
4 3
1 2 6
2 3 7
3 4 5
  EOS_INPUT
3
  EOS_EXPECTED

  # it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
  #   7
  #   1 2 3 1000000000 4 5 6
  # EOS_INPUT
  #   999999994
  # EOS_EXPECTED
end
