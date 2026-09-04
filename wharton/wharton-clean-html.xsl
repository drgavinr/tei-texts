<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"  xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="tei">
    <!-- Set up output formats. -->
    <xsl:output method="text" name="text"/>
    <xsl:output method="html" indent="yes" name="html"/>
    
    <!-- Include shared templates -->
    <xsl:include href="wharton-include.xsl"/>
    
    <!-- Main template -->
    <xsl:template match="/">
        <!-- Generate CSS file -->
        <xsl:result-document href="html/clean/style.css" format="text" xml:space=""><xsl:text>body{
    /* make Safari use system default font size */
    font: -apple-system-body;
	padding:20px;
	font-family: Arial, sans-serif;
	/* no max-width here as only needed in landscape */
}

/* make Safari use system default font size */
@supports (font: -apple-system-body) and (not (-webkit-touch-callout: default)) {
  :root {
    font-size: 100%;
  }
}

/* set max-width only in landscape (nothing needed for portrait) */
@media only screen and (orientation: landscape) {
  body {
    max-width: 25em;
  }
}


h1, h2 {
text-align : left;
font-size:1.2rem;
margin: 0;
padding: 0;
}

.nav{
    text-align: center;
    margin: 0;
    padding: 0;
}

.about{
    margin: 0;
    padding: 0;
}

</xsl:text>
        </xsl:result-document>
        
        <!-- Generate index.html -->
        <xsl:result-document href="html/clean/index.html" format="html">
            <html xmlns="http://www.w3.org/1999/xhtml">
                <head>
                    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
                    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                    <meta name="text-scale" content="scale" />
                    <style type="text/css" media="screen">
                        @import url(style.css );
                    </style>
                    <title>Wharton Letters: Clean</title></head>
                <body>
                    <xsl:call-template name="aboutlink"/>
                    <h1>Nehemiah Wharton's Letters: Clean Transcript</h1>
                    <p>Letters from Nehemiah Wharton, a parliamentarian soldier in the English Civil War, to George Willingham, his former master.</p>
                    <p>This is a clean transcript which includes silent expansions and corrections for ease of reading. Transcription conventions are documented below.</p>
                    <h2>Contents</h2>
                    <ul>
                        <xsl:for-each select="//tei:group/tei:text">
                            <xsl:variable name="pagelink" select="concat(@xml:id,'.html')" />
                            <li><a href="{$pagelink}"><xsl:value-of select="@n"/></a>: <xsl:value-of select="format-date(.//tei:dateline/tei:date/@when-custom, '[D1o] [MNn] [Y]', 'en', (), () )" /></li>
                        </xsl:for-each>
                    </ul>
                    <h2>Transcription conventions</h2>
                    <ul>
                        <li>Original line breaks are not represented. Non-original paragraph breaks have been added for ease of reading.</li>
                        <li>Original page breaks are not represented.</li>
                        <li>Original spelling is retained except: <ul>
                                <li>i/j and u/v are silently modernized where used interchangeably.</li>
                                <li>ff at the start of a word is silently modernized to F.</li>
                                <li>long s is silently modernized to s.</li>
                                
                        </ul>
                        </li>
                        <li>Original capitalization is retained.</li>
                        <li>All punctuation visible in the microfilm is retained, including commas in SP 16/492/32 which may not be original. No punctuation has been added.</li>
                        <li>Abbreviations are silently expanded.</li>
                        <li>Anomalies judged to be scribal errors are silently corrected.</li>
                        <li>Deletions are silently omitted.</li>
                        <li>Insertions are silently included in the main text.</li>
                        <li>Dates are displayed as written in the manuscript but without superscript for ordinals, and are silently corrected if judged wrong. All dates in the text are in the Julian calendar.</li>
                        <li>Uncertain text is not marked as uncertain.</li>
                        <li>Gaps in the text because of damage to the manuscript or illegible words are shown by ... and no information is given about the reason for or extent of the gap.</li>
                        <li>No highlighting is represented.</li>
                        
                    </ul>
                </body>
            </html>
            
        </xsl:result-document>
        
        <!-- Select each text and create separate output file for each. -->
        <xsl:for-each select="//tei:group/tei:text">
            <xsl:variable name="filename" select="concat('html/clean/',@xml:id,'.html')" />
            <xsl:result-document href="{$filename}" format="html"><xsl:call-template name="pagewrapper"/>
            </xsl:result-document>
            
        </xsl:for-each>
    </xsl:template>
    
    <!-- Elements to be wrapped in paragraph. -->
    <xsl:template match="tei:p[not(tei:seg[@type='entry'])]|tei:seg[@type='entry']|tei:salute|tei:signed|tei:dateline"><p><xsl:apply-templates/></p></xsl:template>
    
    <!-- General elements that need nothing special, but templates need to be applied inside them. -->
    <xsl:template match="tei:div1|tei:opener|tei:closer|tei:date|tei:postscript|tei:body|tei:choice|tei:seg[@type='ordinal']|tei:rs"><xsl:apply-templates/></xsl:template>
    
    <!-- Elements to be silently included. -->
    <xsl:template match="tei:unclear|tei:reg|tei:expan|tei:ex|tei:corr|tei:supplied|tei:add|tei:hi"><xsl:apply-templates/></xsl:template>
    
    <!-- Elements to be silently omitted. -->
    <xsl:template match="tei:del|tei:orig|tei:abbr|tei:am|tei:sic"></xsl:template>
    
    <!-- Gaps not supplied. -->
    <xsl:template match="tei:gap[not(parent::orig)]">...</xsl:template>
    
    <!-- Replace page break and line break with space. -->
    <xsl:template match="tei:pb|tei:lb"><xsl:text> </xsl:text></xsl:template>
    
</xsl:stylesheet>
