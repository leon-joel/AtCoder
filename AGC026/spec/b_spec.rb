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
1
1000000000000000000 999999999999999983 599999999999999980 999999999999999985
  EOS_INPUT
No
  EOS_EXPECTED

  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
3
9 10 5 10
4 2 3 1
10 4 3 5
  EOS_INPUT
No
No
Yes
  EOS_EXPECTED
end
describe "main_test2" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
1
9 7 5 10
  EOS_INPUT
No
  EOS_EXPECTED
end

describe "main_test3" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
12
9 7 5 9
9 7 6 9
14 10 7 12
14 10 8 12
14 10 9 12
14 10 7 11
14 10 8 11
14 10 9 11
9 10 5 10
10 10 5 10
11 10 5 10
16 10 5 10
  EOS_INPUT
No
Yes
No
Yes
Yes
No
No
Yes
No
Yes
Yes
No
  EOS_EXPECTED
end

describe "main_test4" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
14
9 7 5 9
9 7 6 9
14 10 7 12
14 10 8 12
14 10 9 12
14 10 7 11
14 10 8 11
14 10 9 11
9 10 5 10
10 10 5 10
11 10 5 10
16 10 5 10
1000000000000000000 17 14 999999999999999985
1000000000000000000 17 15 999999999999999985
  EOS_INPUT
No
Yes
No
Yes
Yes
No
No
Yes
No
Yes
Yes
No
No
Yes
  EOS_EXPECTED
end

describe "main_test5" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
24
1 2 3 4
1 2 4 3
1 3 2 4
1 3 4 2
1 4 2 3
1 4 3 2
2 1 3 4
2 1 4 3
2 3 1 4
2 3 4 1
2 4 1 3
2 4 3 1
3 1 2 4
3 1 4 2
3 2 1 4
3 2 4 1
3 4 1 2
3 4 2 1
4 1 2 3
4 1 3 2
4 2 1 3
4 2 3 1
4 3 1 2
4 3 2 1
  EOS_INPUT
No
No
No
No
No
No
Yes
Yes
No
No
No
No
Yes
Yes
Yes
No
No
No
Yes
Yes
Yes
No
No
No
  EOS_EXPECTED
end

describe "main_test6" do
  it_behaves_like "test_main", <<~EOS_INPUT.chomp, <<~EOS_EXPECTED.chomp
1
16 10 5 10
  EOS_INPUT
No
  EOS_EXPECTED
end