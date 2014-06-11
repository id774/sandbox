import sys

class MainClass:
    def __init__(self, args):
        self.args1 = args[1]
        self.args2 = args[2]

    def main(self):
        print(self.args1)
        print(self.args2)

if __name__ == '__main__':
    argsmin = 2
    version = (3,0)
    if sys.version_info > (version):
        if len(sys.argv) > argsmin:
            main_instance = MainClass(sys.argv)
            main_instance.main()
        else:
            print("This program needs at least %(argsmin)s arguments" %locals())
    else:
        print("This program requires python > %(version)s" %locals())

