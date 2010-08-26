cards = ["ACQUIRE","BUG","SURGE","POISON","SELF_DESTRUCT","BIT_SWAPPER","BIT_FACTORY","BIT_REMOVER","BIT_WORM","BIT_OVERWRITE","RUN_PAST","RUN_FUTURE","REVERSE_ORDER","DECREMENT","INCREMENT","MOVE_CARD","REMOVE_CARD"]
(puts "drawn card is:"+cards[rand(cards.length)];exit) if !ARGV[0]
card2 = cards.dup
prg = []
16.times do
    i = rand(card2.length)
    prg << card2[i]
    card2.delete_at(i)
end
i = 1
prg.each do |c|
    if i < 10
        t = i.to_s+" "
    else
        t = i.to_s
    end
    puts "#{t}: #{c}"
    i += 1
end
