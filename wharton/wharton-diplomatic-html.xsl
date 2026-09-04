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
        <xsl:result-document href="html/diplomatic/style.css" format="text" xml:space=""><xsl:text>body{
    /* make Safari use system default font size */
    font: -apple-system-body;
	padding:20px;
	font-family: Georgia, serif;
	/* no max-width for any orientation because lines shouldn't wrap if can be avoided */
}

/* make Safari use system default font size */
@supports (font: -apple-system-body) and (not (-webkit-touch-callout: default)) {
  :root {
    font-size: 100%;
  }
}


h1, h2 {
text-align : left;
font-size:1.2rem;
margin: 0;
padding: 0;
}

.nav{
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
        <xsl:result-document href="html/diplomatic/index.html" format="html">
            <html xmlns="http://www.w3.org/1999/xhtml">
                <head>
                    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
                    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                    <meta name="text-scale" content="scale" />
                    <style type="text/css" media="screen">
                        @import url(style.css );
                    </style>
                    <title>Wharton Letters: Semi-Diplomatic</title></head>
                <body class="indexpage">
                    <xsl:call-template name="aboutlink"/>
                    <h1>Nehemiah Wharton's Letters: Diplomatic Transcript</h1>
                    <p class="indexpage">Letters from Nehemiah Wharton, a parliamentarian soldier in the English Civil War, to George Willingham, his former master.</p>
                    <p class="indexpage">This is a diplomatic transcript which preserves most original features of the text with minimal editorial intervention. Transcription conventions are documented below.</p>
                    <h2>Contents</h2>
                    <ul>
                        <xsl:for-each select="//tei:group/tei:text">
                            <xsl:variable name="pagelink" select="concat(@xml:id,'.html')" />
                            <li><a href="{$pagelink}"><xsl:value-of select="@n"/></a>: <xsl:value-of select="format-date(.//tei:dateline/tei:date/@when-custom, '[D1o] [MNn] [Y]', 'en', (), () )" /></li>
                        </xsl:for-each>
                    </ul>
                    <h2>Transcription conventions</h2>
                    <ul>
                        <li>Original line breaks are represented.</li>
                        <li>Original page breaks are represented in square brackets giving folio numbers: [f.1r].</li>
                        <li>All original spelling is retained with no modernization. Long s is represented as ſ.</li>
                        <li>Original capitalization is retained.</li>
                        <li>All punctuation visible in the microfilm is retained, including commas in SP 16/492/32 which may not be original. No punctuation has been added.</li>
                        <li>Abbreviations are left unexpanded.</li>
                        <li>Anomalies judged to be scribal errors are silently retained.</li>
                        <li>Deletions are retained and marked up with HTML del tags, which will usually be displayed as strikethrough: <del>word </del>.</li>
                        <li>Insertions are rendered as subscript or superscript as in the manuscript.</li>
                        <li>Dates are displayed as written in the manuscript even if wrong. Superscript is retained where used for ordinals. All dates in the text are in the Julian calendar.</li>
                        <li>Uncertain text is flagged with square brackets and question marks: [? word ?].</li>
                        <li>Gaps in the text because of damage to the manuscript or illegible words are shown by [...]. No information is given about the reason for or extent of the gap.</li>
                        <li>Text highlighted by underlining in the manuscript is underlined in the transcript: <u>word</u>. Manicules are not represented.</li>
                        
                    </ul>
                </body>
            </html>
            
        </xsl:result-document>
        
        
        <!-- Select each text and create separate output file for each. -->
        <xsl:for-each select="//tei:group/tei:text">
            <xsl:variable name="filename" select="concat('html/diplomatic/',@xml:id,'.html')" />
            <xsl:result-document href="{$filename}" format="html"><xsl:call-template name="pagewrapper"/>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    
    <!-- Elements to be wrapped in paragraph. -->
    <xsl:template match="tei:p|tei:salute|tei:signed|tei:dateline"><p><xsl:apply-templates/></p><xsl:text>

</xsl:text></xsl:template>
    
    <!-- General elements that need nothing special, but templates need to be applied inside them. -->
    <xsl:template match="tei:div1|tei:opener|tei:closer|tei:postscript|tei:body|tei:seg[@type='entry']|tei:date|tei:rs|tei:choice"><xsl:apply-templates/></xsl:template>
    
    <!-- Elements to be silently included. -->
    <xsl:template match="tei:orig|tei:abbr|tei:sic|tei:am[not(@rend)]"><xsl:apply-templates/></xsl:template>
    
    <!-- Elements to be silently omitted. -->
    <xsl:template match="tei:reg|tei:expan|tei:ex|tei:corr|tei:supplied"></xsl:template>
    
    
    <!-- More specific elements -->
    
    <!-- Deletions -->
        <xsl:template match="tei:del"><del><xsl:apply-templates/></del></xsl:template>
    
    <!-- Unclear text -->
    <xsl:template match="tei:unclear">[? <xsl:apply-templates/> ?]</xsl:template>
    
    <!-- Gaps -->
    <xsl:template match="tei:gap">[...]</xsl:template>
    
    <!-- Page breaks -->
    <!-- Need own paragraphs -->
    <xsl:template match="tei:div1/tei:pb"><p>[f. <xsl:value-of select="@n"/>]</p></xsl:template>
    <!-- Already in paragraphs -->
    <xsl:template match="tei:pb[not(parent::tei:div1)]"><br/>[f. <xsl:value-of select="@n"/>]<br/></xsl:template>
    
    <!-- Line breaks. -->
    <xsl:template match="tei:lb"><br/></xsl:template>
    
    <!-- Superscript -->
    <xsl:template match="*[@rend='sup']"><sup><xsl:apply-templates/></sup></xsl:template>
    
    <!-- Subscript -->
    <xsl:template match="*[@rend='sub']"><sub><xsl:apply-templates/></sub></xsl:template>
    
    <!-- Highlighting -->
    <xsl:template match="tei:hi"><u><xsl:apply-templates/></u></xsl:template>
    
</xsl:stylesheet>
