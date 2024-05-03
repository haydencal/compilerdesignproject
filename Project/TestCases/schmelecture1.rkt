#lang racket

; doubles the input
(define times2
  (lambda (x)
    (* x 2)))

; factorial
(define factorial
  (lambda (x)
    (if (zero? x)
        1 
        (* x (factorial (- x 1))))))

; pow takes 2 (non-neg) numbers x and y and outputs x^y
(define pow
  (lambda (x y)
    (if (zero? y)
        1
        (* x (pow x (- y 1))))))

; gcd takes 2 (non-neg) numbers x and y and returns their greatest common divisor
; gcd(a, b) = gcd(b, a remainder b)
(define gcd
  (lambda (a b)
    (if (zero? b)
        a
        (gcd b (remainder a b)))))

; mylength returns the length of a list
(define mylength
  (lambda (lis)
    (if (null? lis)
        0
        (+ 1 (mylength (cdr lis))))))

; determine if an atom is in a list of atoms
(define member?
  (lambda (x lis)
;    (if (null? lis)
;        #f
;        (if (eq? x (car lis))
;            #t
;            (member? x (cdr lis))))))
    (cond
      [(null? lis)       #f]
      [(eq? x (car lis)) #t]
      [else              (member? x (cdr lis))])))

; numoccurring takes an atom and a list and returns the number of times the
; atom appears in the list
(define numoccuring
  (lambda (x lis)
    (cond
      [(null? lis)    0]
      [(eq? x (car lis)) (+ 1 (numoccuring x (cdr lis)))]
      [else (numoccuring x (cdr lis))])))