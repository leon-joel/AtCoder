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
    output = $stdout.string.chomp
    # $stdin = stdin_org
    $stdout = stdout_org

    expect(output).to eq expected
  end
end

describe "main_test0" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
azzel
apple
  EOS_INPUT
Yes
  EOS_EXPECTED
end

describe "main_test1" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
chokudai
redcoder
  EOS_INPUT
No
  EOS_EXPECTED
end

describe "main_test2" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
abcdefghijklmnopqrstuvwxyz
ibyhqfrekavclxjstdwgpzmonu
  EOS_INPUT
Yes
  EOS_EXPECTED
end

describe "main_test3" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
a
b
  EOS_INPUT
Yes
  EOS_EXPECTED
end

describe "main_test4" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
z
z
  EOS_INPUT
Yes
  EOS_EXPECTED
end

# describe "main_test5" do
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 2 3
# 1 2
#   EOS_INPUT
# 1
#   EOS_EXPECTED
# end
#
# describe "main_test6" do
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 2 5
# 1 3
#   EOS_INPUT
# 2
#   EOS_EXPECTED
# end
#
# describe "main_test7" do
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 1 3
# 1
#   EOS_INPUT
# 2
#   EOS_EXPECTED
# end

# describe "main_test8" do
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 2 300
# 5 1000
# 3 500
#   EOS_INPUT
# 2
#   EOS_EXPECTED
# end
#
# describe "main_test9" do
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 2 1600
# 5 1000
# 3 500
#   EOS_INPUT
# 6
#   EOS_EXPECTED
# end
#
# describe "main_test10" do
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
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
