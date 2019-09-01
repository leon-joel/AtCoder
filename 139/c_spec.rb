require 'rspec'
require 'active_support/core_ext/kernel/reporting'  # to suppress warning
require_relative "c"

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

describe "main_test0" do
  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
2 5
4 9
2 4
  EOS_INPUT
12
  EOS_EXPECTED
end

describe "main_test1" do
  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
4 30
6 18
2 5
3 10
7 9
  EOS_INPUT
130
  EOS_EXPECTED
end

describe "main_test2" do
  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
1 100000
1000000000 100000
  EOS_INPUT
100000000000000
  EOS_EXPECTED
end

# describe "main_test3" do
#   it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
# 9999
#   EOS_INPUT
# 246
#   EOS_EXPECTED
# end

# describe "main_test4" do
#   it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
# 2
# a
# a
#   EOS_INPUT
# No
#   EOS_EXPECTED
# end

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
