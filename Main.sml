local open BasicIO
           Nonstdio in
  fun fatal s =
  (
    output(std_err, s ^ "\n");
    exit 1
  )
  fun createLexerStream (is : instream) =
    Lexing.createLexer
    (fn buff => fn n => Nonstdio.buff_input is buff 0 n)
  fun parsePhrase parsingFun lexingFun lexbuf =
    parsingFun lexingFun lexbuf
    handle
      Parsing.ParseError _ =>
        let
          val pos1 = Lexing.getLexemeStart lexbuf
          val pos2 = Lexing.getLexemeEnd lexbuf
        in
          fatal ("Syntax error [" ^
                (Int.toString pos1) ^ ", " ^
                (Int.toString pos2) ^ "]")
        end
    | Lexer.LexicalError (str, num1, num2) =>
      fatal ("Lexer error [" ^
             (Int.toString num1) ^ ", " ^
             (Int.toString num2) ^ "]: " ^
             str)
  ;
  fun parseMain parsingFun lexingFun lexbuf = 
    let
      val mainPhrase = parsePhrase parsingFun lexingFun lexbuf
        handle x => (Parsing.clearParser(); raise x)
    in
      Parsing.clearParser();
      mainPhrase
    end
  ;
  fun main () =
  let
    val argv = Mosml.argv ()
    val is = (case argv of
                 [_] => std_in
               | [_, name] => (open_in name
                               handle (SysErr _) =>
                                 fatal ("Failed to open " ^ name))
               | arg0::_ => fatal ("Usage: " ^ arg0 ^ " [file]")
             )
    val lexbuf = createLexerStream is
    val formatAction = parseMain Parser.program Lexer.Token lexbuf
    val action = Format.create();
  in
    formatAction action
  end
  val _ = main ()
end
