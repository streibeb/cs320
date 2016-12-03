import sys, argparse
from perceptron import Perceptron

def main(argv):
    parser = argparse.ArgumentParser()
    parser.add_argument("-t", "--test", type=int, choices=range(0,3))
    args = parser.parse_args()

    test = 0
    if args.test != None:
        test = args.test

    if test == 0 or test == 1:
        print '\n##############################################'
        print '# TEST  1                                    #'
        print '##############################################'
        test1()

    if test == 0 or test == 2:
        print '\n##############################################'
        print '# TEST  2                                    #'
        print '##############################################'
        test2()

def test1():
    data = [
        [0,1,0,0],
        [1,1,0,1],
        [1,1,1,0],
        [1,1,1,1]
    ]

    p = Perceptron()
    p.learn(data)

def test2():
    data = [
        [0,1,0,0],
        [0,1,0,1],
        [0,1,1,0],
        [1,1,1,1]
    ]

    p = Perceptron()
    p.learn(data)


if __name__ == '__main__':
    main(sys.argv[1:])
