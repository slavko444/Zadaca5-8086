S_SEG SEGMENT
DW 20 DUP(?) 
S_TOP LABEL WORD 
S_SEG ENDS
D_SEG SEGMENT
 ARRAY_1 DB 10 DUP(?)
 ARRAY_2 DB 5 DUP(?)
D_SEG ENDS
PROC_SEG SEGMENT 
ASSUME CS:PROC_SEG, DS:D_SEG & SS:S_SEG
EXAMPLE PROC FAR
PUSH BP
MOV BP,SP 
PUSH CX 
PUSH BX 
PUSHF 
MOV CX,[BP+8] 
MOV BX,[BP+6]
 POP F 
POP BX
 POP CX
 POP BP
RET 4 
EXAMPLE ENDP
 PROC_SEG ENDS
CALLER_SEG SEGMENT
 ASSUME CS:CALLER_SEG, DS:D_SEG & SS:S_SEG
 MOV AX,D_SEG
 MOV DS,AX
 MOV AX,S_SEG
 MOV SS,AX
 MOV SP,OFFSET S_TOP

 MOV AX,LENGTH ARRAY_1
 PUSH AX
 MOV AX,OFFSET ARRAY_1
 PUSH AX
 CALL EXAMPLE 
 MOV AX, LENGTH ARRAY_2
 PUSH AX
 MOV AX, OFFSET ARRAY_2
 PUSH AX
 CALL EXAMPLE 
 CALLER_SEG ENDS
 END 