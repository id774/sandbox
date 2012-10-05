# -*- coding: utf-8 -*-

module My
  class Pair < Array
    def initialize(*args)
      super
      # 引数が何個あっても，最初の2個だけ使ってペアにする
      slice!(2, (size - 2))
    end

    alias_method :original_eql?, :eql?
    alias_method :original_hash, :hash

    def eql?(other)
      sort.original_eql?(other.sort)
    end

    def hash
      sort.original_hash
    end

    alias == eql?
    alias left first
    alias right last
  end
end
