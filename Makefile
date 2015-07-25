# Makefile for schreiner_sml project.
# Franklin Chen

include Makefile.mosml
include Makefile.noweb

MOSMLYFLAGS = -v

SRC = \
	Lexer.nw \
	Parser.nw \
	Format.nw \
	Hasht.sml Hasht.sig \
	Main.nw

# Hasht is stolen from mosml compiler source.
SML_GEN = \
	Lexer.sml Lexer.sig \
	Parser.sml Parser.sig \
	Format.sml Format.sig \
	Main.sml

SML_SRC = \
	$(SML_GEN) \
	Hasht.sml Hasht.sig

SML_OBJS = \
	Hasht.uo \
	Format.uo \
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
	Nonstdio.uo \
	Substring.uo \
	Path.uo \
	Time.uo \
	OS.uo \
	FileSys.uo \
	Timer.uo \
	Mosml.uo

.PHONY: all doc install depend clean

all: fmt doc

fmt: $(SML_OBJS)
	$(MOSMLLD) $(MOSMLLDFLAGS) -o $@ $(LIBOBJS) $(SML_OBJS)

doc: Lexer.pdf Parser.pdf Format.pdf Main.pdf \
	Lexer.html Parser.html Format.html Main.html

install:

# FMC need add stuff.
clean:
	rm -f *.ui *.uo Makefile.bak \
	*~ *.aux *.ltx *.pdf *.log *.html \
	$(SML_GEN) fmt *.lex *.grm *.output

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
	$(NOWEAVE) -index -autodefs sml $< $(CPIF) $@
Lexer.html: Lexer.nw
	$(NOWEAVE) -filter $(L2H) -index -autodefs sml -html $< $(CPIF) $@

Parser.grm: Parser.nw
	$(NOTANGLE) $< $(CPIF) $@
Parser.ltx: Parser.nw
	$(NOWEAVE) -index -autodefs sml $< $(CPIF) $@
Parser.html: Parser.nw
	$(NOWEAVE) -filter $(L2H) -index -autodefs sml -html $< $(CPIF) $@

Format.sig: Format.nw
	$(NOTANGLE) -R"[[$@]]" $< $(CPIF) $@
Format.sml: Format.nw
	$(NOTANGLE) $< $(CPIF) $@
Format.ltx: Format.nw
	$(NOWEAVE) -index -autodefs sml $< $(CPIF) $@
Format.html: Format.nw
	$(NOWEAVE) -filter $(L2H) -index -autodefs sml -html $< $(CPIF) $@

Main.sml: Main.nw
	$(NOTANGLE) $< $(CPIF) $@
Main.ltx: Main.nw
	$(NOWEAVE) -index -autodefs sml $< $(CPIF) $@
Main.html: Main.nw
	$(NOWEAVE) -filter $(L2H) -index -autodefs sml -html $< $(CPIF) $@

### DO NOT DELETE THIS LINE
Format.uo: Format.ui
Parser.ui: Format.ui
Parser.uo: Parser.ui Format.ui
Lexer.ui: Parser.ui
Hasht.uo: Hasht.ui
Main.uo: Parser.ui Format.ui Lexer.ui
Lexer.uo: Lexer.ui Parser.ui Hasht.ui
