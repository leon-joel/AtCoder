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
    main
    output = $stdout.string.chomp
    # $stdin = stdin_org
    $stdout = stdout_org

    expect(output).to eq expected
  end
end

describe "main_test0" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
3 70
7 60
1 80
4 50
  EOS_INPUT
4
  EOS_EXPECTED
end

describe "main_test1" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
4 3
1 1000
2 4
3 1000
4 500
  EOS_INPUT
TLE
  EOS_EXPECTED
end

describe "main_test2" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
5 9
25 8
5 9
4 10
1000 1000
6 1
  EOS_INPUT
5
  EOS_EXPECTED
end

# describe "main_test3" do
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 999
#   EOS_INPUT
# 999
#   EOS_EXPECTED
# end

# describe "main_test4" do
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 2
# a
# a
#   EOS_INPUT
# No
#   EOS_EXPECTED
# end

# describe "main_test5" do
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# atCoder
#   EOS_INPUT
# WA
#   EOS_EXPECTED
# end
#
# describe "main_test6" do
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# AtccodwC
#   EOS_INPUT
# WA
#   EOS_EXPECTED
# end
