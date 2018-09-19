import numpy as np
import matplotlib.pyplot as plt
import glob

def file_str(istep):
    return 'data/output_'+str(istep).zfill(5)+'.dat'

from matplotlib import animation

# First set up the figure, the axis, and the plot element we want to animate
fig = plt.figure()
ax = plt.axes(xlim=(0, 1), ylim=(0.6,1.4))
line, = ax.plot([], [], lw=2)

# initialization function: plot the background of each frame
def init():
    line.set_data([], [])
    return line,

# animation function.  This is called sequentially
def animate(i):

    data = np.genfromtxt(file_str(i))

    x = data[1:,0]
    y = data[1:,1]
    line.set_data(x, y)
    ax.set_title(r'$t={}$'.format(data[0,0]))
    return line,

# call the animator.  blit=True means only re-draw the parts that have changed.
anim = animation.FuncAnimation(fig, animate, init_func=init,
                               frames=2000, interval=20, blit=True)

anim.save('basic_animation.mp4', fps=30, extra_args=['-vcodec', 'libx264'])
