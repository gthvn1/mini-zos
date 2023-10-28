(module
  ;; F0 = 0
  ;; F1 = 1
  ;; F(N) = F(N-1) + F(N-2)
  (func $fibo (export "fibo") (param $n i64) (result i64)
    (local $i i64) ;; index used in the loop
    (local $fn1 i64) ;; used to store F(N-1)
    (local $fn2 i64) ;; used to store F(N-2)
    (local $tmp i64) ;; used it the loop to save value

    ;; f(0) = 0 and f(1) = 1
    (if (i64.le_s (i64.const 1 (local.get $n)))
      (then (return (local.get $n))))

    ;; Initialiaze local variables
    (local.set $i   (i64.const 1)) ;; start loop at 1
    (local.set $fn1 (i64.const 1)) ;; F(N-1) = F(1)
    (local.set $fn2 (i64.const 0)) ;; F(N-2) = F(0)

    (loop $start_loop
      (local.set $tmp (local.get $fn2))
      (local.set $fn2 (local.get $fn1))
      (local.set $fn1 (i64.add (local.get $tmp (local.get $fn1))))

      ;; update the index
      (local.set $i (i64.add (i64.const 1 (local.get $i))))

      ;; we loop until index
      (br_if $start_loop
        (i64.ne (local.get $n) (local.get $i)))
    )

    local.get $fn1
  )
)
