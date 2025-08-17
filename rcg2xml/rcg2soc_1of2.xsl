<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:soc="http://driolar.org/SoccerML">
    <xsl:output method="xml" indent="yes"/>    
    <xsl:variable name="possessionPlayModes">'kick_off_l kick_off_r free_kick_l free_kick_r goal_kick_l goal_kick_r kick_in_l kick_in_r corner_kick_l corner_kick_r'</xsl:variable>
<xsl:template match="RCG">    
    <DRIOLAR>
    <xsl:comment>
        Created using <xsl:value-of select="system-property('xsl:vendor')"/>
    </xsl:comment>
    <soc:Header>
        <soc:Source>Robocup Log File Version <xsl:value-of select="@version"/></soc:Source>
        <soc:Rules>
            <soc:Offside>
                <xsl:choose>
                    <xsl:when test="ServerParam/Param[@name='use_offside']='1'">1925</xsl:when>
                    <xsl:otherwise>none</xsl:otherwise>
                </xsl:choose>                
            </soc:Offside>
        </soc:Rules>
        <soc:Pitch unit="meter">
            <!-->Apparently parameters goal_length and and goal_width are not provided by RoboCup logfile.<-->
            <soc:Length>105</soc:Length>
            <soc:Width>68</soc:Width>
            <soc:GoalWidth>
                <xsl:value-of select="ServerParam/Param[@name='goal_width' or @name='gwidth']"/>
            </soc:GoalWidth>
        </soc:Pitch>
    </soc:Header>
    <soc:Sequence>
        <xsl:apply-templates select="PlayMode | Team | ShowInfo"/>        
    </soc:Sequence>
    </DRIOLAR>
</xsl:template>
    
<xsl:template match="PlayMode">
    <soc:PlayIncidence>
        <soc:RobocupPlayMode>
            <xsl:value-of select="."/>            
        </soc:RobocupPlayMode>
        <xsl:call-template name="possessingTeam">
            <xsl:with-param name="playMode" select="."/>
        </xsl:call-template>        
    </soc:PlayIncidence>
</xsl:template>
    
<xsl:template match="ShowInfo">
  <soc:Frame>
      <xsl:attribute name="time">
          <xsl:value-of select="@time"/>
      </xsl:attribute>
      <xsl:apply-templates select="Ball" />
      <xsl:apply-templates select="Player" />
  </soc:Frame>  
</xsl:template>       

<xsl:template match="Ball">
    <soc:Ball>        
        <soc:X><xsl:value-of select="X"/></soc:X>
        <soc:Y><xsl:value-of select="Y"/></soc:Y>        
    </soc:Ball>
</xsl:template>

<xsl:template match="Player">
    <soc:Player>
        <xsl:attribute name="team"><xsl:value-of select="@side"/></xsl:attribute>
        <xsl:attribute name="number"><xsl:value-of select="@unum"/></xsl:attribute>                        
        <xsl:call-template name="isKicking">
             <xsl:with-param name="modeValue" select="@mode"/>
        </xsl:call-template>                
        <xsl:call-template name="isGoalie">
                <xsl:with-param name="modeValue" select="@mode"/>
        </xsl:call-template>                
        <xsl:call-template name="isCatching">
                <xsl:with-param name="modeValue" select="@mode"/>
        </xsl:call-template>        
        <soc:X><xsl:value-of select="X"/></soc:X>
        <soc:Y><xsl:value-of select="Y"/></soc:Y>
    </soc:Player>
</xsl:template>

<xsl:template match="Team">
    <soc:Team>
        <xsl:attribute name="side"><xsl:value-of select="@side"/></xsl:attribute>
        <soc:TeamName><xsl:value-of select="Name"/></soc:TeamName>
        <xsl:if test="Score">
            <soc:Score><xsl:value-of select="Score"/></soc:Score>
        </xsl:if>
    </soc:Team>
</xsl:template>
    
<xsl:template name="isKicking">
    <xsl:param name="modeValue" select="0"/>
       <xsl:choose>
           <xsl:when test="(floor($modeValue div 2) mod 2) = 1">
               <xsl:attribute name="isKicking">true</xsl:attribute>
           </xsl:when>
           <xsl:otherwise/>
        </xsl:choose>        
</xsl:template>

<xsl:template name="isGoalie">
    <xsl:param name="modeValue" select="0"/>
       <xsl:choose>
            <xsl:when test="(floor(floor(floor($modeValue div 2) div 2) div 2) mod 2) = 1">
                <xsl:attribute name="isGoalie">true</xsl:attribute>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>        
</xsl:template>
    
<xsl:template name="isCatching">
    <xsl:param name="modeValue" select="0"/>
       <xsl:choose>
            <xsl:when test="(floor(floor(floor(floor($modeValue div 2) div 2) div 2) div 2) mod 2) = 1">
                <xsl:attribute name="isCatching">true</xsl:attribute>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>        
</xsl:template>        
    
<xsl:template name="possessingTeam">
    <xsl:param name="playMode" />
    <xsl:if test="contains($possessionPlayModes, $playMode)">
        <xsl:choose>
            <!-- ends-with function only supported by XPath 2.0 -->
            <xsl:when test="substring($playMode, string-length($playMode) - 1) = '_l'">            
                <soc:PossessingTeam>l</soc:PossessingTeam>
            </xsl:when>
            <xsl:when test="substring($playMode, string-length($playMode) - 1) = '_r'">            
                <soc:PossessingTeam>r</soc:PossessingTeam>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>        
    </xsl:if>        
</xsl:template>    
    
</xsl:stylesheet>
