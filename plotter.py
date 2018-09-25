import matplotlib.pyplot as plt
import numpy as np

import sys

ind = sys.argv[1]

filename = 'data/output_00{}.dat'.format(ind)

with open(filename, 'rt') as f:
            # Read in a text file
            time = np.float(f.readline())

            data = np.loadtxt(f)

x = data[:,0]
rho = data[:,1]
vs = data[:,2]
es = data[:,3]
ps = data[:,4]


plt.xlim(0,1)
plt.title('time={}'.format(time))

plt.plot(x, rho)
plt.show()

plt.xlim(0,1)
plt.plot(x, vs)
plt.show()

plt.xlim(0,1)

plt.plot(x, es)
plt.show()

plt.xlim(0,1)

plt.plot(x,ps)
plt.show()
