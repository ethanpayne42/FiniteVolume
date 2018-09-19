module flux
  use physics, only: get_f, get_cs, cons2prims_single
  implicit none
contains

  subroutine get_flux(ul, ur, f, nu, lambda)
    integer, intent(in) :: nu
    real, intent(in) :: ul(nu), ur(nu)
    real :: pl(nu), pr(nu)
    real :: f(nu), fl(nu), fr(nu)
    real, intent(out) :: lambda
    real :: v_l, v_r
    real :: cs_l, cs_r

    ! Get the flux in the left and right cells
    call get_f(nu, ul, fl)
    call get_f(nu, ur, fr)

    ! Get the speed in the left and right cells
    ! TODO call of con2prims
    call cons2prims_single(ul, pl, nu)
    call cons2prims_single(ur, pr, nu)

    v_l = pl(2)
    v_r = pr(2)

    ! Get the sound speeds
    call get_cs(nu, cs_l, ul)
    call get_cs(nu, cs_r, ur)

    lambda = max(abs(v_l)+abs(cs_l), abs(v_r)+abs(cs_r))

    ! Return the flux according to the K-T scheme
    f = (1./2)*(fr+fl - lambda*(ur-ul)) ! ul - ur or ur-ul?

  end subroutine get_flux

end module flux
