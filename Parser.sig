local
in
datatype token =
    AMP
  | ASSIGN
  | BAR
  | BREAK
  | CARET
  | COMMA
  | CONTINUE
  | Constant of int
  | DE
  | DIVIDE
  | ELSE
  | EOF
  | EQ
  | GE
  | GT
  | IF
  | INT
  | Identifier of string
  | LBRACE
  | LE
  | LPAREN
  | LT
  | ME
  | MINUS
  | MM
  | NE
  | PE
  | PLUS
  | PP
  | RBRACE
  | RE
  | REM
  | RETURN
  | RPAREN
  | SEMI
  | TE
  | TIMES
  | WHILE
end;

val program :
  (Lexing.lexbuf -> token) -> Lexing.lexbuf -> Format.action;
