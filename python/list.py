import sys

class List(list):
    def head(self):
        return self[0]

    def tail(self):
        return self[1:]

    def init(self):
        return self[0:-1]

    def last(self):
        return self[-1]

    def shift(self):
        try:
            return self.pop(0)
        except IndexError:
            return None

def test_data():
    return List(['a', 'b', 'c', 'd', 'e'])

def main(args):
    list = test_data()

    print(list.head())
    print(list.tail())
    print(list.init())
    print(list.last())

    list = test_data()

    print(list.shift())
    print(list.shift())
    print(list.shift())
    print(list.shift())
    print(list.shift())
    print(list.shift())

if __name__ == '__main__':
    sys.exit(main(sys.argv))
