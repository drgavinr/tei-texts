<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"  xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="tei">
    
    
    <!-- Set up output formats. -->
    <xsl:output method="text" name="text"/>
    <xsl:output method="html" indent="yes" name="html"/>
    
    <!-- Main template. Outputs HTML file for front matter and one HTML file for each chapter. -->
    <xsl:template match="/">
        <!-- Front matter -->
        <xsl:for-each select="//tei:front">
            <xsl:result-document href="html/index.html" format="html" xml:space="">
                <html>
                    <head>
                        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
                        <style type="text/css" media="screen">
                            @import url(sandall-style.css );
                        </style>
                        <title><xsl:value-of select="//tei:fileDesc/tei:titleStmt/tei:title"/></title>
                    </head>
                    <body>
                        <xsl:call-template name="about"/>
                    <xsl:for-each select="tei:titlePage">
                        <xsl:apply-templates/>
                        <xsl:if test="@facs"><a class="pageimage"><xsl:attribute name="href" select="./@facs"/>[view page image]</a></xsl:if>
                    </xsl:for-each>
                        
                        <p><xsl:value-of select="//tei:edition[1]"/>. Last updated: <xsl:value-of select="//tei:change[1]/@when"/>.</p>
                        
                        <xsl:call-template name="contents"/>
                        
                        <h2>Copyright</h2>
                        <xsl:for-each select="//tei:availability/tei:p">
                            <p><xsl:value-of select="."/></p>
                        </xsl:for-each>
                        
                     
                     
                </body>
                </html>
            </xsl:result-document>
        </xsl:for-each>
        
        <!-- Chapters -->
        <xsl:for-each select="//tei:div1[./@type!='contents']">
            <xsl:variable name="filename" select="concat('html/',@n,'.html')" />
            
            <xsl:result-document href="{$filename}" format="html">
                <html>
                    <head>
                        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
                        <style type="text/css" media="screen">
                            @import url(sandall-style.css );
                        </style>
                        <title><xsl:value-of select="tei:head"/> (Sandall, 5th Lincolnshire Regiment)</title>
                    </head>
                    <body>
                        <h1>T.E. Sandall, History of the 5th Battalion Lincolnshire Regiment (1922)</h1>
                            <xsl:call-template name="about"/>
                        <xsl:call-template name="nav"/>
                    <xsl:apply-templates/>
                        <xsl:call-template name="nav"/>
                    </body>
                </html>
            </xsl:result-document>
        </xsl:for-each>
        <!-- Call template to create indexes of people and places. -->
         <xsl:call-template name="peopleindex"/>
        <xsl:call-template name="placeindex"/>

        <!-- Write CSS file. -->
        <xsl:result-document href="html/sandall-style.css" format="text" xml:space=""><xsl:text>body{
	margin-left:2em;
	font-size : 1em;
	width:30em;
}

h1, h2{
	text-align : left;
	
}


p{
   width:30em;
	margin-right:10em;
	
}

blockquote{
	width: 25em;
}

.nav{
	text-align : center;
	margin-bottom:3em;
	margin-top:2em;
}


