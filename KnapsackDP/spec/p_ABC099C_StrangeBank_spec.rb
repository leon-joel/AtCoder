require 'rspec'
require 'active_support/core_ext/kernel/reporting'  # to suppress warning
require_relative "../p_ABC099C_StrangeBank"

shared_examples "test_main" do |input, expected|
  it do
    # stdin_org = $stdin
    stdout_org = $stdout

    # 警告 already initialized constant を抑止するため active_support の silence_warnings を使用している
    Kernel::silence_warnings do
      ARGF = StringIO.new(input)
    end
    $stdout = StringIO.new
    KnapsackDPSolver.new.main
    # AllSearchSolver.new.main
    # MemoizeRecursive.new.main
    output = $stdout.string
    # $stdin = stdin_org
    $stdout = stdout_org

    expect(output).to eq expected
  end
end

describe "main_test" do
  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
127
  EOS_INPUT
4
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
3
  EOS_INPUT
3
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
44852
  EOS_INPUT
16
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
1
  EOS_INPUT
1
  EOS_EXPECTED

#   it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
# 100000
#   EOS_INPUT
# 20
#   EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
35
  EOS_INPUT
6
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
36
  EOS_INPUT
1
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
81
  EOS_INPUT
1
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
13122
  EOS_INPUT
2
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
13123
  EOS_INPUT
3
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT, <<~EOS_EXPECTED
93312
  EOS_INPUT
2
  EOS_EXPECTED
end
