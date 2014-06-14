import sys

def is_prime(q):
    q = abs(q)
    if q == 2: return True
    if q < 2 or q&1 == 0: return False
    return pow(2, q-1, q) == 1

def main():
    for x in range(int(sys.argv[1]),int(sys.argv[2])):
        print(x,is_prime(x))

if __name__ == '__main__':
    argsmin = 2
    version = (3,0)
    if sys.version_info > (version):
        if len(sys.argv) > argsmin:
            main()
        else:
            print("This program needs at least %(argsmin)s arguments" %locals())
    else:
        print("This program requires python > %(version)s" %locals())

