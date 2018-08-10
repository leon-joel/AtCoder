require 'rspec'
require 'active_support/core_ext/kernel/reporting'  # to suppress warning
require_relative "../BinarySearch"

# RubyのArrayに実装されているbsearch_indexを使用
describe "Array.bsearch_index" do
  # NG側は先頭、OK側は末尾
  #            0   1   2   3   4   5    6    7    8    9
  let(:ary) { [1, 14, 32, 51, 51, 51, 243, 419, 750, 910] }

  describe "find-minimumモード" do
    describe "ascending order" do
      # ※ブロックの評価結果がtrueになる最初（一番左）のindexを返す
      it { expect(ary.bsearch_index {|v| 0 <= v}).to eq 0 }
      it { expect(ary.bsearch_index {|v| 51 <= v}).to eq 3 }
      it { expect(ary.bsearch_index {|v| 800 <= v}).to eq 9 }
      it { expect(ary.bsearch_index {|v| 1000 <= v}).to be_nil }
    end

    describe "descending order" do
      # 逆順。NG側は末尾、OK側は先頭。
      #              0    1    2    3   4   5   6   7   8  9
      let(:ary) { [910, 750, 419, 243, 51, 51, 51, 32, 14, 1] }

      # ※ブロックの評価結果がtrueになる最初（一番左）のindexを返す
      it { expect(ary.bsearch_index {|v| v <= 51}).to eq 4 }
      it { expect(ary.bsearch_index {|v| v <= 800}).to eq 1 }
      it { expect(ary.bsearch_index {|v| v <= 1000}).to eq 0 }
    end
  end

  describe "find-anyモード" do
    # ※正解が複数ある場合、どのうちどれかのindexを返す
    # ※ブロックは、正解が右側なら正の数を、左側なら負の数を、正解なら0を返すように実装する
    it { expect(ary.bsearch_index {|v| 32 - v}).to eq 2 }
    it { expect(ary.bsearch_index {|v| 51 - v}).to eq 5 } # 51になるどれかのindexを返す
    it { expect(ary.bsearch_index {|v| 243 - v}).to eq 6 }
    it { expect(ary.bsearch_index {|v| 910 - v}).to eq 9 }

    it "200 <= v < 500 にマッチする値を探す" do
      expect(ary.bsearch_index do |v|
        if v < 200
          1
        elsif 500 <= v
          -1
        else
          0
        end
      end).to eq 7
    end

    it "0 を返す値がなかった場合は, nilが返される" do
      expect(ary.bsearch_index {|v| 30 - v}).to be_nil
    end

    # 範囲外はnilが返される
    it { expect(ary.bsearch_index {|v| 0 - v}).to eq nil }
    it { expect(ary.bsearch_index {|v| 1000 - v}).to eq nil }
  end
end

describe "binary_search" do
  describe "ascending order" do
    # NG側は先頭、OK側は末尾
    let(:ary) { [1, 14, 32, 51, 51, 51, 243, 419, 750, 910] }

    # key以上となる最小のidxを探す
    it { expect(binary_search(ary, 51)).to eq 3 }
    it { expect(binary_search(ary, 32)).to eq 2 }

    it "見つからない場合は length を返す" do
      expect(binary_search(ary, 1000)).to eq 10
    end
  end

  describe "descending order" do
    # 逆順。NG側は末尾、OK側は先頭。
    #              0    1    2    3   4   5   6   7   8  9
    let(:ary) { [910, 750, 419, 243, 51, 51, 51, 32, 14, 1] }

    # 逆順の場合は正しい答えが得られない
    # ※ただし、評価関数の実装を逆転すればちゃんと使える
    it { expect(binary_search(ary, 51)).to eq 0 }
    it { expect(binary_search(ary, 32)).to eq 0 }

    it "見つからない場合は length を返す" do
      expect(binary_search(ary, 1000)).to eq 10
    end
  end
end

describe "meguru_search" do
  describe "ascending order" do
    # NG側は先頭、OK側は末尾
    let(:ary) { [1, 14, 32, 51, 51, 51, 243, 419, 750, 910] }

    # key以上となる最小のidxを探す
    it { expect(meguru_search(ary, 51)).to eq 3 }
    it { expect(meguru_search(ary, 32)).to eq 2 }

    it "見つからない場合は length を返す" do
      expect(meguru_search(ary, 1000)).to eq 10
    end
  end

  describe "descending order" do
    # 逆順。NG側は末尾、OK側は先頭。
    #              0    1    2    3   4   5   6   7   8  9
    let(:ary) { [910, 750, 419, 243, 51, 51, 51, 32, 14, 1] }

    it "逆順の場合は ok, ng を明示的に与える ➾ 末尾から探した時に条件を満たす最初のindexを返す" do
      expect(meguru_search(ary, 51, ary.length, -1)).to eq 6
    end
    it "ok/ngを明示的に与えないと正しい答えが得られない" do
      expect(meguru_search(ary, 910)).to eq 10
    end

    it "逆順の場合、見つからない場合は -1 を返す" do
      expect(meguru_search(ary, 1000, ary.length, -1)).to eq -1
    end
  end
end

describe "b_search_with_block" do
  describe "ascending order" do
    # NG側は先頭、OK側は末尾
    let(:ary) { [1, 14, 32, 51, 51, 51, 243, 419, 750, 910] }

    # key以上となる最小のidxを探す
    it { expect(b_search(ary){|i| 51 <= ary[i]}).to eq 3 }
    it { expect(b_search(ary){|i| 32 <= ary[i]}).to eq 2 }

    it { expect(b_search(ary){|i| 1000 <= ary[i]}).to eq ary.length }
  end

  describe "descending order" do
    # 逆順。NG側は末尾、OK側は先頭。
    #              0    1    2    3   4   5   6   7   8  9
    let(:ary) { [910, 750, 419, 243, 51, 51, 51, 32, 14, 1] }

    # key【以下】となる最小のidxを探す
    it { expect(b_search(ary){|i| ary[i] <= 51}).to eq 4 }
    it { expect(b_search(ary){|i| ary[i] <= 32}).to eq 7 }
    it { expect(b_search(ary){|i| ary[i] <= 1}).to eq 9 }

    it { expect(b_search(ary){|i| ary[i] <= 0}).to eq ary.length }
  end
end
