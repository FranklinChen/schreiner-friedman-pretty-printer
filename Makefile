# Makefile for schreiner_sml project.
# Franklin Chen

include Makefile.stub

# FMC need to put in noweb stuff.

MOSMLYFLAGS = -v

SRC = \
	Lexer.lex \
	Parser.grm \
	Hasht.sml Hasht.sig \
	Main.sml

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
	StringCvt.uo \
	Integer.uo \
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

all: recog

recog: $(SML_OBJS)
	$(MOSMLLD) $(MOSMLLDFLAGS) -o $@ $(LIBOBJS) $(SML_OBJS)

install:

# FMC need add
clean:
	rm -f *.ui
	rm -f *.uo
	rm -f Makefile.bak

depend: $(SML_SRC)
	rm -f Makefile.bak
	mv Makefile Makefile.bak
	$(MOSMLCUT) < Makefile.bak > Makefile
	$(MOSMLDEP) >> Makefile

### DO NOT DELETE THIS LINE
Lexer.ui: Parser.ui 
Main.uo: Parser.ui Lexer.ui 
Parser.uo: Parser.ui 
Hasht.uo: Hasht.ui 
Lexer.uo: Lexer.ui Parser.ui Hasht.ui 
