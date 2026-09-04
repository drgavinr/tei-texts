<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"  xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="tei">
    <!-- Set up output formats. -->
    <xsl:output method="text" name="text"/>
    <xsl:output method="html" indent="yes" name="html"/>
    
    <!-- next and previous links template -->
    <xsl:template name="nav">
        <div class="nav">
            <p>
                <xsl:if test="position()>1">
                    &lt;&lt;&#160;<a><xsl:attribute name="href" select="concat(preceding::tei:text[1]/@xml:id, '.html')"/>Previous</a>&#160;-&#160;
                </xsl:if>
                <a href="index.html">Contents</a>
                <xsl:if test="not(last() = position())">
                    &#160;-&#160;<a><xsl:attribute name="href" select="concat(following::tei:text[1]/@xml:id, '.html')"/>Next</a>&#160;&gt;&gt;
                </xsl:if>
            </p>
        </div>
    </xsl:template>
    
    
    <!-- Generate link to About page for top of each page -->
    <xsl:template name="aboutlink">
        <p class="about"><a href="https://github.com/drgavinr/tei-texts/tree/main/wharton">About</a></p>
    </xsl:template>
    
    
    <!-- Generate HTML code for transcript page -->
    <xsl:template name="pagewrapper"><html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <meta name="text-scale" content="scale" />
                <style type="text/css" media="screen">
                    @import url(style.css );
                </style>
                <title><xsl:value-of select="@n"/></title></head>
            <body>
                <xsl:call-template name="aboutlink"/>
                <xsl:call-template name="nav"/>
                <h1>[<xsl:value-of select="@n"/>]</h1>
                <xsl:apply-templates/>
                <xsl:call-template name="nav"/>
            </body>
    </html>
    </xsl:template>
    
</xsl:stylesheet>