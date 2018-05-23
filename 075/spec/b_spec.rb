require 'rspec'
require 'active_support/core_ext/kernel/reporting'  # to suppress warning
require_relative "../B/minesweeper"

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

describe "main_test" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
3 5
.....
.#.#.
.....
  EOS_INPUT
11211
1#2#1
11211
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
3 5
#####
#####
#####
  EOS_INPUT
#####
#####
#####
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
6 6
#####.
#.#.##
####.#
.#..#.
#.##..
#.#...
  EOS_INPUT
#####3
#8#7##
####5#
4#65#2
#5##21
#4#310
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
1 1
.
  EOS_INPUT
0
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
1 1
#
  EOS_INPUT
#
  EOS_EXPECTED

#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 24
#   EOS_INPUT
# 16
#   EOS_EXPECTED
#
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 25
#   EOS_INPUT
# 25
#   EOS_EXPECTED
#
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 26
#   EOS_INPUT
# 25
#   EOS_EXPECTED
#
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 27
#   EOS_INPUT
# 27
#   EOS_EXPECTED
#
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 28
#   EOS_INPUT
# 27
#   EOS_EXPECTED
#
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 29
#   EOS_INPUT
# 27
#   EOS_EXPECTED
#
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 30
#   EOS_INPUT
# 27
#   EOS_EXPECTED
#
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 31
#   EOS_INPUT
# 27
#   EOS_EXPECTED
#
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 32
#   EOS_INPUT
# 32
#   EOS_EXPECTED
#
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 100
#   EOS_INPUT
# 100
#   EOS_EXPECTED

end
