<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:soc="http://driolar.org/SoccerML">
    <xsl:output method="xml" indent="yes"/>        

    <!-- identity template -->
    <xsl:template match="@*|node()" >
    <xsl:copy>        
            <xsl:apply-templates select="@*|node()" />
    </xsl:copy>    
    </xsl:template>
    
    <xsl:template match="soc:Ball">        
        <xsl:copy>        
            <xsl:apply-templates select="@*|node()" />
            <xsl:apply-templates select="parent::soc:Frame" mode="possession" />
        </xsl:copy>                  
    </xsl:template>
    
    <xsl:template match="soc:Frame" mode="possession">        
        <xsl:choose>
            <xsl:when test="soc:Player[@isKicking='true' or @isCatching='true']/@team='l' or soc:Player[@isKicking='true' or @isCatching='true']/@team='r'">
                <soc:PossessingTeam><xsl:value-of select="soc:Player[@isKicking='true' or @isCatching='true']/@team"/></soc:PossessingTeam>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="(preceding-sibling::soc:PlayIncidence | preceding-sibling::soc:Frame)[last()]" mode="possession"></xsl:apply-templates>                
            </xsl:otherwise>
        </xsl:choose>        
    </xsl:template>
    
    <xsl:template match="soc:PlayIncidence" mode="possession">
        <xsl:choose>
            <xsl:when test="soc:PossessingTeam">
                <xsl:copy-of select="soc:PossessingTeam"/>                
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="(preceding-sibling::soc:PlayIncidence | preceding-sibling::soc:Frame)[last()]" mode="possession"></xsl:apply-templates>                
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    
</xsl:stylesheet>
