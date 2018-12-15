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
3 3 1
3 2
  EOS_INPUT
2
  EOS_EXPECTED
end

describe "main_test1" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
10 10 14
4 3
2 2
7 3
9 10
7 7
8 1
10 10
5 4
3 4
2 8
6 4
4 4
5 8
9 2
  EOS_INPUT
6
  EOS_EXPECTED
end

describe "main_test2" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
5 2 0
  EOS_INPUT
5
  EOS_EXPECTED
end

describe "main_test3" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
2 5 0
  EOS_INPUT
2
  EOS_EXPECTED
end

# describe "main_test4" do
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
#   EOS_INPUT
#   EOS_EXPECTED
# end
