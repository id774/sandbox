## https://qiita.com/non-caffeine/items/77360dda05c8ce510084

import sys
import re

def replace_hyphen(text, replace_hyphen='-'):
    """Replace every dash character with an ASCII hyphen
    Args:
        text (str): the input text
        replace_hyphen (str): the replacement string
    Returns:
        (str): the text after replacement
    """
    hyphens = '-˗ᅳ᭸‐‑‒–—―⁃⁻−▬─━➖ーㅡ﹘﹣－ｰ𐄐𐆑 '
    hyphens = '|'.join(hyphens)
    return re.sub(hyphens, replace_hyphen, text)

class List(list):
    def shift(self):
        try:
            return self.pop(0)
        except IndexError:
            return None

if __name__ == '__main__':
    args = List(sys.argv)
    args0 = args.shift()
    if len(args) == 1:
        args1 = args.shift()
        print(replace_hyphen(args1))
    if len(args) > 1:
        args1 = args.shift()
        args2 = args.shift()
        print(replace_hyphen(args1, args2))
