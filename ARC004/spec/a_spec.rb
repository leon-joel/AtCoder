require 'rspec'
require 'active_support/core_ext/kernel/reporting'  # to suppress warning
require_relative "../a"

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
    # expect(output).to eq expected
    # 浮動小数比較
    expect((output.to_f - expected.to_f).abs < 0.000001).to be_truthy
  end
end

describe "main_test" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
3
1 1
2 4
4 3
  EOS_INPUT
3.605551
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
10
1 8
4 0
3 7
2 4
5 9
9 1
6 2
0 2
8 6
7 8
  EOS_INPUT
10.630146
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
4
0 0
0 100
100 0
100 100
  EOS_INPUT
141.421356
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
5
3 0
1 0
0 0
4 0
2 0
  EOS_INPUT
4.000000
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
4
2 2
0 0
1 1
3 3
  EOS_INPUT
4.242641
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
2
0 0
0 0
  EOS_INPUT
0.000000
  EOS_EXPECTED

end
