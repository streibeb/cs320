import sys, argparse
from perceptron import Perceptron

def main(argv):
    parser = argparse.ArgumentParser()
    parser.add_argument("-t", "--test", type=int, choices=range(0,3))
    args = parser.parse_args()

    testOpt = 0
    if args.test != None:
        testOpt = args.test

    if testOpt == 0 or testOpt == 1:
        print '\n##############################################'
        print '# TEST  1                                    #'
        print '##############################################'
        data = [
            [0,1,0,0],
            [1,1,0,1],
            [1,1,1,0],
            [1,1,1,1]
        ]
        test(data)

    if testOpt == 0 or testOpt == 2:
        print '\n##############################################'
        print '# TEST  2                                    #'
        print '##############################################'
        data = [
            [0,1,0,0],
            [0,1,0,1],
            [0,1,1,0],
            [1,1,1,1]
        ]
        test(data)

def test(data):
    p = Perceptron()
    w = p.learn(data)

    print '\nFinal Result'
    for i in range(len(data)):
        print 'x[{0}]: {1}'.format(i, data[i])
    print '   w: {0}'.format(w)

if __name__ == '__main__':
    main(sys.argv[1:])
