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
5 2
5 3 1 4 2
1 3
5 4
  EOS_INPUT
2
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
3 2
3 2 1
1 2
2 3
  EOS_INPUT
3
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
10 8
5 3 6 8 7 10 9 1 2 4
3 1
4 1
5 9
2 5
6 5
3 5
8 9
7 9
  EOS_INPUT
8
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
5 1
1 2 3 4 5
1 5
  EOS_INPUT
5
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
2 1
1 2
1 2
  EOS_INPUT
2
  EOS_EXPECTED

end
