require 'rspec'
require 'active_support/core_ext/kernel/reporting'  # to suppress warning
require_relative "../p2_knapsacks_problem"

shared_examples "test_main" do |input, expected|
  it do
    # stdin_org = $stdin
    stdout_org = $stdout

    # 警告 already initialized constant を抑止するため active_support の silence_warnings を使用している
    Kernel::silence_warnings do
      ARGF = StringIO.new(input)
    end
    $stdout = StringIO.new
    KnapsackDPSolver.new.main
    # AllSearchSolver.new.main
    # MemoizeRecursive.new.main
    output = $stdout.string
    # $stdin = stdin_org
    $stdout = stdout_org

    expect(output).to eq expected
  end
end

describe "main_test0" do
  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
4 5
4 2
5 2
2 1
8 3
  EOS_INPUT
13
  EOS_EXPECTED
end

describe "main_test1" do
  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
2 20
5 9
4 10
  EOS_INPUT
9
  EOS_EXPECTED
end

describe "main_test2" do
  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
6 8
3 2
2 1
6 3
1 2
3 1
85 5
  EOS_INPUT
91
  EOS_EXPECTED
end

# ナップサックDPだと15ms
# 全探索だと200品目でも終わらない
describe "main_test3" do
  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
200 50
10 10
2 1
6 3
1 2
3 1
85 5
3 2
2 1
6 3
1 2
3 1
85 5
3 2
2 1
6 3
1 2
3 1
85 5
3 2
2 1
6 3
1 2
3 1
85 5
3 2
2 1
6 3
1 2
3 1
85 5
3 2
2 1
6 3
1 2
3 1
85 5
3 2
2 1
6 3
1 2
3 1
85 5
3 2
2 1
6 3
1 2
3 1
85 5
1 2
3 1
3 2
2 1
6 3
1 2
3 1
85 5
3 2
2 1
6 3
1 2
3 1
85 5
3 2
2 1
6 3
1 2
3 1
85 5
3 2
2 1
6 3
1 2
3 1
85 5
3 2
2 1
6 3
1 2
3 1
85 5
3 2
2 1
6 3
1 2
3 1
85 5
3 2
2 1
6 3
1 2
3 1
85 5
3 2
2 1
6 3
1 2
3 1
85 5
1 2
3 1
3 2
2 1
6 3
1 2
3 1
85 5
3 2
2 1
6 3
1 2
3 1
85 5
3 2
2 1
6 3
1 2
3 1
85 5
3 2
2 1
6 3
1 2
3 1
85 5
3 2
2 1
6 3
1 2
3 1
85 5
3 2
2 1
6 3
1 2
3 1
85 5
3 2
2 1
6 3
1 2
3 1
85 5
3 2
2 1
6 3
1 2
3 1
85 5
1 2
3 1
3 2
2 1
6 3
1 2
3 1
85 5
3 2
2 1
6 3
1 2
3 1
85 5
3 2
2 1
6 3
1 2
3 1
85 5
3 2
2 1
6 3
1 2
3 1
85 5
3 2
2 1
6 3
1 2
3 1
85 5
3 2
2 1
6 3
1 2
3 1
85 5
3 2
2 1
6 3
1 2
3 1
85 5
3 2
2 1
6 3
1 2
3 1
85 5
1 2
3 1
  EOS_INPUT
850
  EOS_EXPECTED
end

# describe "main_test4" do
#   it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
# 4 4 12
#   EOS_INPUT
# 13
#   EOS_EXPECTED
# end
