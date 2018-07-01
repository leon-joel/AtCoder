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

describe "main_test" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
10
  EOS_INPUT
1
2
3
4
5
6
7
8
9
19
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
20
  EOS_INPUT
1
2
3
4
5
6
7
8
9
19
29
39
49
59
69
79
89
99
199
299
  EOS_EXPECTED
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
30
  EOS_INPUT
1
2
3
4
5
6
7
8
9
19
29
39
49
59
69
79
89
99
199
299
399
499
599
699
799
899
999
1999
2999
3999
  EOS_EXPECTED
end
