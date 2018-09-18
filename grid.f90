module grid

  implicit none

contains

  subroutine set_grid(x, dx, nx)
    real, allocatable :: x(:)
    real :: dx, lx
    integer :: nx, i

    ! TODO dont have to change here, set config file?
    ! Set up spacing parameters
    nx = 100
    lx = 1.
    dx = 1./(nx+1)

    allocate(x(0:nx))

    ! Create the array of x values for the grid of evaluation
    x = (/(i*dx, i=0,nx)/)
  end subroutine set_grid

end module grid
