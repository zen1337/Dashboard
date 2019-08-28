import sys

argi = sys.argv

def combine(x):
    print(x + x)

def main():
    for arg in sys.argv[1:]:
        print(arg)

if __name__ == "__main__":
    main()
