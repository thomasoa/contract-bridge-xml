AVA=java
XSLTPROC=xsltproc

CLASSDIR=classes
CLASSES=$(CLASSDIR)/xalan.jar:$(CLASSDIR)/xml-api.jar:$(CLASSDIR)/xercesImpl.jar
DIRS=everybody parzero badfit test tenaces hands all1S

GZTARGETS=parzero2 badfit2 test2 tenaces2 hands2
GZIP=gzip -f

JAVACMD=$(JAVA) -classpath $(CLASSES)
VERSION=0.8
ZIPDIR=BridgeML-$(VERSION)

DEST=../public_html/bridge/deals2
XML=../public_html/bridge/xml
PUBLISH=../public_html/bridge/deals

XSL=article.xsl articles.xsl articles2.xsl diagram.xsl shared.xsl \
    auction.xsl default.xsl link.xsl hands.xsl inline.xsl test.xsl

all: html-copy $(DIRS) gzfiles

gzfiles: $(GZTARGETS)

install: all
	( cd html ; tar cf - articles.js article.css $(DIRS) ) | ( cd $(DEST) ; tar xvf - )

publish: all
	( cd html ; tar cf - articles.js article.css $(DIRS) ) | ( cd $(PUBLISH) ; tar xvf - )
	cp README $(XML)/README.txt

clean:
	rm -rf html

html-copy:
	mkdir -p html
	( cd static ; git ls-files . | xargs tar cf - ) | (cd html; tar xf -)

everybody: html/everybody/index.html
all1S: html/all1S/index.html

html/everybody/index.html: xml/everybody.xml
	[ -d html/everybody ] || mkdir -p html/everybody
	$(XSLTPROC) --output $@ article.xsl $<

html/all1S/index.html: xml/all1S.xml
	[ -d html/all1S ] || mkdir -p html/all1S
	$(XSLTPROC) --output $@ article.xsl $<

test: html/test/index.html
test2: html/test/all.html
badfit: html/badfit/index.html
badfit2: html/badfit/all.html
parzero: html/parzero/index.html
parzero2: html/parzero/all.html
tenaces: html/tenaces/index.html
tenaces2: html/tenaces/all.html
hands: html/hands/index.html
hands2: html/hands/all.html

html/test/index.html: xml/test/table.xml
	[ -d html/test ] || mkdir -p html/test
	$(XSLTPROC) --output $@ articles.xsl $<

html/test/all.html: xml/test/table.xml
	[ -d html/test ] || mkdir -p html/test
	$(XSLTPROC) --output $@ articles2.xsl $<

html/hands/index.html: xml/hands/table.xml
	[ -d html/hands ] || mkdir -p html/hands
	$(XSLTPROC) --output $@ articles.xsl $<

html/hands/all.html: xml/hands/table.xml
	[ -d html/hands ] || mkdir -p html/hands
	$(XSLTPROC) --output $@ articles2.xsl $<

html/badfit/index.html: xml/badfit/table.xml
	[ -d html/badfit ] || mkdir -p html/badfit
	$(XSLTPROC) --output $@ articles.xsl $<

html/badfit/all.html: xml/badfit/table.xml
	[ -d html/badfit ] || mkdir -p html/badfit
	$(XSLTPROC) --output $@ articles2.xsl $<

html/tenaces/index.html: xml/tenaces/table.xml
	[ -d html/tenaces ] || mkdir -p html/tenaces
	$(XSLTPROC) --output $@ articles.xsl $<

html/tenaces/all.html: xml/tenaces/table.xml
	[ -d html/tenaces ] || mkdir -p html/tenaces
	$(XSLTPROC) --output $@ articles2.xsl $<

html/parzero/index.html: xml/parzero/table.xml
	[ -d html/parzero ] || mkdir -p html/parzero
	$(XSLTPROC) --output $@ articles.xsl $<

html/parzero/all.html: xml/parzero/table.xml
	[ -d html/parzero ] || mkdir -p html/parzero
	$(XSLTPROC) --output $@ articles2.xsl $<

zip: clean
	rm -rf $(ZIPDIR)
	tar cf ../BridgeML.tar . 
	mkdir $(ZIPDIR)
	cd $(ZIPDIR) ; tar xf ../../BridgeML.tar
	zip -r $(ZIPDIR).zip $(ZIPDIR)

smallzip: zip
	cp BridgeML.zip BridgeMLupdate.zip
	zip -d BridgeMLupdate.zip BridgeML/classes/\*
