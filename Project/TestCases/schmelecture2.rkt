#lang racket

; remove the first occurrence of an atom in a list of atoms
(define myremove
  (lambda (x lis)
    (cond
      [(null? lis) '()]
      [(eq? x (car lis)) (cdr lis)]
      [else (cons (car lis) (myremove x (cdr lis)))])))

; remove all occurrences of an atom in a list of atoms
(define myremoveall
  (lambda (x lis)
    (cond
      [(null? lis) '()]
      [(eq? x (car lis)) (myremoveall x (cdr lis))]
      [else (cons (car lis) (myremoveall x (cdr lis)))])))

; append two lists of atoms into a single list containing all atoms of 1st list followed by 2nd list
(define myappend
  (lambda (lis1 lis2)
    (if (null? lis1)
        lis2
        (cons (car lis1) (myappend (cdr lis1) lis2)))))

; (repeat 5 'a)  => '(a a a a a)
(define repeat
  (lambda (n a)
    (if (zero? n)
        '()
        (cons a (repeat (- n 1) a)))))

; (squares '(1 4 6))  => '(1 16 36)
(define squares
  (lambda (lis)
    (if (null? lis)
        '()
        (cons (* (car lis) (car lis)) (squares (cdr lis))))))

; (myreplace 'x 'y '(a b x c d x e))   => '(a b y c d x e)
; (myreplaceall 'x 'y '(a b x c d x e)) => '(a b y c d y e)

