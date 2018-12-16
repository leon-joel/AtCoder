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
3
1 2 3
  EOS_INPUT
1
  EOS_EXPECTED
end

describe "main_test1" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
5
3 11 14 5 13
  EOS_INPUT
2
  EOS_EXPECTED
end

describe "main_test2" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
6
3 13 1 15 17 63
  EOS_INPUT
3
  EOS_EXPECTED
end

describe "main_test3" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
9
2 8 8 4 4 2 6 10 54
  EOS_INPUT
4
  EOS_EXPECTED
end

describe "main_test4" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
4
2 6 10 54
  EOS_INPUT
2
  EOS_EXPECTED
end

describe "main_test5" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
3
1000000000 1 999999999
  EOS_INPUT
0
  EOS_EXPECTED
end

# describe "main_test6" do
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# AtccodwC
#   EOS_INPUT
# WA
#   EOS_EXPECTED
# end
