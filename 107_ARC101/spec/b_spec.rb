require 'rspec'
require 'active_support/core_ext/kernel/reporting'  # to suppress warning
require_relative "../b"

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
4 4
##.#
....
##.#
.#.#
  EOS_INPUT
###
###
.##
  EOS_EXPECTED
end

describe "main_test1" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
3 3
#..
.#.
..#
  EOS_INPUT
#..
.#.
..#
  EOS_EXPECTED
end

describe "main_test2" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
4 5
.....
.....
..#..
.....
  EOS_INPUT
#
  EOS_EXPECTED
end

describe "main_test3" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
7 6
......
....#.
.#....
..#...
..#...
......
.#..#.
  EOS_INPUT
..#
#..
.#.
.#.
#.#
  EOS_EXPECTED
end

# describe "main_test4" do
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 10 3
# -31 -30 -29 -10 -1 10 20 48 49 50
#   EOS_INPUT
# 22
#   EOS_EXPECTED
# end
#
# describe "main_test5" do
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 10 1
# -31 -30 -29 -10 -1 10 20 48 49 50
#   EOS_INPUT
# 1
#   EOS_EXPECTED
# end
#
# describe "main_test6" do
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 10 3
# -31 -30 -29 -1 0 10 20 48 49 50
#   EOS_INPUT
# 12
#   EOS_EXPECTED
# end
#
# describe "main_test7" do
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 3 3
# 10 20 30
#   EOS_INPUT
# 30
#   EOS_EXPECTED
# end
#
# describe "main_test8" do
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 4 3
# -3 -2 -1 0
#   EOS_INPUT
# 2
#   EOS_EXPECTED
# end
#
# describe "main_test9" do
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 10 3
# -31 -30 -29 -10 0 10 20 48 49 50
#   EOS_INPUT
# 20
#   EOS_EXPECTED
# end
#
# describe "main_test10" do
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 10 8
# -31 -30 -29 -10 0 10 20 48 52 56
#   EOS_INPUT
# 110
#   EOS_EXPECTED
# end
#
# describe "main_test11" do
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 3 2
# -100000000 99999999 100000000
#   EOS_INPUT
# 100000000
#   EOS_EXPECTED
# end