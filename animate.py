import numpy as np
import matplotlib.pyplot as plt
import glob

def file_str(istep):
    return 'data/output_'+str(istep).zfill(5)+'.dat'

from matplotlib import animation

# First set up the figure, the axis, and the plot element we want to animate
fig = plt.figure()
ax = plt.axes(xlim=(0, 1), ylim=(0.0,1.4))
line, = ax.plot([], [], lw=2)

# initialization function: plot the background of each frame
def init():
    line.set_data([], [])
    return line,

# animation function.  This is called sequentially
def animate(i):

    if i%50 == 0:
        print(i)

    with open(file_str(i), 'rt') as f:
                # Read in a text file
                time = np.float(f.readline())

                data = np.loadtxt(f)

    x = data[0:,0]
    y = data[0:,1]
    line.set_data(x, y)
    ax.set_title(r'$t={}$'.format(time))
    return line,

# call the animator.  blit=True means only re-draw the parts that have changed.
anim = animation.FuncAnimation(fig, animate, init_func=init,
                               frames=580, interval=5, blit=True)

anim.save('basic_animation.mp4', fps=30, extra_args=['-vcodec', 'libx264'])
