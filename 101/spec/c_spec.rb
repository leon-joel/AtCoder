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
    # $stdin = stdin_org
    $stdout = stdout_org

    expect(output).to eq expected
  end
end

describe "main_test" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
4 3
2 3 1 4
  EOS_INPUT
2
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
3 3
1 2 3
  EOS_INPUT
1
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
8 3
7 3 1 8 4 6 2 5
  EOS_INPUT
4
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
8 3
7 3 6 8 4 1 2 5
  EOS_INPUT
4
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
9 3
7 3 6 8 4 1 2 5 9
  EOS_INPUT
4
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
2 2
1 2
  EOS_INPUT
1
  EOS_EXPECTED

  it_behaves_like "test_main", <<~eos_input.chomp, <<~eos_expected.chomp
6 4
6 5 4 3 2 1
  eos_input
2
  eos_expected

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
6 6
1 2 3 4 5 6
  EOS_INPUT
1
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
7 6
1 2 3 4 5 6 7
  EOS_INPUT
2
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
7 6
2 1 3 4 5 6 7
  EOS_INPUT
2
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
11 6
2 1 3 4 5 6 7 8 9 10 11
  EOS_INPUT
2
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
11 10
2 1 3 4 5 6 7 8 9 10 11
  EOS_INPUT
2
  EOS_EXPECTED

  it_behaves_like "test_main", <<~eos_input.chomp, <<~eos_expected.chomp
7 4
1 6 3 4 2 5 7
  eos_input
2
  eos_expected

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
7 2
1 6 3 4 2 5 7
  EOS_INPUT
6
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
7 2
7 6 3 4 2 1 5
  EOS_INPUT
6
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
3 3
2 1 3
  EOS_INPUT
1
  EOS_EXPECTED

#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 13123
#   EOS_INPUT
# 3
#   EOS_EXPECTED
#
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 93312
#   EOS_INPUT
# 2
#   EOS_EXPECTED

end
