local open Obj Lexing in


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

fun action_33 lexbuf = (

      lexerError
      lexbuf
      ("Illegal token \"" ^
       (getLexeme lexbuf) ^
       "\" in input")
    )
and action_32 lexbuf = (
 EOF )
and action_31 lexbuf = (

      Token lexbuf
    )
and action_30 lexbuf = (

      let
        val str = getLexeme lexbuf
      in
        case Int.fromString str of
            NONE => lexerError
                    lexbuf
                    ("Failed to convert string \"" ^ str ^ "\" to integer")
          | SOME i => Constant i
      end
    )
and action_29 lexbuf = (

      mkKeyword lexbuf
    )
and action_28 lexbuf = (
 COMMA )
and action_27 lexbuf = (
 MM )
and action_26 lexbuf = (
 PP )
and action_25 lexbuf = (
 RE )
and action_24 lexbuf = (
 DE )
and action_23 lexbuf = (
 TE )
and action_22 lexbuf = (
 ME )
and action_21 lexbuf = (
 PE )
and action_20 lexbuf = (
 ASSIGN )
and action_19 lexbuf = (
 BAR )
and action_18 lexbuf = (
 CARET )
and action_17 lexbuf = (
 AMP )
and action_16 lexbuf = (
 NE )
and action_15 lexbuf = (
 EQ )
and action_14 lexbuf = (
 LE )
and action_13 lexbuf = (
 GE )
and action_12 lexbuf = (
 LT )
and action_11 lexbuf = (
 GT )
and action_10 lexbuf = (
 REM )
and action_9 lexbuf = (
 DIVIDE )
and action_8 lexbuf = (
 TIMES )
and action_7 lexbuf = (
 MINUS )
and action_6 lexbuf = (
 PLUS )
and action_5 lexbuf = (
 RBRACE )
and action_4 lexbuf = (
 LBRACE )
and action_3 lexbuf = (
 RPAREN )
and action_2 lexbuf = (
 LPAREN )
and action_1 lexbuf = (
 SEMI )
and action_0 lexbuf = (

      Token lexbuf
    )
and state_0 lexbuf = (
 let val currChar = getNextChar lexbuf in
 if currChar >= #"A" andalso currChar <= #"Z" then  state_20 lexbuf
 else if currChar >= #"a" andalso currChar <= #"z" then  state_20 lexbuf
 else if currChar >= #"0" andalso currChar <= #"9" then  state_15 lexbuf
 else case currChar of
    #"_" => state_20 lexbuf
 |  #"\t" => state_3 lexbuf
 |  #" " => state_3 lexbuf
 |  #"}" => action_5 lexbuf
 |  #"|" => action_19 lexbuf
 |  #"{" => action_4 lexbuf
 |  #"^" => action_18 lexbuf
 |  #">" => state_19 lexbuf
 |  #"=" => state_18 lexbuf
 |  #"<" => state_17 lexbuf
 |  #";" => action_1 lexbuf
 |  #"/" => state_14 lexbuf
 |  #"-" => state_13 lexbuf
 |  #"," => action_28 lexbuf
 |  #"+" => state_11 lexbuf
 |  #"*" => state_10 lexbuf
 |  #")" => action_3 lexbuf
 |  #"(" => action_2 lexbuf
 |  #"&" => action_17 lexbuf
 |  #"%" => state_6 lexbuf
 |  #"!" => state_5 lexbuf
 |  #"\n" => state_4 lexbuf
 |  #"\^@" => action_32 lexbuf
 |  _ => action_33 lexbuf
 end)