</xsl:text></xsl:result-document>

    </xsl:template>
    
    
    
    <!-- More specific templates. -->
    
    <!-- Title page. -->
    <xsl:template match="tei:titlePage">
        <div>
            <a class="pageimage"><xsl:attribute name="id" select="./@xml:id"/><xsl:attribute name="href" select="./@facs"/>[view page image]</a>
            <xsl:apply-templates/>
            <xsl:for-each select="//tei:availability/tei:p">
                <p><xsl:value-of select="."/></p>
            </xsl:for-each>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:titlePart[@type='main']">
        <h1><xsl:value-of select="."/></h1>
    </xsl:template>
    
    <xsl:template match="tei:titlePart[@type='sub']">
        <h2><xsl:value-of select="."/></h2>
    </xsl:template>
    
    <xsl:template match="tei:byline | tei:docImprint">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    
    <xsl:template match="tei:div1/tei:head">
        <h2>            
            <xsl:value-of select="."/>
        </h2>
    </xsl:template>
    
    <xsl:template match="tei:div2/tei:head">
        <h3>
            <xsl:if test="@xml:id">
                <xsl:attribute name="id" select="./@xml:id"/>
            </xsl:if><xsl:value-of select="."/>
        </h3>
        <xsl:if test="@facs">
            <a class="pageimage"><xsl:attribute name="href" select="./@facs"/>[view page image]</a>
        </xsl:if>
    </xsl:template>
    
    
    
    <xsl:template match="tei:p">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    
    <xsl:template match="tei:div1">
        <div><xsl:apply-templates/></div>
    </xsl:template>
    
    <xsl:template match="tei:div2">
        <div>
            <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="./@xml:id"/>
            </xsl:if>
            <xsl:if test="@facs">
                <a class="pageimage"><xsl:attribute name="href" select="./@facs"/>[view page image]</a>
            </xsl:if><xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:pb[not(ancestor::tei:persName) and not(ancestor::tei:rs) and not(ancestor::tei:placeName)]">
        [<a><xsl:attribute name="id" select="./@xml:id"/><xsl:if test="@facs"><xsl:attribute name="href" select="./@facs"/><xsl:value-of select="./@xml:id"></xsl:value-of> </xsl:if></a>]
    </xsl:template>
    
    <xsl:template match="tei:div1[@type='index']//tei:ref">
        <xsl:variable name="currenttarget" select="./@target"/>
        <xsl:variable name="url" select="concat(id($currenttarget)/ancestor::tei:div1/@n, '.html#', $currenttarget)"/>
        <a><xsl:attribute name="href" select="$url"/><xsl:value-of select="."/></a>
    </xsl:template>
    
    <xsl:template match="tei:list">
        <h3><xsl:value-of select="tei:head"/></h3>
        <ul>
            <xsl:apply-templates/>
        </ul>
    </xsl:template>
    
    <xsl:template match="tei:item">
        <li><xsl:apply-templates/></li>
    </xsl:template>
    
    <xsl:template match="tei:quote">
        <blockquote><xsl:apply-templates/></blockquote>
    </xsl:template>
    
    <!-- Abbreviations and expansions -->
    <xsl:template match="//tei:choice[tei:abbr]">
        <abbr><xsl:attribute name="title"  select="tei:expan"/><xsl:value-of select="tei:abbr"/></abbr>
    </xsl:template>
    
    <xsl:template match="tei:persName|tei:rs[@type='person']">
        <a><xsl:attribute name="href" select="concat('people-index.html#', ./@key)"/><xsl:attribute name="title" select="./@key"/><xsl:attribute name="id" select="./@xml:id"/><xsl:apply-templates/></a>
        <xsl:if test="descendant::tei:pb">
            [<a><xsl:attribute name="id" select="descendant::tei:pb[1]/@xml:id"/><xsl:if test="descendant::tei:pb[1]/@facs"><xsl:attribute name="href" select="concat('images/', descendant::tei:pb[1]/@facs)"/><xsl:value-of select="descendant::tei:pb[1]/@xml:id"/></xsl:if></a>] </xsl:if>
    </xsl:template>
    
    <xsl:template match="tei:placeName">
        <a><xsl:attribute name="id" select="./@xml:id"/><xsl:if test="./@key"><xsl:attribute name="href" select="concat('place-index.html?n=', ./@key)"/><xsl:attribute name="title" select="./@key"/></xsl:if><xsl:apply-templates/></a>
        <xsl:if test="descendant::tei:pb">
            [<a><xsl:attribute name="id" select="descendant::tei:pb[1]/@xml:id"/>
                <xsl:if test="descendant::tei:pb[1]/@facs"><xsl:attribute name="href" select="concat('images/', descendant::tei:pb[1]/@facs)"/><xsl:value-of select="descendant::tei:pb[1]/@xml:id"/></xsl:if></a>] 
        </xsl:if>
    </xsl:template>
    
<xsl:template match="tei:date">
    <span><xsl:attribute name="title" select="./@when"/><xsl:apply-templates/></span>
