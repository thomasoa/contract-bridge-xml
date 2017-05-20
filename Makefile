JAVA=java
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

ONEXSL = article.xsl
ONENAME = index.html

ALLXSL = articles2.xsl
ALLNAME = all.html

MOBILETARGET=all
all: $(DIRS) gzfiles

mobile:
	make ONEXSL=mobile-article.xsl ONENAME=mobile.html ALLXSL=mobile-articles.xsl ALLNAME=mobile.html $(MOBILETARGET)

gzfiles: $(GZTARGETS)

install: all
	( cd html ; tar cf - articles.js article.css $(DIRS) ) | ( cd $(DEST) ; tar xvf - )

publish: all
	( cd html ; tar cf - articles.js article.css $(DIRS) ) | ( cd $(PUBLISH) ; tar xvf - )
	cp README $(XML)/README.txt

clean:
	cd html ; rm -rf */*.html
	find . -name '*~' -print | xargs rm
	rm -f *.zip

everybody: html/everybody/$(ONENAME)
all1S: html/all1S/$(ONENAME)
all1S-mobile: html/all1S/mobile.html

html/everybody/$(ONENAME): xml/everybody.xml
	[ -d html/everybody ] || mkdir -p html/everybody
	$(XSLTPROC) --output $@ $(ONEXSL) $<

html/all1S/$(ONENAME): xml/all1S.xml
	[ -d html/all1S ] || mkdir -p html/all1S
	$(XSLTPROC) --output $@ $(ONEXSL) $<

test: html/test/index.html
test2: html/test/$(ALLNAME)
badfit: html/badfit/index.html
badfit2: html/badfit/$(ALLNAME)
parzero: html/parzero/index.html
parzero2: html/parzero/$(ALLNAME)
tenaces: html/tenaces/index.html
tenaces2: html/tenaces/$(ALLNAME)
hands: html/hands/index.html
hands2: html/hands/$(ALLNAME)

html/test/index.html: xml/test/table.xml
	[ -d html/test ] || mkdir -p html/test
	$(XSLTPROC) --output $@ articles.xsl $<

html/test/$(ALLNAME): xml/test/table.xml
	[ -d html/test ] || mkdir -p html/test
	$(XSLTPROC) --output $@ $(ALLXSL) $<

html/hands/index.html: xml/hands/table.xml
	[ -d html/hands ] || mkdir -p html/hands
	$(XSLTPROC) --output $@ articles.xsl $<

html/hands/$(ALLNAME): xml/hands/table.xml
	[ -d html/hands ] || mkdir -p html/hands
	$(XSLTPROC) --output $@ $(ALLXSL) $<

html/badfit/index.html: xml/badfit/table.xml
	[ -d html/badfit ] || mkdir -p html/badfit
	$(XSLTPROC) --output $@ articles.xsl $<

html/badfit/$(ALLNAME): xml/badfit/table.xml
	[ -d html/badfit ] || mkdir -p html/badfit
	$(XSLTPROC) --output $@ $(ALLXSL) $<

html/tenaces/index.html: xml/tenaces/table.xml
	[ -d html/tenaces ] || mkdir -p html/tenaces
	$(XSLTPROC) --output $@ articles.xsl $<

html/tenaces/$(ALLNAME): xml/tenaces/table.xml
	[ -d html/tenaces ] || mkdir -p html/tenaces
	$(XSLTPROC) --output $@ $(ALLXSL) $<

html/parzero/index.html: xml/parzero/table.xml
	[ -d html/parzero ] || mkdir -p html/parzero
	$(XSLTPROC) --output $@ articles.xsl $<

html/parzero/$(ALLNAME): xml/parzero/table.xml
	[ -d html/parzero ] || mkdir -p html/parzero
	$(XSLTPROC) --output $@ $(ALLXSL) $<

zip: clean
	rm -rf $(ZIPDIR)
	tar cf ../BridgeML.tar . 
	mkdir $(ZIPDIR)
	cd $(ZIPDIR) ; tar xf ../../BridgeML.tar
	zip -r $(ZIPDIR).zip $(ZIPDIR)

smallzip: zip
	cp BridgeML.zip BridgeMLupdate.zip
	zip -d BridgeMLupdate.zip BridgeML/classes/\*
