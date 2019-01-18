require 'rspec'
require 'active_support/core_ext/kernel/reporting'  # to suppress warning
require_relative "../c"

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

describe "main_test0" do
  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
1500 2000 1900 3 2
  EOS_INPUT
8500
  EOS_EXPECTED
end

describe "main_test1" do
  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
1500 2000 1600 3 2
  EOS_INPUT
7900
  EOS_EXPECTED
end

describe "main_test2" do
  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
1500 2000 500 90000 100000
  EOS_INPUT
100000000
  EOS_EXPECTED
end
#
# describe "main_test3" do
#   it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
# 3 2
# 1
# 1
# 1
#   EOS_INPUT
# 0
#   EOS_EXPECTED
# end
#
# describe "main_test4" do
#   it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
# 4 3
# 1
# 1
# 2147483647
# 2147483647
#   EOS_INPUT
# 2147483646
#   EOS_EXPECTED
# end
#
# describe "main_test5" do
#   it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
# 18
# 1 1 1 1 2 1 2 3 2 2 3 3 3 3 3 3 3 3
# EOS_INPUT
# 10
#   EOS_EXPECTED
# end

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
