{
open Parser;
exception LexicalError of string * int * int;

fun lexerError lexbuf s = 
  raise LexicalError (s, getLexemeStart lexbuf, getLexemeEnd lexbuf)
;
val keyword_table = (Hasht.new 7 : (string,token) Hasht.t);

val () =
List.app (fn (str,tok) => Hasht.insert keyword_table str tok)
[
  ("break", BREAK),
  ("continue", CONTINUE),
  ("else", ELSE),
  ("if", IF),
  ("int", INT),
  ("return", RETURN),
  ("while", WHILE)
];

fun mkKeyword lexbuf =
  let val s = getLexeme lexbuf in
    Hasht.find keyword_table s
    handle Subscript => Identifier s
  end
;
}
rule Token = parse
    `\n` "#" [`0`-`9`]+ ([` ` `\t`]+ _* )? `\n`
    {
      Token lexbuf
    }
  | ";" { SEMI }
    | "(" { LPAREN }
    | ")" { RPAREN }
    | "{" { LBRACE }
    | "}" { RBRACE }
    | "+" { PLUS }
    | "-" { MINUS }
    | "*" { TIMES }
    | "/" { DIVIDE }
    | "%" { REM }
    | ">" { GT }
    | "<" { LT }
    | ">=" { GE }
    | "<=" { LE }
    | "==" { EQ }
    | "!=" { NE }
    | "&" { AMP }
    | "^" { CARET }
    | "|" { BAR }
    | "=" { ASSIGN }
    | "+=" { PE }
    | "-=" { ME }
    | "*=" { TE }
    | "/=" { DE }
    | "%=" { RE }
    | "++" { PP }
    | "--" { MM }
    | "," { COMMA }
  | [`A`-`Z` `a`-`z` `_`] [`A`-`Z` `a`-`z` `_` `0`-`9`]*
    {
      mkKeyword lexbuf
    }
  | [`0`-`9`]+
    {
      let
        val str = getLexeme lexbuf
      in
        case Int.fromString str of
            NONE => lexerError
                    lexbuf
                    ("Failed to convert string \"" ^ str ^ "\" to integer")
          | SOME i => Constant i
      end
    }
  | [` ` `\t` `\n`]+
    {
      Token lexbuf
    }
  | (eof) { EOF }
  | _
    {
      lexerError
      lexbuf
      ("Illegal token \"" ^
       (getLexeme lexbuf) ^
       "\" in input")
    }
;
