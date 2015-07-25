local open BasicIO in
  type info =
    int *                                 (* left margin, in tabs *)
    bool *                                (* are we at left margin? *)
    int *                                 (* managed by cond *)
    int                                   (* managed by uncond *)
               
  datatype margin = IN                    (* inward *)
    | EX                                  (* outward *)
    | AT                                  (* as is *)


  type action = info -> info
  fun create () = (0, true, 0, 0)
  fun unitAction i = i
  fun at AT i = i
    | at IN (lmargin, atmargin, condflag, uncdflag) =
      (lmargin+1, atmargin, condflag, uncdflag)
    | at EX (lmargin, atmargin, condflag, uncdflag) =
      (lmargin-1, atmargin, condflag, uncdflag)
  and cond IN (lmargin, atmargin, condflag, uncdflag) =
    nl IN (lmargin, atmargin, condflag + 1, uncdflag)
    | cond EX (i as (_, _, 0, _)) = i
    | cond EX (i as (lmargin, atmargin, _, uncdflag)) =
    let
      val (lmargin', atmargin', condflag', uncdflag') = at EX i
    in
      (lmargin', atmargin', 0, uncdflag')
    end
  and uncond AT (lmargin, atmargin, condflag, uncdflag) =
    nl AT (lmargin, atmargin, condflag, uncdflag + 1)
    | uncond EX (i as (_, _, _, 0)) = at EX i
    | uncond EX i = i
  and nl delta (i as (lmargin, atmargin, condflag, uncdflag)) =
    let
      val (lmargin', _, condflag', uncdflag') = at delta i
    in
      output(std_out, "\n");
      (lmargin', true, condflag', uncdflag')
    end
  and out s (i as (lmargin, atmargin, _, _)) =
    (
     if atmargin then
       let
         fun rep 0 = ()
           | rep n = (output(std_out, "\t"); rep (n-1))
       in
         rep lmargin
       end
     else
       ();
     output(std_out, s);
     (lmargin, false, 0, 0)
     )
end
