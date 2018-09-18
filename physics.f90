module physics

  implicit none

contains

  ! Subroutine to determine the flux in the cell
  subroutine get_f(nu,u,f)
    integer :: nu
    real :: u(nu), f(nu)

  end subroutine get_f

  ! Determine the velocity (convert from conserved to v)
  subroutine get_v(nu, v, u)
    integer :: nu
    real :: v
    real :: u(nu)

  end subroutine get_v

  ! Determine the sound speed in the cell adjacent
  subroutine get_cs(nu, cs, u)
    integer :: nu
    real :: cs
    real :: u(nu)

  end subroutine get_cs

end module physics
