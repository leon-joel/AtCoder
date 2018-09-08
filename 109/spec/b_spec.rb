require 'rspec'
require 'active_support/core_ext/kernel/reporting'  # to suppress warning
require_relative "../b"

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

describe "main_test0" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
4
hoge
english
hoge
enigma
  EOS_INPUT
No
  EOS_EXPECTED
end

describe "main_test1" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
9
basic
c
cpp
php
python
nadesico
ocaml
lua
assembly
  EOS_INPUT
Yes
  EOS_EXPECTED
end

describe "main_test2" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
8
a
aa
aaa
aaaa
aaaaa
aaaaaa
aaa
aaaaaaa
  EOS_INPUT
No
  EOS_EXPECTED
end

describe "main_test3" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
3
abc
arc
agc
  EOS_INPUT
No
  EOS_EXPECTED
end

describe "main_test4" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
2
a
a
  EOS_INPUT
No
  EOS_EXPECTED
end

# describe "main_test5" do
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# atCoder
#   EOS_INPUT
# WA
#   EOS_EXPECTED
# end
#
# describe "main_test6" do
#   it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
# AtccodwC
#   EOS_INPUT
# WA
#   EOS_EXPECTED
# end
