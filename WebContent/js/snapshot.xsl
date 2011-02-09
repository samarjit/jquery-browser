<?xml version="1.0"  encoding="ISO-8859-1"?>
 
<xsl:transform
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output
		omit-xml-declaration="yes"
		method="html"
		version="1.0"
		encoding="ISO-8859-1"
		doctype-public="-//W3C//DTD Xhtml 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
		indent="yes"
		media-type="text/html"
		/>
<!--xsl:output method="html" version="4.01" encoding="utf-8" standalone="no" indent="yes"
media-type="text/html"/-->

	<!-- Match the root-level node. -->
	<xsl:template match="/">
	<html>
		<head>
			<title>jQuery Documentation</title>
			<link REL="SHORTCUT ICON" HREF="jqapi.ico" />
			<link type="text/css" href="APIBrowsersnapshot.css" rel="stylesheet" />
			<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"  ></script>
			<script language="javascript">
			<![CDATA[
			function filterSnapshot(query){
			//var query = 'Fading';
			$('.snapshotfloat div').each(function(i,v){ 
				//console.log($('span' ,$(v)).find('[class="'+query+'"]')); 
					if($('span' ,$(v)).find('[class="'+query+'"]').length == 0 ) { 		$(v).hide();    }
					else{ $(v).show();} 
				});
				alert("done");
			}
			
			function removeFilter(){
			$('.snapshotfloat div').each(function(i,v){
				$(v).show();
			});
			}
			]]>
			</script>
		</head>
		<body>
		   <xsl:call-template name="snapshot" /> 
		</body>
	</html>
	</xsl:template>
	
	<xsl:template name="snapshot">
		<div class="snapshotfloat">
		 <input id="filter" />
		   <button type="button"
		     onclick="filterSnapshot($('#filter').val())">Go</button>
		   <button type="button"
		     onclick="removeFilter()">Clear</button>  
		  	<xsl:for-each select="api/entries/entry">
				<div >
					
					<a>
					    <xsl:attribute name="href">
							#<xsl:value-of select="@name" />
							<xsl:for-each select="signature/argument">
									<xsl:value-of select="@name" /> 
									<xsl:if test="position() != last()">
										<xsl:text></xsl:text>
									</xsl:if>
								</xsl:for-each>
					    </xsl:attribute>
					   
						<b><xsl:value-of select="@name" />
							<xsl:if test="signature/argument">	
							(
								<xsl:for-each select="signature/argument">
									<xsl:value-of select="@name" /> 
									<xsl:if test="position() != last()">
										<xsl:text>, </xsl:text>
									</xsl:if>
								</xsl:for-each>
							)
							</xsl:if>
						</b>
					</a>
					<xsl:for-each select="category">
							  <xsl:variable name="addr">
							       <xsl:value-of select="name()"></xsl:value-of>
							   </xsl:variable> 
							<span class="linkup">
								<span>
								<xsl:attribute name="class">
									<xsl:value-of select="@name"     />
								</xsl:attribute>

									<xsl:variable name="myurl">
									#<xsl:value-of select="../@name"     /> <xsl:value-of select="@name"     />
									</xsl:variable>
									<a>
										<xsl:attribute name="href">
											  	<xsl:value-of select="$myurl" />
										</xsl:attribute>
										<xsl:attribute name="onclick" >
									      $('#filter').val('<xsl:value-of select="@name" />')
									    </xsl:attribute>
										<xsl:value-of select="@name" />
									</a>
								</span>
							</span>
				  
						
					</xsl:for-each>
							<br/>
							<xsl:value-of select="desc" />
				</div>
			</xsl:for-each>
		</div>
	</xsl:template>
	
</xsl:transform>
			