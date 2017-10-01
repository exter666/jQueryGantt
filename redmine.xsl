<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text"/>

    <xsl:template name="escapeQuote">
      <xsl:param name="pText"/>

      <xsl:if test="string-length($pText) >0">
       <xsl:value-of select=
        "substring-before(concat($pText, '&quot;'), '&quot;')"/>

       <xsl:if test="contains($pText, '&quot;')">
        <xsl:text>\"</xsl:text>

        <xsl:call-template name="escapeQuote">
          <xsl:with-param name="pText" select=
          "substring-after($pText, '&quot;')"/>
        </xsl:call-template>
       </xsl:if>
      </xsl:if>
    </xsl:template>

    <xsl:template match="issues">

        {
        "tasks":[
        <xsl:apply-templates/>
        ],
        "resources":[],
        "roles":[],
        "canWrite":false,
        "canWriteOnParent":false,
        "selectedRow":0,
        "deletedTaskIds":[]
        }
    </xsl:template>

    <xsl:template match="issue">
        <xsl:variable name="name">
            <xsl:value-of select="id/."/> - <xsl:value-of select="subject/."/>
        </xsl:variable>
        {
            "id":"<xsl:value-of select="id/."/>",
            "parentId":"<xsl:value-of select="parent/@id"/>",
            "name":"<xsl:call-template name="escapeQuote"><xsl:with-param name="pText" select="$name"/></xsl:call-template>",
            "code":"",
            "status":"STATUS_ACTIVE",
            "start":1346623200000,
            "duration":<xsl:value-of select="estimated_hours/. div 24 "/>,
            "end":1347055199999,
            "startIsMilestone":false,
            "endIsMilestone":false,
            "assigs":[ ],
            "depends":"",
            "description":"",
            "progress":<xsl:value-of select="done_ratio/."/>
        }<xsl:if test="position() != last()">,</xsl:if>
    </xsl:template>

</xsl:stylesheet>