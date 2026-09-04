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
        <xsl:result-document href="html/intermediate/style.css" format="text" xml:space=""><xsl:text>body{
    /* make Safari use system default font size */
    font: -apple-system-body;
	padding:20px;
	font-family: Georgia, serif;
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

.indexpage{
    font-family: Arial, sans-serif;
}

</xsl:text>
        </xsl:result-document>
        
        <!-- Generate index.html -->
        <xsl:result-document href="html/intermediate/index.html" format="html">
            <html xmlns="http://www.w3.org/1999/xhtml">
                <head>
                    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
                    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                    <meta name="text-scale" content="scale" />
                    <style type="text/css" media="screen">
                        @import url(style.css );
                    </style>
                    <title>Wharton Letters: Intermediate</title></head>
                <body class="indexpage">
                    <xsl:call-template name="aboutlink"/>
                    <h1>Nehemiah Wharton's Letters: Intermediate Transcript</h1>
                    <p class="indexpage">Letters from Nehemiah Wharton, a parliamentarian soldier in the English Civil War, to George Willingham, his former master.</p>
                    <p class="indexpage">This is an intermediate transcript which includes some editorial interventions. Transcription conventions are documented below.</p>
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
                        <li>Original page breaks are represented in square brackets giving folio numbers: [f.1r].</li>
                        <li>Original spelling is retained except: <ul>
                                <li>i/j and u/v are silently modernized where used interchangeably.</li>
                                <li>ff at the start of a word is silently modernized to F.</li>
                                <li>long s is silently modernized to s.</li>
                                
                        </ul>
                        </li>
                        <li>Original capitalization is retained.</li>
                        <li>All punctuation visible in the microfilm is retained, including commas in SP 16/492/32 which may not be original. No punctuation has been added.</li>
                        <li>Abbreviations are expanded in square brackets.</li>
                        <li>Anomalies judged to be scribal errors are retained but marked with [sic].</li>
                        <li>Deletions are retained and marked up with HTML del tags, which will usually be displayed as strikethrough: <del>word </del>.</li>
                        <li>Insertions are marked up with HTML ins tags, which are usually displayed as underlined text: <ins>word</ins>.</li>
                        <li>Dates are displayed as written in the manuscript except that superscript is not used for ordinals. Original dates are followed by a corrected and regularized version in square brackets. All dates in the text are in the Julian calendar, including regularized versions in square brackets.</li>
                        <li>Uncertain text is flagged with square brackets and question marks: [? word ?].</li>
                        <li>Gaps in the text because of damage to the manuscript or illegible words are shown by [...]. No information is given about the reason for or extent of the gap.</li>
                        <li>No highlighting is represented.</li>
                        
                    </ul>
                </body>
            </html>
            
        </xsl:result-document>
        
        <!-- Select each text and create separate output file for each. -->
        <xsl:for-each select="//tei:group/tei:text">
            <xsl:variable name="filename" select="concat('html/intermediate/',@xml:id,'.html')" />
            <xsl:result-document href="{$filename}" format="html"><xsl:call-template name="pagewrapper"/>
            </xsl:result-document>
            
        </xsl:for-each>
    </xsl:template>
    
    <!-- Elements to be wrapped in paragraph. -->
    <xsl:template match="tei:p[not(tei:seg[@type='entry'])]|tei:seg[@type='entry']|tei:salute|tei:signed|tei:dateline"><p><xsl:apply-templates/></p></xsl:template>
    
    <!-- General elements that need nothing special, but templates need to be applied inside them. -->
    <xsl:template match="tei:div1|tei:opener|tei:closer|tei:postscript|tei:body|tei:seg[@type='ordinal']|tei:rs|tei:choice"><xsl:apply-templates/></xsl:template>
    
    <!-- Elements to be silently included. -->
    <xsl:template match="tei:reg|tei:expan|tei:hi"><xsl:apply-templates/></xsl:template>
    
    <!-- Elements to be silently omitted. -->
    <xsl:template match="tei:orig|tei:abbr|tei:am|tei:corr"></xsl:template>
    
    <!-- More specific elements -->
    
    <!-- Legible deleted text. -->
    <xsl:template match="tei:del"><del><xsl:apply-templates/></del></xsl:template>
    
    <!-- Inserted text. -->
    <xsl:template match="tei:add"><ins><xsl:apply-templates/></ins></xsl:template>
    
    <!-- Unclear text. -->
    <xsl:template match="tei:unclear">[? <xsl:apply-templates/> ?]</xsl:template>
    
    <!-- Expansions in square brackets. -->
    <xsl:template match="tei:ex">[<xsl:apply-templates/>]</xsl:template>
    
    <!-- Errors noted but not corrected. -->
    <xsl:template match="tei:sic"><xsl:apply-templates/> [sic]</xsl:template>
    
    <!-- Gaps supplied. -->
    <xsl:template match="tei:supplied">[<xsl:apply-templates/>]</xsl:template>
    <!-- Gaps not supplied. -->
    <xsl:template match="tei:gap[not(parent::tei:orig)]">[...]</xsl:template>
    
    <!-- Standardize dates in square brackets. -->
    <xsl:template match="tei:date"><xsl:apply-templates/> [<xsl:value-of select="format-date(@when-custom, '[D1]/[M]/[Y]', 'en', (), () )" />]</xsl:template>
    
    <!-- Page breaks -->
    <!-- Need own paragraphs -->
    <xsl:template match="tei:div1/tei:pb"><p>[f. <xsl:value-of select="@n"/>]</p></xsl:template>
    <!-- Already in paragraphs -->
    <xsl:template match="tei:pb[not(parent::tei:div1)]"> [f. <xsl:value-of select="@n"/>] </xsl:template>
    
    <!-- Replace line break with space. -->
    <xsl:template match="tei:lb"><xsl:text> </xsl:text></xsl:template>
    
    <!-- Should highlighting be represented? Probably can't be because underline already used for additions -->
    
</xsl:stylesheet>
