require 'rspec'
require 'active_support/core_ext/kernel/reporting'  # to suppress warning
require_relative "../D/main"

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
    13 13
  EOS_INPUT
    1
  EOS_EXPECTED
end

describe "main_test1" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
    20 30
  EOS_INPUT
    28
  EOS_EXPECTED
end

describe "main_test2" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
    314 159
  EOS_INPUT
    1915
  EOS_EXPECTED
end
describe "main_test2.1" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
    159 314
  EOS_INPUT
    1915
  EOS_EXPECTED
end

describe "main_test3" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
    1 1
  EOS_INPUT
    0
  EOS_EXPECTED
end

describe "main_test999" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
    999 999
  EOS_INPUT
    40032
  EOS_EXPECTED
end


# describe "misc" do
#   it do
#     10.upto(1) do |x|
#       puts x
#     end
#   end
# end
#