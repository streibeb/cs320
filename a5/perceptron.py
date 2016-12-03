import numpy as np

class Perceptron:

    def __init__(self):
        self.w = np.array([0,0,0])

    def learn(self, data):
        print ' i  | x          | w          |  x[0] | x * w '
        print '----+------------+------------+-------+-------'

        i = 0
        while not self.check(data):
            # print '\n============= Iteration {0:2} ============='.format(i+1)
            x = np.array(data[i % len(data)])
            dot = np.dot(x[1:], self.w)
            print '{0:3} | {1:10} | {2:10} | {3:5} | {4:5}'.format(i+1, x[1:], self.w, x[0], np.dot(x[1:], self.w))
            if (x[0] == 1):
                if (np.dot(x[1:], self.w) < 0):
                    self.w = np.add(self.w, x[1:])
            else:
                if (np.dot(x[1:], self.w) >= 0):
                    self.w = np.subtract(self.w, x[1:])
            i += 1

    def check(self, data):
        for x in data:
            dot = np.dot(x[1:], self.w)

            if x[0] == 1 and dot < 0:
                return False
            elif x[0] == 0 and dot >= 0:
                return False
        return True
