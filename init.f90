module init
  use constants, only: pi
  use physics, only: prims2cons
  implicit none

contains

  subroutine set_init(u, up, x, nx, nu)
    integer :: nu, nx, j
    real :: A, g
    real, allocatable :: u(:,:), up(:,:)
    real :: x(0:nx)
    real, allocatable :: p(:,:)

    ! TODO put in setup file
    nu = 3
    A = 1.e-1
    g = 5./3.

    allocate(u(nu,0:nx))
    allocate(up(nu,0:nx))
    allocate(p(nu,0:nx))

    ! TODO choice or setup file?
    ! p(1,:) = 1 + A*sin(2*pi*x) ! Density initial condition (IC)
    ! p(2,:) = A*sin(2*pi*x) ! velocity IC
    ! p(3,:) = 1./(g*(g-1)) +g*A*sin(2*pi*x) ! energy IC

    do j=0,nx
      if ( x(j)<0.5 .and. x(j)>-0.5) then
        p(:,j) = [1.,0.,1.0]
      else
        p(:,j) = [0.125, 0.0, 0.1]
      end if
    end do

    ! Converts the primitive array of p = (rho, velocity, eps)
    ! to the conserved quantities
    call prims2cons(u, p, nu, nx)

  end subroutine set_init

end module init
