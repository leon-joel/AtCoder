require 'rspec'
require 'active_support/core_ext/kernel/reporting'  # to suppress warning
require_relative "b"

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

describe "main_test1" do
  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
3
apple
orange
apple
1
grape
  EOS_INPUT
2
  EOS_EXPECTED
end

describe "main_test2" do
  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
3
apple
orange
apple
5
apple
apple
apple
apple
apple
  EOS_INPUT
1
  EOS_EXPECTED
end

describe "main_test3" do
  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
1
voldemort
10
voldemort
voldemort
voldemort
voldemort
voldemort
voldemort
voldemort
voldemort
voldemort
voldemort
  EOS_INPUT
0
  EOS_EXPECTED
end

describe "main_test4" do
  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
6
red
red
blue
yellow
yellow
red
5
red
red
yellow
green
blue
  EOS_INPUT
1
  EOS_EXPECTED
end

# describe "main_test5" do
#   it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
# 4 1
#   EOS_INPUT
# 0
#   EOS_EXPECTED
# end
#
# describe "main_test6" do
#   it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
# 4 7
#   EOS_INPUT
# 2
#   EOS_EXPECTED
# end
#
# describe "main_test7" do
#   it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
# 4 8
#   EOS_INPUT
# 3
#   EOS_EXPECTED
# end
