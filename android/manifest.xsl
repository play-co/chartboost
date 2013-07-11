<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:android="http://schemas.android.com/apk/res/android">

	<xsl:param name="ChartboostAppID" />
	<xsl:param name="ChartboostAppSignature" />

	<xsl:output indent="yes" />
	<xsl:template match="comment()" />

	<xsl:template match="meta-data[@android:name='CHARTBOOST_APP_ID']">
		<meta-data android:name="CHARTBOOST_APP_ID" android:value="{$ChartboostAppID}"/>
	</xsl:template>

	<xsl:template match="meta-data[@android:name='CHARTBOOST_APP_SIGNATURE']">
		<meta-data android:name="CHARTBOOST_APP_SIGNATURE" android:value="{$ChartboostAppSignature}"/>
	</xsl:template>

	<xsl:output indent="yes" />
	<xsl:template match="comment()" />

	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
