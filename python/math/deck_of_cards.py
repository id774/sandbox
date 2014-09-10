import sys

# Python program to shuffle a
# deck of card using the
# module random and draw 5 cards

# import modules
import itertools
import random

def take(takes):
    # make a deck of cards
    deck = list(
        itertools.product(list(range(1, 14)),
                          ['Spade', 'Heart', 'Diamond', 'Club']))

    # shuffle the cards
    random.shuffle(deck)

    # draw five cards
    print("You got:")
    for i in range(takes):
        print((deck[i][0], "of", deck[i][1]))

def main(args):
    take(int(args[1]))

if __name__ == '__main__':
    argsmin = 1
    version = (3, 0)
    if sys.version_info > (version):
        if len(sys.argv) > argsmin:
            sys.exit(main(sys.argv))
        else:
            print("This program needs at least %(argsmin)s arguments" %
                  locals())
    else:
        print("This program requires python > %(version)s" % locals())
