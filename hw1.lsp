;; --------------QUESTION 1 ----------;;

(defun PAD(N)
  (if (< N 3)
      1
      (+ (PAD (- N 3)) (PAD( - N 2)))
      )
  )

;;TESTING

(print (PAD 0))
(print (PAD 1))
(print (PAD 2))
(print (PAD 3))
(print (PAD 4))
(print (PAD 5))
(print (PAD 6))
(print (PAD 7))
(print(PAD 8))
(print (PAD 9))
(print (PAD 10))
;;(print (PAD 1000))


;; ---------------- QUESTION 2 --------------- ;;

;;SUMS FUNCTION

(defun SUMS(N)
  (if (< N 3)
      0
      (+ 1 (SUMS (- N 3)) (SUMS( - N 2)))
      )
  )

;;TESTING

(print (SUMS 0))
(print (SUMS 1))
(print (SUMS 2))
(print (SUMS 3))
(print (SUMS 4))
(print (SUMS 5))
(print (SUMS 6))
(print (SUMS 7))
(print (SUMS 8))
(print (SUMS 9))
(print (SUMS 10))


;; ----------------- QUESTION 3 -------------- ;;

(defun ANON(TREE)
  (print(cdr TREE))
  (print(car TREE))
  ;;if current item is an atom
  (if (atom TREE)
      ;;we can have one ?
      '?
  ;;else let's evaluate cdr and car
  ;;if there's only one element
  (if (equal (cdr TREE) NIL)
      '?
      ;;else we want to slowly separate
      (cons '? (cons (ANON(cdr TREE)) '()))
      ))
  )

(print (ANON '7))
(print (ANON '(7)))
(print (ANON '(7 8)))
(print (ANON '(((L E) F) T)))
;;(print (cons 1 '(2)))
