require 'rspec'
require 'active_support/core_ext/kernel/reporting'  # to suppress warning
require_relative "../d"

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
9
  EOS_INPUT
0
  EOS_EXPECTED
end

describe "main_test1" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
10
  EOS_INPUT
1
  EOS_EXPECTED
end

describe "main_test2" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
100
  EOS_INPUT
543
  EOS_EXPECTED
end

# describe "main_test3" do
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
#   EOS_INPUT
#   EOS_EXPECTED
# end
#
# describe "main_test4" do
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
#   EOS_INPUT
#   EOS_EXPECTED
# end
