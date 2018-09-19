module step
  use flux, only: get_flux
  implicit none

contains

  ! Subroutine to fix the boundary conditions
  subroutine bounds(up,j, u0, un1, u1, nx, nu)
    ! Function to set the u0, un1, and u1
    integer :: nu
    real :: u0(nu), u1(nu), un1(nu)
    real :: up(nu,0:nx)
    integer :: j, nx

    if (j==nx) then
      u0 = up(:,j)
      u1 = up(:,0)
      un1 = up(:,j-1)
    elseif (j==0) then
      u0 = up(:,j)
      u1 = up(:,j+1)
      un1 = up(:,nx)
    else
      u0 = up(:,j)
      u1 = up(:,j+1)
      un1 = up(:,j-1)
    end if

  end subroutine bounds

  ! Progress the solution one step forward in time
  subroutine step_one(u, up, dx, dt, nx, nu)
    real :: dx, dt
    integer :: nx, nu, j
    real :: u(nu,0:nx), up(nu,0:nx)
    real :: fp1(nu), fn1(nu)
    real :: lambda, lambda_l, lambda_r
    real :: u0(nu), u1(nu), un1(nu)

    up = u
    do j=0,nx
      call bounds(up, j, u0, un1, u1, nx, nu)

      call get_flux(u0,u1,fp1, nu, lambda_r)
      call get_flux(un1,u0,fn1, nu, lambda_l)

      u(:,j) = u0 - (dt/dx)*(fp1-fn1)
    end do
  end subroutine step_one

end module step
