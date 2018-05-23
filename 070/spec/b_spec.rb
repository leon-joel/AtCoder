require 'rspec'
require 'active_support/core_ext/kernel/reporting'  # to suppress warning
require_relative "../B/main"

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
0 75 25 100
  EOS_INPUT
50
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
0 33 66 99
  EOS_INPUT
0
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
10 90 20 80
  EOS_INPUT
60
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
0 1 0 1
  EOS_INPUT
1
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
0 100 0 100
  EOS_INPUT
100
  EOS_EXPECTED
#
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 24
#   EOS_INPUT
# 16
#   EOS_EXPECTED
#
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 25
#   EOS_INPUT
# 25
#   EOS_EXPECTED
#
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 26
#   EOS_INPUT
# 25
#   EOS_EXPECTED
#
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 27
#   EOS_INPUT
# 27
#   EOS_EXPECTED
#
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 28
#   EOS_INPUT
# 27
#   EOS_EXPECTED
#
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 29
#   EOS_INPUT
# 27
#   EOS_EXPECTED
#
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 30
#   EOS_INPUT
# 27
#   EOS_EXPECTED
#
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 31
#   EOS_INPUT
# 27
#   EOS_EXPECTED
#
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 32
#   EOS_INPUT
# 32
#   EOS_EXPECTED
#
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# 100
#   EOS_INPUT
# 100
#   EOS_EXPECTED

end
