require 'rspec'
require 'active_support/core_ext/kernel/reporting' # to suppress warning
require_relative "../C/main"

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

describe "test1" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
1222
  EOS_INPUT
1+2+2+2=7
  EOS_EXPECTED
end

describe "test2" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
0290
  EOS_INPUT
0-2+9+0=7
  EOS_EXPECTED
end

describe "test3" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
3242
  EOS_INPUT
3+2+4-2=7
  EOS_EXPECTED
end

describe "test4" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
  7000
  EOS_INPUT
    7+0+0+0=7
  EOS_EXPECTED
end

describe "test5" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
0007
  EOS_INPUT
0+0+0+7=7
  EOS_EXPECTED
end

# describe "test6" do
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
#     100 99 98
#   EOS_INPUT
#     YES
#   EOS_EXPECTED
# end
#
# describe "test7" do
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
#     100 100 99
#   EOS_INPUT
#     NO
#   EOS_EXPECTED
# end

# describe "test8" do
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 27
#   EOS_INPUT
# 27
#   EOS_EXPECTED
#
# end
# describe "test9" do
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 28
#   EOS_INPUT
# 27
#   EOS_EXPECTED
#
# end
# describe "test10" do
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 29
#   EOS_INPUT
# 27
#   EOS_EXPECTED
#
# end
# describe "test11" do
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 30
#   EOS_INPUT
# 27
#   EOS_EXPECTED
#
# end
# describe "test12" do
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
#
# 31
#   EOS_INPUT
# 27
#   EOS_EXPECTED
#
# end
# describe "test13" do
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
#
# 32
#   EOS_INPUT
# 32
#   EOS_EXPECTED
#
# end
# describe "test14" do
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 100
#   EOS_INPUT
# 100
#   EOS_EXPECTED
# end
