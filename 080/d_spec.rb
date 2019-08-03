require 'rspec'
require 'active_support/core_ext/kernel/reporting'  # to suppress warning
require_relative "d"

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

    expect(output).to eq expected.chomp
  end
end

describe "isEvenBits" do
  it do
    expect(Solver.new.isEvenBits(1, 0)).to be_falsey
    expect(Solver.new.isEvenBits(2, 0)).to be_truthy
    expect(Solver.new.isEvenBits(3, 0)).to be_falsey
    expect(Solver.new.isEvenBits(2, 1)).to be_falsey
    expect(Solver.new.isEvenBits(10, 0)).to be_truthy
    expect(Solver.new.isEvenBits(10, 1)).to be_falsey
    expect(Solver.new.isEvenBits(10, 2)).to be_truthy
    expect(Solver.new.isEvenBits(10, 3)).to be_falsey
    expect(Solver.new.isEvenBits(11, 0)).to be_truthy
  end
end

describe "main_test0" do
  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
    2 4
  EOS_INPUT
    5
  EOS_EXPECTED
end

describe "main_test1" do
  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
    123 456
  EOS_INPUT
    435
  EOS_EXPECTED
end

describe "main_test2" do
  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
    123456789012 123456789012
  EOS_INPUT
    123456789012
  EOS_EXPECTED
end

describe "main_test3" do
  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
1 1
  EOS_INPUT
1
  EOS_EXPECTED
end

describe "main_test4" do
  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
1 2
  EOS_INPUT
3
  EOS_EXPECTED
end

# describe "main_test5" do
#   it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
# atCoder
#   EOS_INPUT
# WA
#   EOS_EXPECTED
# end
#
# describe "main_test6" do
#   it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
# AtccodwC
#   EOS_INPUT
# WA
#   EOS_EXPECTED
# end
