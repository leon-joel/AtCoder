# ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
#
# Ruby には Array#bsearch, bsearch_index が予め実装されているので、
# まずはそれを使うことを検討すること。
#
# ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★


# 二分探索 【yield版】
# ※blockがtrueを返す最小のidxを返す
# ※Array#bsearch_index と同じ。このままだと存在価値はないが、色々カスタマイズできるので存在価値はある。
# ※『aryの先頭側が条件を満たさない、末尾側が条件を満たす』という前提だが、
#   Blockの実装（戻り値）を逆転させれば、逆でも可能。
def b_search(ary, &block)
  left = -1
  right = ary.length

  while 1 < right - left
    mid = left + (right - left) / 2

    if block.call(mid)
      right = mid
    else
      left = mid
    end
  end

  # left は条件を満たさない最大のidx、right は条件を満たす最小のidxになっている
  right
end

######################################################
# 以下は一般的な二分探索
# https://qiita.com/drken/items/97e37dd6143e33a64c8c

# 評価関数
def is_ok(ary, idx, key)
  key <= ary[idx]
end

# 二分探索
# ※条件を満たす最小のidxを返す
# ※『aryの先頭側が条件を満たさない、末尾側が条件を満たす』という前提
#   ただし、is_okの戻り値を逆転させれば、逆でも可能。
def binary_search(ary, key)
  left = -1
  right = ary.length

  while 1 < right - left
    mid = left + (right - left) / 2

    if is_ok(ary, mid, key)
      right = mid
    else
      left = mid
    end
  end

  # left は条件を満たさない最大の値、right は条件を満たす最小の値になっている
  right
end

# めぐる式 二分探索
# https://qiita.com/drken/items/97e37dd6143e33a64c8c
# 条件にマッチする最小の idx を返す。
# 見つからない場合は length を返す。
def meguru_search(ary, key, ng = -1, ok = ary.length)
  while 1 < (ok - ng).abs
    mid = (ok + ng) / 2

    if is_ok(ary, mid, key)
      ok = mid
    else
      ng = mid
    end
  end

  ok
end
