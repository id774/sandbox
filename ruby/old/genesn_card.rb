# genesn_card.rb: Draw a card or deal a shuffled program
#
# Description:
# Draw one card from a fixed card set when no argument is given, or deal a
# shuffled program of 16 cards when any argument is given.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby genesn_card.rb [any argument]
#
# Requirements:
# - Ruby
#

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
