require 'rspec'
require 'active_support/core_ext/kernel/reporting'  # to suppress warning
require_relative "../Shakutori"

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
    output = $stdout.string
    # $stdin = stdin_org
    $stdout = stdout_org

    expect(output).to eq expected
  end
end

describe "main_test" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED
6 5
1 2 3 4 5 6
6 9 12 21 15
  EOS_INPUT
9
12
15
21
18
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED
6 1
5 3 8 6 1 4
12
  EOS_INPUT
11
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED
12 1
4 6 7 8 1 2 110 2 4 12 3 9
25
  EOS_INPUT
32
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED
4 1
12 1 2 3
10
  EOS_INPUT
6
  EOS_EXPECTED

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
