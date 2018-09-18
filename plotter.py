import matplotlib.pyplot as plt
import numpy as np

data = np.genfromtxt('data/output_00000.dat')

x = data[1:,0]
rho = data[1:,1]
vs = data[1:,2]
es = data[1:,3]

plt.plot(x, rho)
plt.show()

plt.plot(x, vs)
plt.show()

plt.plot(x, es)
plt.show()
