# Bridge Publishing XML

When writing my bridge articles for http://bridge.thomasoandrews.com/, 
I wanted to maintain a consistent look, and to publish in many different way. I was
just learning XSL, and decided to pick an XML format for the articles and use XSL
to format in different ways.

This project contains the XSL I use, and the XML for all of my document.

The Makefile assumes you have xsltproc installed.

There are one-at-a-time scripts, which can publish a single article, and article-set scripts, which can publish a "book" of articles.

First thing first, copy the file "local.xsl.example" to "local.xsl." Nothing will work without it.

If you want, you can add your own analytics code to the local.xsl. 

Examples:
```
     # Create a single article HTML page
     xsltproc --output sample.html article.xsl xml/everybody.xml

     # Create an article set 
     #    This format uses frames to display a table
     #    of contents and a current article
     xsltproc --output html/hands/index.html articles.xsl xml/hands/table.xml

     # Create an article set
     #    This format creates a single file with all articles, and JavaScript to navigate
     xsltproc --output html/hands/all.html articles2.xsl xml/hands/table.xml

     # Create an HTML article suitable for mobile
     xsltproc --output mobile.html mobile-article.xsl xml/everybody.xml

     # Create a mobile article set
     xsltproc --output html/hands/mobile.html mobile-articles.xsl xml/hands/table.xml
```
