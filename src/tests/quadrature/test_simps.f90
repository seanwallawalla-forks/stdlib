module test_simps
    use stdlib_kinds, only: sp, dp, qp
    use testdrive, only : new_unittest, unittest_type, error_type, check
    use stdlib_quadrature, only: simps, simps_weights

    implicit none

    real(sp), parameter :: tol_sp = 1000 * epsilon(1.0_sp)
    real(dp), parameter :: tol_dp = 1000 * epsilon(1.0_dp)
    real(qp), parameter :: tol_qp = 1000 *epsilon(1.0_sp)


contains

    !> Collect all exported unit tests
    subroutine collect_simps(testsuite)
        !> Collection of tests
        type(unittest_type), allocatable, intent(out) :: testsuite(:)

        testsuite = [ &
            new_unittest("simps_sp", test_simps_sp), &
            new_unittest("simps_dp", test_simps_dp), &
            new_unittest("simps_qp", test_simps_qp), &
            new_unittest("simps_weights_sp", test_simps_weights_sp), &
            new_unittest("simps_weights_dp", test_simps_weights_dp), &
            new_unittest("simps_weights_qp", test_simps_weights_qp), &
            new_unittest("simps_zero_sp", test_simps_zero_sp), &
            new_unittest("simps_zero_dp", test_simps_zero_dp), &
            new_unittest("simps_zero_qp", test_simps_zero_qp), &
            new_unittest("simps_even_sp", test_simps_even_sp), &
            new_unittest("simps_even_dp", test_simps_even_dp), &
            new_unittest("simps_even_qp", test_simps_even_qp), &
            new_unittest("simps_weights_even_sp", test_simps_weights_even_sp), &
            new_unittest("simps_weights_even_dp", test_simps_weights_even_dp), &
            new_unittest("simps_weights_even_qp", test_simps_weights_even_qp), &
            new_unittest("simps_six_sp", test_simps_six_sp), &
            new_unittest("simps_six_dp", test_simps_six_dp), &
            new_unittest("simps_six_qp", test_simps_six_qp) &
            ]
    end subroutine collect_simps

    subroutine test_simps_sp(error)
        !> Error handling
        type(error_type), allocatable, intent(out) :: error

        integer, parameter :: n = 13
        real(sp), dimension(n) :: y
        real(sp), dimension(n) :: x
        real(sp) :: val
        real(sp) :: ans
        integer :: i


        y = [(real(i-1, sp)**2, i = 1, n)]

        val = simps(y, 1.0_sp)
        ans = 576.0_sp
        call check(error, val, ans, thr=tol_sp)
        if (allocated(error)) return

        val = simps(y, 0.5_sp)
        ans = 288.0_sp
        call check(error, val, ans, thr=tol_sp)
        if (allocated(error)) return

        x = [(0.25_sp*(i-1), i = 1, n)]
        val = simps(y, x)
        ans = 144.0_sp
        call check(error, val, ans, thr=tol_sp)
    end subroutine test_simps_sp


    subroutine test_simps_dp(error)
        !> Error handling
        type(error_type), allocatable, intent(out) :: error

        integer, parameter :: n = 13
        real(dp), dimension(n) :: y
        real(dp), dimension(n) :: x
        real(dp) :: val
        real(dp) :: ans
        integer :: i


        y = [(real(i-1, dp)**2, i = 1, n)]

        val = simps(y, 1.0_dp)
        ans = 576.0_dp
        call check(error, val, ans, thr=tol_dp)
        if (allocated(error)) return

        val = simps(y, 0.5_dp)
        ans = 288.0_dp
        call check(error, val, ans, thr=tol_dp)
        if (allocated(error)) return

        x = [(0.25_dp*(i-1), i = 1, n)]
        val = simps(y, x)
        ans = 144.0_dp
        call check(error, val, ans, thr=tol_dp)
    end subroutine test_simps_dp


    subroutine test_simps_qp(error)
        !> Error handling
        type(error_type), allocatable, intent(out) :: error

        integer, parameter :: n = 13
        real(qp), dimension(n) :: y
        real(qp), dimension(n) :: x
        real(qp) :: val
        real(qp) :: ans
        integer :: i


        y = [(real(i-1, qp)**2, i = 1, n)]

        val = simps(y, 1.0_qp)
        ans = 576.0_qp
        call check(error, val, ans, thr=tol_qp)
        if (allocated(error)) return

        val = simps(y, 0.5_qp)
        ans = 288.0_qp
        call check(error, val, ans, thr=tol_qp)
        if (allocated(error)) return

        x = [(0.25_qp*(i-1), i = 1, n)]
        val = simps(y, x)
        ans = 144.0_qp
        call check(error, val, ans, thr=tol_qp)
    end subroutine test_simps_qp


    subroutine test_simps_weights_sp(error)
        !> Error handling
        type(error_type), allocatable, intent(out) :: error

        integer, parameter :: n = 17
        real(sp), dimension(n) :: y
        real(sp), dimension(n) :: x
        real(sp), dimension(n) :: w
        integer :: i
        real(sp) :: val
        real(sp) :: ans


        y = [(real(i-1, sp), i = 1, n)]

        x = y
        w = simps_weights(x)
        val = sum(w*y)
        ans = simps(y, x)
        call check(error, val, ans, thr=tol_sp)
    end subroutine test_simps_weights_sp


    subroutine test_simps_weights_dp(error)
        !> Error handling
        type(error_type), allocatable, intent(out) :: error

        integer, parameter :: n = 17
        real(dp), dimension(n) :: y
        real(dp), dimension(n) :: x
        real(dp), dimension(n) :: w
        integer :: i
        real(dp) :: val
        real(dp) :: ans


        y = [(real(i-1, dp), i = 1, n)]

        x = y
        w = simps_weights(x)
        val = sum(w*y)
        ans = simps(y, x)
        call check(error, val, ans, thr=tol_dp)
    end subroutine test_simps_weights_dp


    subroutine test_simps_weights_qp(error)
        !> Error handling
        type(error_type), allocatable, intent(out) :: error

        integer, parameter :: n = 17
        real(qp), dimension(n) :: y
        real(qp), dimension(n) :: x
        real(qp), dimension(n) :: w
        integer :: i
        real(qp) :: val
        real(qp) :: ans


        y = [(real(i-1, qp), i = 1, n)]

        x = y
        w = simps_weights(x)
        val = sum(w*y)
        ans = simps(y, x)
        call check(error, val, ans, thr=tol_qp)
    end subroutine test_simps_weights_qp


    subroutine test_simps_zero_sp(error)
        !> Error handling
        type(error_type), allocatable, intent(out) :: error

        real(sp), dimension(0) :: a


        call check(error, abs(simps(a, 1.0_sp)) < epsilon(0.0_sp))
        if (allocated(error)) return
        call check(error, abs(simps([1.0_sp], 1.0_sp)) < epsilon(0.0_sp))
        if (allocated(error)) return
        call check(error, abs(simps(a, a)) < epsilon(0.0_sp))
        if (allocated(error)) return
        call check(error, abs(simps([1.0_sp], [1.0_sp])) < epsilon(0.0_sp))
    end subroutine test_simps_zero_sp


    subroutine test_simps_zero_dp(error)
        !> Error handling
        type(error_type), allocatable, intent(out) :: error

        real(dp), dimension(0) :: a


        call check(error, abs(simps(a, 1.0_dp)) < epsilon(0.0_dp))
        if (allocated(error)) return
        call check(error, abs(simps([1.0_dp], 1.0_dp)) < epsilon(0.0_dp))
        if (allocated(error)) return
        call check(error, abs(simps(a, a)) < epsilon(0.0_dp))
        if (allocated(error)) return
        call check(error, abs(simps([1.0_dp], [1.0_dp])) < epsilon(0.0_dp))
    end subroutine test_simps_zero_dp


    subroutine test_simps_zero_qp(error)
        !> Error handling
        type(error_type), allocatable, intent(out) :: error

        real(qp), dimension(0) :: a


        call check(error, abs(simps(a, 1.0_qp)) < epsilon(0.0_qp))
        if (allocated(error)) return
        call check(error, abs(simps([1.0_qp], 1.0_qp)) < epsilon(0.0_qp))
        if (allocated(error)) return
        call check(error, abs(simps(a, a)) < epsilon(0.0_qp))
        if (allocated(error)) return
        call check(error, abs(simps([1.0_qp], [1.0_qp])) < epsilon(0.0_qp))
    end subroutine test_simps_zero_qp


    subroutine test_simps_even_sp(error)
        !> Error handling
        type(error_type), allocatable, intent(out) :: error

        integer, parameter :: n = 11
        real(sp), dimension(n) :: y
        real(sp), dimension(n) :: x
        real(sp) :: val
        real(sp) :: ans
        integer :: i
        integer :: even


        y = [(3.0_sp*real(i-1, sp)**2, i = 1, n)]

        do even = -1, 1

            val = simps(y, 1.0_sp)
            ans = 1000.0_sp
            call check(error, val, ans, thr=tol_sp)
            if (allocated(error)) return

            val = simps(y, 0.5_sp)
            ans = 500.0_sp
            call check(error, val, ans, thr=tol_sp)
            if (allocated(error)) return

            x = [(0.25_sp*(i-1), i = 1, n)]
            val = simps(y, x)
            ans = 250.0_sp
            call check(error, val, ans, thr=tol_sp)
            if (allocated(error)) return
        end do
    end subroutine test_simps_even_sp


    subroutine test_simps_even_dp(error)
        !> Error handling
        type(error_type), allocatable, intent(out) :: error

        integer, parameter :: n = 11
        real(dp), dimension(n) :: y
        real(dp), dimension(n) :: x
        real(dp) :: val
        real(dp) :: ans
        integer :: i


        y = [(3.0_dp*real(i-1, dp)**2, i = 1, n)]

        val = simps(y, 1.0_dp)
        ans = 1000.0_dp
        call check(error, val, ans, thr=tol_dp)
        if (allocated(error)) return

        val = simps(y, 0.5_dp)
        ans = 500.0_dp
        call check(error, val, ans, thr=tol_dp)
        if (allocated(error)) return

        x = [(0.25_dp*(i-1), i = 1, n)]
        val = simps(y, x)
        ans = 250.0_dp
        call check(error, val, ans, thr=tol_dp)
    end subroutine test_simps_even_dp


    subroutine test_simps_even_qp(error)
        !> Error handling
        type(error_type), allocatable, intent(out) :: error

        integer, parameter :: n = 11
        real(qp), dimension(n) :: y
        real(qp), dimension(n) :: x
        real(qp) :: val
        real(qp) :: ans
        integer :: i
        integer :: even


        y = [(3.0_qp*real(i-1, qp)**2, i = 1, n)]

        do even = -1, 1

            val = simps(y, 1.0_qp)
            ans = 1000.0_qp
            call check(error, val, ans, thr=tol_qp)
            if (allocated(error)) return

            val = simps(y, 0.5_qp)
            ans = 500.0_qp
            call check(error, val, ans, thr=tol_qp)
            if (allocated(error)) return

            x = [(0.25_qp*(i-1), i = 1, n)]
            val = simps(y, x)
            ans = 250.0_qp
            call check(error, val, ans, thr=tol_qp)
            if (allocated(error)) return
        end do
    end subroutine test_simps_even_qp


    subroutine test_simps_weights_even_sp(error)
        !> Error handling
        type(error_type), allocatable, intent(out) :: error

        integer, parameter :: n = 16
        real(sp), dimension(n) :: y
        real(sp), dimension(n) :: x
        real(sp), dimension(n) :: w
        integer :: i
        real(sp) :: val
        real(sp) :: ans
        integer :: even


        y = [(real(i-1, sp), i = 1, n)]
        x = y

        do even = -1, 1
            w = simps_weights(x)
            val = sum(w*y)
            ans = simps(y, x)
            call check(error, val, ans, thr=tol_sp)
            if (allocated(error)) return
        end do
    end subroutine test_simps_weights_even_sp


    subroutine test_simps_weights_even_dp(error)
        !> Error handling
        type(error_type), allocatable, intent(out) :: error

        integer, parameter :: n = 16
        real(dp), dimension(n) :: y
        real(dp), dimension(n) :: x
        real(dp), dimension(n) :: w
        integer :: i
        real(dp) :: val
        real(dp) :: ans
        integer :: even


        y = [(real(i-1, dp), i = 1, n)]
        x = y

        do even = -1, 1
            w = simps_weights(x)
            val = sum(w*y)
            ans = simps(y, x)
            call check(error, val, ans, thr=tol_dp)
            if (allocated(error)) return
        end do
    end subroutine test_simps_weights_even_dp


    subroutine test_simps_weights_even_qp(error)
        !> Error handling
        type(error_type), allocatable, intent(out) :: error

        integer, parameter :: n = 16
        real(qp), dimension(n) :: y
        real(qp), dimension(n) :: x
        real(qp), dimension(n) :: w
        integer :: i
        real(qp) :: val
        real(qp) :: ans
        integer :: even


        y = [(real(i-1, qp), i = 1, n)]

        x = y

        do even = -1, 1
            w = simps_weights(x)
            val = sum(w*y)
            ans = simps(y, x)
            call check(error, val, ans, thr=tol_qp)
            if (allocated(error)) return
        end do
    end subroutine test_simps_weights_even_qp


    subroutine test_simps_six_sp(error)
        !> Error handling
        type(error_type), allocatable, intent(out) :: error

        integer, parameter :: n = 6
        real(sp), dimension(n) :: y
        real(sp), dimension(n) :: x
        real(sp) :: val
        real(sp) :: ans
        integer :: i
        integer :: even


        y = [(3.0_sp*real(i-1, sp)**2, i = 1, n)]

        do even = -1, 1

            val = simps(y, 1.0_sp)
            ans = 125.0_sp
            call check(error, val, ans, thr=tol_sp)
            if (allocated(error)) return

            val = simps(y, 0.5_sp)
            ans = 62.5_sp
            call check(error, val, ans, thr=tol_sp)
            if (allocated(error)) return

            x = [(0.25_sp*(i-1), i = 1, n)]
            val = simps(y, x)
            ans = 31.25_sp
            call check(error, val, ans, thr=tol_sp)
            if (allocated(error)) return
        end do
    end subroutine test_simps_six_sp


    subroutine test_simps_six_dp(error)
        !> Error handling
        type(error_type), allocatable, intent(out) :: error

        integer, parameter :: n = 6
        real(dp), dimension(n) :: y
        real(dp), dimension(n) :: x
        real(dp) :: val
        real(dp) :: ans
        integer :: i


        y = [(3.0_dp*real(i-1, dp)**2, i = 1, n)]

        val = simps(y, 1.0_dp)
        ans = 125.0_dp
        call check(error, val, ans, thr=tol_dp)
        if (allocated(error)) return

        val = simps(y, 0.5_dp)
        ans = 62.5_dp
        call check(error, val, ans, thr=tol_dp)
        if (allocated(error)) return

        x = [(0.25_dp*(i-1), i = 1, n)]
        val = simps(y, x)
        ans = 31.25_dp
        call check(error, val, ans, thr=tol_dp)
    end subroutine test_simps_six_dp


    subroutine test_simps_six_qp(error)
        !> Error handling
        type(error_type), allocatable, intent(out) :: error

        integer, parameter :: n = 6
        real(qp), dimension(n) :: y
        real(qp), dimension(n) :: x
        real(qp) :: val
        real(qp) :: ans
        integer :: i
        integer :: even


        y = [(3.0_qp*real(i-1, qp)**2, i = 1, n)]

        do even = -1, 1

            val = simps(y, 1.0_qp)
            ans = 125.0_qp
            call check(error, val, ans, thr=tol_qp)
            if (allocated(error)) return

            val = simps(y, 0.5_qp)
            ans = 62.5_qp
            call check(error, val, ans, thr=tol_qp)
            if (allocated(error)) return

            x = [(0.25_qp*(i-1), i = 1, n)]
            val = simps(y, x)
            ans = 31.25_qp
            call check(error, val, ans, thr=tol_qp)
            if (allocated(error)) return
        end do
    end subroutine test_simps_six_qp

end module


program tester
    use, intrinsic :: iso_fortran_env, only : error_unit
    use testdrive, only : run_testsuite, new_testsuite, testsuite_type
    use test_simps, only : collect_simps
    implicit none
    integer :: stat, is
    type(testsuite_type), allocatable :: testsuites(:)
    character(len=*), parameter :: fmt = '("#", *(1x, a))'

    stat = 0

    testsuites = [ &
        new_testsuite("simps", collect_simps) &
        ]

    do is = 1, size(testsuites)
        write(error_unit, fmt) "Testing:", testsuites(is)%name
        call run_testsuite(testsuites(is)%collect, error_unit, stat)
    end do

    if (stat > 0) then
        write(error_unit, '(i0, 1x, a)') stat, "test(s) failed!"
        error stop
    end if
end program
