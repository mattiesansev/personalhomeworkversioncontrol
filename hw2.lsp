;;;;;;;;;;;;;;
; Homework 2 ;
;;;;;;;;;;;;;;

;;;;;;;;;;;;;;
; Question 1 ;
;;;;;;;;;;;;;;

; TODO: comment code
(defun BFS(FRINGE)
  (cond ((not FRINGE) ;;if it's nil
	 nil)
	;;if car is a list
	((listp (car FRINGE))
	 ;;we want it backwards
	 (append (BFS (cdr FRINGE)) (BFS (car FRINGE))))
	(t (cons (car FRINGE) (BFS (cdr FRINGE))))
        ))

(print (BFS '(ROOT)))
(print (BFS '((((L E) F) T))))
(print (BFS '((R (I (G (H T)))))))
(print  (BFS '(((A (B)) C (D)))))
(print  (BFS '((T (H R E) E))))
(print  (BFS '((A ((C ((E) D)) B)))))

;;;;;;;;;;;;;;
; Question 2 ;
;;;;;;;;;;;;;;


; These functions implement a depth-first solver for the homer-baby-dog-poison
; problem. In this implementation, a state is represented by a single list
; (homer baby dog poison), where each variable is T if the respective entity is
; on the west side of the river, and NIL if it is on the east side.
; Thus, the initial state for this problem is (NIL NIL NIL NIL) (everybody 
; is on the east side) and the goal state is (T T T T).

; The main entry point for this solver is the function DFS, which is called
; with (a) the state to search from and (b) the path to this state. It returns
; the complete path from the initial state to the goal state: this path is a
; list of intermediate problem states. The first element of the path is the
; initial state and the last element is the goal state. Each intermediate state
; is the state that results from applying the appropriate operator to the
; preceding state. If there is no solution, DFS returns NIL.
; To call DFS to solve the original problem, one would call 
; (DFS '(NIL NIL NIL NIL) NIL) 
; However, it should be possible to call DFS with a different initial
; state or with an initial path.

; First, we define the helper functions of DFS.

; FINAL-STATE takes a single argument S, the current state, and returns T if it
; is the goal state (T T T T) and NIL otherwise.
(defun FINAL-STATE (S)
    (equal S '(T T T T))
  )

(print (FINAL-STATE '(NIL F T T)))
(print (FINAL-STATE '(T T T T)))
; NEXT-STATE returns the state that results from applying an operator to the
; current state. It takes three arguments: the current state (S), and which entity
; to move (A, equal to h for homer only, b for homer with baby, d for homer 
; with dog, and p for homer with poison). 
; It returns a list containing the state that results from that move.
; If applying this operator results in an invalid state (because the dog and baby,
; or poisoin and baby are left unsupervised on one side of the river), or when the
; action is impossible (homer is not on the same side as the entity) it returns NIL.
; NOTE that next-state returns a list containing the successor state (which is
; itself a list); the return should look something like ((NIL NIL T T)).
(defun NEXT-STATE (S A)
  (cond ((equal A 'h)
	 ;;this is okay if baby is on the other side, or hazards are
	 (if (or (equal (second S) (third S)) (equal (second S) (fourth S)))
	     ;;if the baby would be in danger
	     NIL
	     ;;else we update the list
	     (list (cons (not (first S)) (cdr S)))))
	((equal A 'b)
	 ;;this is okay if baby and h are on same side
	 (if (equal (first S) (second S))
	     ;;update the list
	     ( list(append (cons (not (first S)) (cons (not (second S)) nil)) (cdr (cdr S))))
	     NIL)
	 )
	((equal A 'd)
	 ;;this is okay if we're not leaving the baby alone with the poisen
	 (if (or (equal (second S) (fourth S)) (not (equal (first S) (third S))))
	     NIL
	     (list (append (append (cons (not (first S)) (list (second S))) (list (not (third S)))) (list (fourth S))))
	     ))
	((equal A 'p)
	 ;;this is ookay if we're not leaving the baby alone with the dog
	 (if (or (equal (second S) (third S)) (not (equal (first S) (fourth S))))
	     NIL
	     (list (append (append (append (list (not (first S))) (list (second S))) (list (third S))) (list (not (fourth S)))))

	))))

(print "HIII")
(print (NEXT-STATE '(T T T T) 'h))
(print (NEXT-STATE '(T T NIL NIL) 'h))
(print (NEXT-STATE '(T NIL T T) 'b))
(print (NEXT-STATE '(NIL NIL NIL T) 'b))
(print "testing d")
(print (NEXT-STATE '(NIL T NIL NIL) 'd))
(print (NEXT-STATE '(T NIL T NIL) 'd))
(print "testing p")
(print (NEXT-STATE '(NIL NIL NIL NIL) 'p))
(print (NEXT-STATE '(NIL T NIL NIL) 'p))
;SUCC-FN returns all of the possible legal successor states to the current
; state. It takes a single argument (s), which encodes the current state, and
; returns a list of each state that can be reached by applying legal operators
; to the current state.
(defun SUCC-FN (S)
  ;;(append (append (append (cons (NEXT-STATE S 'h) '()) (cons (NEXT-STATE S 'b) '())) (cons (NEXT-STATE S 'd) '())) (cons (NEXT-STATE S 'p) '())))
  (append (NEXT-STATE S 'h) (NEXT-STATE S 'b) (NEXT-STATE S 'd) (NEXT-STATE S 'p))
  )
  ;;(print (NEXT-STATE S 'h))
  ;(print (NEXT-STATE S 'b))
  ;(print (NEXT-STATE S 'd))
  ;(print (NEXT-STATE S 'p)))
  

(print "testing sccfn")
(print "testing n n n n")
(print (SUCC-FN '(NIL NIL NIL NIL)))
(print "testing N t N N ")
(print (SUCC-FN '(NIL T NIL NIL)))
(print "testsing N N T T")
(print (SUCC-FN '(NIL NIL T T)))
(print "testing T T T N")
(print (SUCC-FN '(T T T NIL)))
; ON-PATH checks whether the current state is on the stack of states visited by
; this depth-first search. It takes two arguments: the current state (S) and the
; stack of states visited by DFS (STATES). It returns T if s is a member of
; states and NIL otherwise.
(defun ON-PATH (S STATES)
  ;;separate the top of STATES and check if it's same as S
  ;;if states is null, we didn't find it
  (cond ((not STATES)
	 NIL)
	;;else we check if the top is the same
	((equal (car STATES) S)
	 T)
	;;else we want to try on the rest of the stack
	(t (ON-PATH S (cdr STATES)))))

(print "testing on path")
(print (ON-PATH '(T NIL NIL T) '((NIL NIL NIL NIL) (T T T NIL) (T NIL NIL T))))
(print (ON-PATH '(T T NIL T) '((NIL NIL NIL NIL) (T T T NIL) (T NIL NIL T))))

; MULT-DFS is a helper function for DFS. It takes two arguments: a list of
; states from the initial state to the current state (PATH), and the legal
; successor states to the last, current state in the PATH (STATES). PATH is a
; first-in first-out list of states; that is, the first element is the initial
; state for the current search and the last element is the most recent state
; explored. MULT-DFS does a depth-first search on each element of STATES in
; turn. If any of those searches reaches the final state, MULT-DFS returns the
; complete path from the initial state to the goal state. Otherwise, it returns
; NIL.
(defun MULT-DFS (STATES PATH)
    )

; DFS does a depth first search from a given state to the goal state. It
; takes two arguments: a state (S) and the path from the initial state to S
; (PATH). If S is the initial state in our search, PATH is set to NIL. DFS
; performs a depth-first search starting at the given state. It returns the path
; from the initial state to the goal state, if any, or NIL otherwise. DFS is
; responsible for checking if S is already the goal state, as well as for
; ensuring that the depth-first search does not revisit a node already on the
; search path.
(defun DFS (S PATH)
    ...)
    
