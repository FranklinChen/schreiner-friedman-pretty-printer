exception LexicalError of string * int * int;
val Token : Lexing.lexbuf -> Parser.token;
