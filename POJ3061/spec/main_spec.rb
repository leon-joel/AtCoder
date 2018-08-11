require 'rspec'
require 'active_support/core_ext/kernel/reporting'  # to suppress warning
require_relative "../main"

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
2
10 15
5 1 3 5 10 7 4 9 2 8
5 11
1 2 3 4 5
  EOS_INPUT
2
3
  EOS_EXPECTED

  # https://qiita.com/drken/items/ecd1a472d3a0e7db8dce
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED
2
10 28
5 1 2 5 10 7 4 9 2 8
12 25
4 6 7 8 1 2 110 2 4 20 3 9
  EOS_INPUT
4
1
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED
1
5 100
1 1 1 1 1
  EOS_INPUT
0
  EOS_EXPECTED

#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED
# 1 1 1
#   EOS_INPUT
# 1 0 1 0
#   EOS_EXPECTED

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