</xsl:template>
    
    <!-- Templates previously in separate files -->
    <!-- Link to About page. Needs to be included separately from navigation links on Contents page. -->
    <xsl:template name="about">
        <div class="search">
            <p><a href="https://github.com/drgavinr/tei-texts/tree/main/sandall5thlincs">About</a></p>
        </div>
    </xsl:template>
    
    <!-- Navigation links for top and bottom of chapter pages. -->
    <xsl:template name="nav">
        <div class="nav">
            <p>
                <xsl:if test="position()>1">
                    &lt;&lt;&#160;<a><xsl:attribute name="href" select="concat(preceding::tei:div1[1]/@n, '.html')"/>Previous Chapter</a>&#160;-&#160;
                </xsl:if>
                <a href="index.html">Contents</a>
                <xsl:if test="not(last() = position())">
                    &#160;-&#160;<a><xsl:attribute name="href" select="concat(following::tei:div1[1]/@n, '.html')"/>Next Chapter</a>&#160;&gt;&gt;
                </xsl:if>
            </p>
            <p><a href="people-index.html">Index of People</a>&#160;-&#160;<a href="place-index.html">Index of Places</a></p>
        </div>
    </xsl:template>
    
    <!-- Generate Contents page. -->
    <xsl:template name="contents">
        <h2>Contents</h2>
        <ol>
            <xsl:for-each select="//tei:div1">
                <li><a><xsl:attribute name="href" select="concat(./@n, '.html')"/><xsl:value-of select="child::tei:head[1]"/></a></li>
            </xsl:for-each>
            <li><a href="people-index.html">Index of People</a></li>
            <li><a href="place-index.html">Index of Places</a></li>
        </ol>
        
    </xsl:template>
    
    <!-- Generate index of people -->
    <xsl:template name="peopleindex">
        <xsl:result-document href="html/people-index.html" format="html" xml:space="">
            <html>
                <head>
                    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
                    <style type="text/css" media="screen">
                        @import url(sandall-style.css );
                    </style>
                    <title>Index of People (Sandall, 5th Lincolnshire Regiment)</title>
                </head>
                <body>
                    <h1>T.E. Sandall, History of the 5th Battalion Lincolnshire Regiment (1922)</h1>
                    <xsl:call-template name="about"/>
                    <xsl:call-template name="nav"/>
                    <h2>Index of People</h2>
                    <p>The first level of list items are subject headings for each person. If they are hyperlinks, the links lead to external identifiers. The second level, below each heading, is a list of links to mentions of this person in the text.</p>
                    <ul>
                        <xsl:for-each-group select="//tei:persName|//tei:rs[@type='person']" group-by="@key"><xsl:sort select="@key"/>
                            <li><a><xsl:attribute name="id" select="@key"/><xsl:if test="@ref"><xsl:attribute name="href" select="@ref"></xsl:attribute></xsl:if><xsl:value-of select="@key"/></a>
                                <ul>
                                    <xsl:for-each select="current-group()"><li><a><xsl:attribute name="href" select="concat(./ancestor::tei:div1/@n, '.html#', @xml:id)"></xsl:attribute><xsl:value-of select="./ancestor::tei:div1/tei:head"/></a></li></xsl:for-each>
                                </ul>   
                            </li>
                        </xsl:for-each-group>
                    </ul>
                    <xsl:call-template name="nav"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <!-- Generate index of places -->
    <xsl:template name="placeindex">
        <xsl:result-document href="html/place-index.html" format="html" xml:space="">
            <html>
                <head>
                    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
                    <style type="text/css" media="screen">
                        @import url(sandall-style.css );
                    </style>
                    <title>Index of Places (Sandall, 5th Lincolnshire Regiment)</title>
                </head>
                <body>
                    <h1>T.E. Sandall, History of the 5th Battalion Lincolnshire Regiment (1922)</h1>
                    <xsl:call-template name="about"/>
                    <xsl:call-template name="nav"/>
                    <h2>Index of Places</h2>
                    <p>The first level of list items are subject headings for each place. If they are hyperlinks, the links lead to external identifiers. The second level, below each heading, is a list of links to mentions of this place in the text.</p>
                    <ul>
                        <xsl:for-each-group select="//tei:placeName" group-by="@key"><xsl:sort select="@key"/>
                            <li><a><xsl:attribute name="id" select="@key"/><xsl:if test="@ref"><xsl:attribute name="href" select="@ref"></xsl:attribute></xsl:if><xsl:value-of select="@key"/></a>
                                <ul>
                                    <xsl:for-each select="current-group()"><li><a><xsl:attribute name="href" select="concat(./ancestor::tei:div1/@n, '.html#', @xml:id)"></xsl:attribute><xsl:value-of select="./ancestor::tei:div1/tei:head"/></a></li></xsl:for-each>
                                </ul>   
                            </li>
                        </xsl:for-each-group>
                    </ul>
                    <xsl:call-template name="nav"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <!-- Any other elements that just need apply templates. -->
    <xsl:template match="tei:addName|tei:addrLine|tei:address|tei:back|tei:body|tei:corr|tei:docAuthor|tei:docDate|tei:docTitle|tei:forename|tei:genName|tei:name|tei:nameLink|tei:pubPlace|tei:publisher|tei:roleName|tei:surname"><xsl:apply-templates></xsl:apply-templates></xsl:template>
    
    <!-- Any elements to be silently omitted from HTML. -->
    <xsl:template match="tei:teiHeader|tei:cb"/>
    
</xsl:stylesheet>