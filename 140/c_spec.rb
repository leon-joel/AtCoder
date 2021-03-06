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
3
2 5
  EOS_INPUT
9
  EOS_EXPECTED
end

describe "main_test1" do
  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
2
3
  EOS_INPUT
6
  EOS_EXPECTED
end

describe "main_test2" do
  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
6
0 153 10 10 23
  EOS_INPUT
53
  EOS_EXPECTED
end

# describe "main_test3" do
#   it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
# 4
# 4 3 2 1
#   EOS_INPUT
# 3
#   EOS_EXPECTED
# end
#
# describe "main_test4" do
#   it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
# 1
# 1
#   EOS_INPUT
# 0
#   EOS_EXPECTED
# end
#
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
