import numpy as np

class Perceptron:

    def __init__(self):
        self.w = np.array([0,0,0])

    def learn(self, data):
        print ' i  | x          | w          |  x[0] | x * w '
        print '----+------------+------------+-------+-------'

        counter = 0
        for i in range(1000):
            if (counter == len(data)-1):
                break

            x = np.array(data[i % len(data)])
            dot = np.dot(x[1:], self.w)
            # print 'Iteration {0}'.format(i+1)
            # print 'x: {0:15} w: {1:15}'.format(x[1:], self.w)
            if (x[0] == 1):
                # print 'Positive x[0]'
                if (dot < 0):
                    self.w = np.add(self.w, x[1:])
                    # print 'Corrected w: {0}'.format(self.w)
                    counter = 0
                else:
                    counter += 1
            else:
                # print 'Negative x[0]'
                if (dot >= 0):
                    self.w = np.subtract(self.w, x[1:])
                    # print 'Corrected w: {0}'.format(self.w)
                    counter = 0
                else:
                    counter += 1

            print '{0:3} | {1:10} | {2:10} | {3:5} | {4:5}'.format(i+1, x[1:], self.w, x[0], dot)
        return self.w
