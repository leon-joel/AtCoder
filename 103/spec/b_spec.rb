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

describe "rotate_test" do
  it do
    s = "kyoto"
    expect(s = rotate(s)).to eq "okyot"
    expect(s = rotate(s)).to eq "tokyo"
    expect(s = rotate(s)).to eq "otoky"
    expect(s = rotate(s)).to eq "yotok"
    expect(s = rotate(s)).to eq "kyoto"

    s = "ab"
    expect(s = rotate(s)).to eq "ba"
    expect(s = rotate(s)).to eq "ab"
  end
end

describe "main_test" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
    kyoto
    tokyo
  EOS_INPUT
    Yes
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
    abc
    arc
  EOS_INPUT
    No
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
    aaaaaaaaaaaaaaab
    aaaaaaaaaaaaaaab
  EOS_INPUT
    Yes
  EOS_EXPECTED

  # cab, bca, abc
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
    abc
    cba
  EOS_INPUT
    No
  EOS_EXPECTED

end
