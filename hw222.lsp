;; ------------------- QUESTION 1 ------------------ ;;

;;BFS Function
;;returns the top-level list of leaf nodes

(defun BFS(FRINGE)
  (cond ((atom FRINGE) ;;if it is an atom
	 ;;print it
	 FRINGE)
	 ;;if the first value is an atom
	((atom (car FRINGE))
	 ;;print it with second part concatenated!
	 (cons (car FRINGE) (BFS (cdr FRINGE))))
	;;else if cdr is null and car is not null
	((not (cdr FRINGE))
	 ;;run BFS on car!
	 (BFS (car FRINGE)))
	;;else if the second value is an atom
	;;cdr will never return an atom, so we check if cdr of cdr is NIL
	((not (cdr (cdr FRINGE)))
	 ;;print it with first part concatenated!
	 (cons (car (cdr FRINGE)) (BFS(car FRINGE))))
	;;else it is not NIL and we need to split it again
	(FRINGE
	 (cons (BFS(car FRINGE)) (BFS (cdr FRINGE))))
	;;else it must be NIL, do nothing
	))

(print (car (car '(((A (B)) C (D))))))
(print (atom (cdr (car '((((L E) F) T))))))
(print (BFS '(ROOT)))
(print (BFS '(A (B C))))
(print (cdr '((((L E) F) T))))
(print (cdr (car '((((L E) F) T)))))
(print (BFS '((((L E) F) T))))
;;(print( car '((R (I (G (H T)))))))
(print( BFS '((R (I (G (H T)))))))
(print (BFS '(((A (B)) C (D)))))
(print (BFS '((T (H R E) E))))
(print (BFS '((A ((C ((E) D)) B)))))

;;;;;;;;;;;;;;                                                                                            
; Homework 2 ;                                                                                            
;;;;;;;;;;;;;;                                                                                            

;;;;;;;;;;;;;;                                                                                            
; Question 1 ;                                                                                            
;;;;;;;;;;;;;;                                                                                            

; TODO: comment code                                                                                      

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
    ...)

					;NEXT-STATE returns the state that results from applying an operator to the
