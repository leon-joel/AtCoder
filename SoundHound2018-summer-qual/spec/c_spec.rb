require 'rspec'
require 'active_support/core_ext/kernel/reporting'  # to suppress warning
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
    $stdout = stdout_org

    puts output
    # expect(output.to_f).to be_close(expected, 0.000001)
    expect((output.to_f - expected.to_f).abs < 0.000001).to be_truthy

    # expect(output).to eq expected

  end
end

describe "main_test0" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
2 3 1
  EOS_INPUT
1.0000000000
  EOS_EXPECTED
end

describe "main_test1" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
1000000000 180707 0
  EOS_INPUT
0.0001807060
  EOS_EXPECTED
end

describe "main_test2" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
5 2 0
  EOS_INPUT
0.2
  EOS_EXPECTED
end

# describe "main_test3" do
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 7
# 1 1 1 1 2 3 4
#   EOS_INPUT
# 6
#   EOS_EXPECTED
# end
#
# describe "main_test4" do
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 1
# 1
#   EOS_INPUT
# 0
#   EOS_EXPECTED
# end
#
# describe "main_test5" do
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 3
# 1 2 1000000000
#   EOS_INPUT
#      999999997
#   EOS_EXPECTED
# end
