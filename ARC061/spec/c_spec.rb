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

    # 整数比較
    expect(output).to eq expected
    # 浮動小数比較
    # expect((output.to_f - expected.to_f).abs < 0.000001).to be_truthy
  end
end

describe "main_test" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
125
  EOS_INPUT
176
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
9999999999
  EOS_INPUT
12656242944
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
1
  EOS_INPUT
1
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
111
  EOS_INPUT
138
  EOS_EXPECTED

#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 4
# 2 2
# 0 0
# 1 1
# 3 3
#   EOS_INPUT
# 4.242641
#   EOS_EXPECTED
#
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 2
# 0 0
# 0 0
#   EOS_INPUT
# 0.000000
#   EOS_EXPECTED

end
