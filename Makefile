# Makefile for schreiner_sml project.
# Franklin Chen

include Makefile.mosml
include Makefile.noweb

MOSMLYFLAGS = -v

SRC = \
	Lexer.nw \
	Parser.nw \
	Hasht.sml Hasht.sig \
	Main.nw

# Hasht is stolen from mosml compiler source.
SML_SRC = \
	Lexer.sml Lexer.sig \
	Parser.sml Parser.sig \
	Hasht.sml Hasht.sig \
	Main.sml

SML_OBJS = \
	Hasht.uo \
	Parser.uo \
	Lexer.uo \
	Main.uo

# Moscow ML standard library objects needed.
LIBOBJS = \
	Int.uo \
	Word.uo \
	Word8.uo \
	Word8Vector.uo \
	Word8Array.uo \
	CharVector.uo \
	CharArray.uo \
	Obj.uo \
	Lexing.uo \
	Parsing.uo \
	Nonstdio.uo

.PHONY: all doc install depend clean

all: recog doc

recog: $(SML_OBJS)
	$(MOSMLLD) $(MOSMLLDFLAGS) -o $@ $(LIBOBJS) $(SML_OBJS)

doc: Lexer.dvi Parser.dvi Main.dvi

install:

# FMC need add stuff.
clean:
	rm -f *.ui *.uo Makefile.bak *~ *.aux *.tex *.dvi *.log *.html

depend: $(SML_SRC)
	rm -f Makefile.bak
	mv Makefile Makefile.bak
	$(MOSMLCUT) < Makefile.bak > Makefile
	$(MOSMLDEP) >> Makefile

Lexer.sig: Lexer.nw
	$(NOTANGLE) -R"[[$@]]" $< $(CPIF) $@
Lexer.lex: Lexer.nw
	$(NOTANGLE) $< $(CPIF) $@
Lexer.ltx: Lexer.nw
# Until we get icon
#	$(NOWEAVE) -index -autodefs sml $< $(CPIF) $@
	$(NOWEAVE) -index $< $(CPIF) $@
Lexer.html: Lexer.nw
	$(NOWEAVE) -filter l2h -index -autodefs sml -html $< $(CPIF) $@

Parser.grm: Parser.nw
	$(NOTANGLE) $< $(CPIF) $@
Parser.ltx: Parser.nw
# Until we get icon
#	$(NOWEAVE) -index -autodefs sml $< $(CPIF) $@
	$(NOWEAVE) -index $< $(CPIF) $@
Parser.html: Parser.nw
	$(NOWEAVE) -filter l2h -index -autodefs sml -html $< $(CPIF) $@

Main.sml: Main.nw
	$(NOTANGLE) $< $(CPIF) $@
Main.ltx: Main.nw
# Until we get icon
#	$(NOWEAVE) -index -autodefs sml $< $(CPIF) $@
	$(NOWEAVE) -index $< $(CPIF) $@
Main.html: Main.nw
	$(NOWEAVE) -filter l2h -index -autodefs sml -html $< $(CPIF) $@

### DO NOT DELETE THIS LINE
Main.uo: Parser.ui Lexer.ui 
Lexer.ui: Parser.ui Hasht.ui 
Parser.uo: Parser.ui 
Hasht.uo: Hasht.ui 
Lexer.uo: Lexer.ui Parser.ui Hasht.ui 
