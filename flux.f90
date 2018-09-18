module flux
  use physics, only: get_f, get_v, get_cs
  implicit none
contains

  subroutine get_flux(ul, ur, f, nu, lambda)
    integer, intent(in) :: nu
    real, intent(in) :: ul(nu), ur(nu)
    real :: f(nu), fl(nu), fr(nu)
    real, intent(out) :: lambda
    real :: v_l, v_r
    real :: cs_l, cs_r

    ! Get the flux in the left and right cells
    call get_f(nu, ul, fl)
    call get_f(nu, ur, fr)

    ! Get the speed in the left and right cells
    call get_v(nu, v_l, ul)
    call get_v(nu, v_r, ur)

    ! Get the sound speeds
    call get_cs(nu, cs_l, ul)
    call get_cs(nu, cs_r, ur)

    lambda = max(abs(v_l)+cs_l, abs(v_r)+cs_r)

    ! Return the flux according to the K-T scheme
    f = (1./2)*(fr+fl - lambda*(ur-ul))

  end subroutine get_flux

end module flux
