mkdir html\everybody
java -classpath classes\xalan.jar;classes\xml-apis.jar;classes\xercesImpl.jar org.apache.xalan.xslt.Process -HTML -IN xml/everybody.xml -XSL article.xsl -OUT html/everybody/index.html

mkdir html\test
java -classpath classes\xalan.jar;classes\xml-apis.jar;classes\xercesImpl.jar org.apache.xalan.xslt.Process -HTML -IN xml/test/table.xml -XSL articles.xsl -OUT html/test/index.html

