require 'rspec'
require 'active_support/core_ext/kernel/reporting'  # to suppress warning
require_relative "../f"

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
    output = $stdout.string
    # $stdin = stdin_org
    $stdout = stdout_org

    expect(output).to eq expected
  end
end

describe "main_test0" do
  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
2 0
  EOS_INPUT
8
  EOS_EXPECTED
end

describe "main_test0-1" do
  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
2 1
1 1 1
  EOS_INPUT
4
  EOS_EXPECTED
end
describe "main_test0-2" do
  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
2 2
1 1 1
1 2 1
  EOS_INPUT
2
  EOS_EXPECTED
end
describe "main_test0-3" do
  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
2 3
1 1 1
1 2 1
2 1 1
  EOS_INPUT
1
  EOS_EXPECTED
end
describe "main_test0-4" do
  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
2 4
1 1 0
1 2 0
2 1 0
2 2 0
  EOS_INPUT
1
  EOS_EXPECTED
end
describe "main_test0-4x" do
  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
2 4
1 1 0
1 2 0
2 1 1
2 2 0
  EOS_INPUT
0
  EOS_EXPECTED
end
describe "main_test0-4x1" do
  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
2 3
1 1 0
2 1 1
2 2 0
  EOS_INPUT
1
  EOS_EXPECTED
end
describe "main_test0-5o" do
  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
3 7
1 1 0
1 2 0
2 1 0
2 2 0
2 3 0
3 2 1
3 3 1
  EOS_INPUT
2
  EOS_EXPECTED
end
describe "main_test0-5i" do
  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
3 2
3 1 1
1 3 1
  EOS_INPUT
16
  EOS_EXPECTED
end
describe "main_test0-5i2" do
  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
3 2
3 1 0
1 3 1
  EOS_INPUT
16
  EOS_EXPECTED
end

describe "main_test1" do
  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
3 3
1 1 1
3 1 0
2 3 1
  EOS_INPUT
8
  EOS_EXPECTED
end

describe "main_test2" do
  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
4 5
1 3 1
2 4 0
2 3 1
4 2 1
4 4 1
  EOS_INPUT
32
  EOS_EXPECTED
end

describe "main_test3" do
  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
3 5
1 3 1
3 3 0
3 1 0
2 3 1
3 2 1
  EOS_INPUT
0
  EOS_EXPECTED
end

describe "main_test4" do
  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
4 8
1 1 1
1 2 0
3 2 1
1 4 0
2 1 1
1 3 0
3 4 1
4 4 1
  EOS_INPUT
4
  EOS_EXPECTED
end

describe "main_test5" do
  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
100000 0
  EOS_INPUT
342016343
  EOS_EXPECTED
end

# describe "main_test6" do
#   it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
# 2 5
# 1 3
#   EOS_INPUT
# 2
#   EOS_EXPECTED
# end
#
# describe "main_test7" do
#   it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
# 1 3
# 1
#   EOS_INPUT
# 2
#   EOS_EXPECTED
# end

# describe "main_test8" do
#   it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
# 2 300
# 5 1000
# 3 500
#   EOS_INPUT
# 2
#   EOS_EXPECTED
# end
#
# describe "main_test9" do
#   it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
# 2 1600
# 5 1000
# 3 500
#   EOS_INPUT
# 6
#   EOS_EXPECTED
# end
#
# describe "main_test10" do
#   it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
# 10 5400
# 5 1000
# 3 500
# 5 1000
# 3 500
# 5 1000
# 3 500
# 5 1000
# 3 500
# 5 1000
# 3 500
#   EOS_INPUT
# 5
#   EOS_EXPECTED
# end
