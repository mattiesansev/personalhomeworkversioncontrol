;; --------------QUESTION 1 ----------;;

;;PAD FUNCTION
;;returns the Nth padovan number

(defun PAD(N)
  (if (< N 3)
      1
      (+ (PAD (- N 3)) (PAD( - N 2)))
      )
  )

;; ---------------- QUESTION 2 --------------- ;;

;;SUMS FUNCTION
;; returns the number of additions that are required to find the padovan at index N

(defun SUMS(N)
  (if (< N 3)
      0
      (+ 1 (SUMS (- N 3)) (SUMS( - N 2)))
      )
  )

;; ----------------- QUESTION 3 -------------- ;;

;;ANON FUNCTION
;;returns the TREE with all values replaced with ? --> anonymised : )
(defun ANON(TREE)
  ;;if current item is NULL ((found syntax on Piazza))
  (cond ((not TREE)
	 '()) ;;return an empty paran
	;;if current item is an atom
	 ((atom TREE) 
	 '?) ;;then do just one ?
	 ;;else we want to combine the anonymised first part with the rest of it
	(t (cons (ANON(car TREE)) (ANON(cdr TREE))))))