and state_3 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_31);
 let val currChar = getNextChar lexbuf in
 case currChar of
    #"\n" => state_38 lexbuf
 |  #"\t" => state_38 lexbuf
 |  #" " => state_38 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_4 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_31);
 let val currChar = getNextChar lexbuf in
 case currChar of
    #"\n" => state_38 lexbuf
 |  #"\t" => state_38 lexbuf
 |  #" " => state_38 lexbuf
 |  #"#" => state_39 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_5 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_33);
 let val currChar = getNextChar lexbuf in
 case currChar of
    #"=" => action_16 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_6 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_10);
 let val currChar = getNextChar lexbuf in
 case currChar of
    #"=" => action_25 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_10 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_8);
 let val currChar = getNextChar lexbuf in
 case currChar of
    #"=" => action_23 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_11 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_6);
 let val currChar = getNextChar lexbuf in
 case currChar of
    #"=" => action_21 lexbuf
 |  #"+" => action_26 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_13 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_7);
 let val currChar = getNextChar lexbuf in
 case currChar of
    #"=" => action_22 lexbuf
 |  #"-" => action_27 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_14 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_9);
 let val currChar = getNextChar lexbuf in
 case currChar of
    #"=" => action_24 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_15 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_30);
 let val currChar = getNextChar lexbuf in
 if currChar >= #"0" andalso currChar <= #"9" then  state_29 lexbuf
 else backtrack lexbuf
 end)
and state_17 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_12);
 let val currChar = getNextChar lexbuf in
 case currChar of
    #"=" => action_14 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_18 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_20);
 let val currChar = getNextChar lexbuf in
 case currChar of
    #"=" => action_15 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_19 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_11);
 let val currChar = getNextChar lexbuf in
 case currChar of
    #"=" => action_13 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_20 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_29);
 let val currChar = getNextChar lexbuf in
 if currChar >= #"0" andalso currChar <= #"9" then  state_25 lexbuf
 else if currChar >= #"A" andalso currChar <= #"Z" then  state_25 lexbuf
 else if currChar >= #"a" andalso currChar <= #"z" then  state_25 lexbuf
 else case currChar of
    #"_" => state_25 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_25 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_29);
 let val currChar = getNextChar lexbuf in
 if currChar >= #"0" andalso currChar <= #"9" then  state_25 lexbuf
 else if currChar >= #"A" andalso currChar <= #"Z" then  state_25 lexbuf
 else if currChar >= #"a" andalso currChar <= #"z" then  state_25 lexbuf
 else case currChar of
    #"_" => state_25 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_29 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_30);
 let val currChar = getNextChar lexbuf in
 if currChar >= #"0" andalso currChar <= #"9" then  state_29 lexbuf
 else backtrack lexbuf
 end)
and state_38 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_31);
 let val currChar = getNextChar lexbuf in
 case currChar of
    #"\n" => state_38 lexbuf
 |  #"\t" => state_38 lexbuf
 |  #" " => state_38 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_39 lexbuf = (
 let val currChar = getNextChar lexbuf in
 if currChar >= #"0" andalso currChar <= #"9" then  state_40 lexbuf
 else backtrack lexbuf
 end)
and state_40 lexbuf = (
 let val currChar = getNextChar lexbuf in
 if currChar >= #"0" andalso currChar <= #"9" then  state_40 lexbuf
 else case currChar of
    #"\t" => state_41 lexbuf
 |  #" " => state_41 lexbuf
 |  #"\n" => action_0 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_41 lexbuf = (
 let val currChar = getNextChar lexbuf in
 case currChar of
    #"\t" => state_41 lexbuf
 |  #" " => state_41 lexbuf
 |  #"\n" => state_44 lexbuf
 |  #"\^@" => backtrack lexbuf
 |  _ => state_43 lexbuf
 end)
and state_43 lexbuf = (
 let val currChar = getNextChar lexbuf in
 case currChar of
    #"\n" => state_44 lexbuf
 |  #"\^@" => backtrack lexbuf
 |  _ => state_43 lexbuf
 end)
and state_44 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_0);
 let val currChar = getNextChar lexbuf in
 case currChar of
    #"\n" => state_44 lexbuf
 |  #"\^@" => backtrack lexbuf
 |  _ => state_43 lexbuf
 end)
and Token lexbuf =
  (setLexLastAction lexbuf (magic dummyAction);
   setLexStartPos lexbuf (getLexCurrPos lexbuf);
   state_0 lexbuf)

(* The following checks type consistency of actions *)
val _ = fn _ => [action_33, action_32, action_31, action_30, action_29, action_28, action_27, action_26, action_25, action_24, action_23, action_22, action_21, action_20, action_19, action_18, action_17, action_16, action_15, action_14, action_13, action_12, action_11, action_10, action_9, action_8, action_7, action_6, action_5, action_4, action_3, action_2, action_1, action_0];

end
