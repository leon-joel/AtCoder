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
3 2 10 20
8 15 13
16 22
  EOS_INPUT
No War
  EOS_EXPECTED
end

describe "main_test1" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
4 2 -48 -1
-20 -35 -91 -23
-22 66
  EOS_INPUT
War
  EOS_EXPECTED
end

describe "main_test2" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
5 3 6 8
-10 3 1 5 -100
100 6 14
  EOS_INPUT
War
  EOS_EXPECTED
end

describe "main_test3" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
1 1 0 1
0
1
  EOS_INPUT
No War
  EOS_EXPECTED
end

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
