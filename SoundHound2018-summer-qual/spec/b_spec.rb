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
abcdefgh
3
  EOS_INPUT
adg
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
lllll
1
  EOS_INPUT
lllll
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
souuundhound
2
  EOS_INPUT
suudon
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
abcdefg
7
  EOS_INPUT
a
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
z
1
  EOS_INPUT
z
  EOS_EXPECTED

end
