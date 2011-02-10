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
			<script type="text/javascript" src="http://code.jquery.com/jquery-1.5.min.js"  ></script>
			<script language="javascript">
			<![CDATA[
			function filterSnapshot(query){
			//var query = 'Fading';
			$('.snapshotfloat div').each(function(i,v){ 
				
				//console.log($(v).find('span [class="'+query+'"]')); 
					if($(v).find('span [class="'+query+'"]').length == 0 ) { 		$(v).hide();    }
					else{ $(v).show();} 
				});
				 
			}
			
			function removeFilter(){
			$('.snapshotfloat div').each(function(i,v){
				$(v).show();
			});
			}
			
			function fixMenu(){
			  $(".menuhead").css("position","fixed");
			   $(".menuhead").css("height","100%");
			}
			function floatMenu(){
			  $(".menuhead").css("position","absolute");
			  $(".menuhead").css("height","auto");
			}
			
			]]>
			</script>
		</head>
		<body>
			<h1>
				jQuery 1.4 Documentation
			</h1>
			<xsl:apply-templates    select="api/categories"   />
		   <xsl:call-template name="snapshot" /> 
		</body>
	</html>
	</xsl:template>
	<xsl:template match="categories">
		<div class="menuhead">
		<xsl:apply-templates select="category"/>
		</div>
		<span class="fixfloatmenu" >
		 <button type="button" onclick="fixMenu()">Fix Menu</button>
		 <button type="button" onclick="floatMenu()">FLoat Menu</button>
		</span>
	</xsl:template>
	<xsl:template match="category">

		<span class="menu">
			<!--
				Check to see if this category is a
				sub-category. If so, we have to add the
				conditional class attribute.
			-->
			<xsl:attribute name="onclick">
					<xsl:text>filterSnapshot('</xsl:text>
					<xsl:value-of select="@name" />
					<xsl:text>')</xsl:text>
			</xsl:attribute>
			<xsl:if test="../../category">
				<xsl:attribute name="class">
					<xsl:text>sub</xsl:text>
				</xsl:attribute>
				
			</xsl:if>

			<xsl:value-of select="@name" /><br/>
		</span>

		<!--
			Apply templates to all direct descendents of the
			current category node.
		-->
		<xsl:apply-templates />

	</xsl:template>
	<xsl:template name="snapshot">
		 <div class="filterpanel">
			  <form><input type="text" id="filter" /> <button type="button" 
			     onclick="filterSnapshot($('#filter').val())">Go</button>
			   <button type="button"
			     onclick="removeFilter()">Clear</button>
			     </form>
		</div>
		<div class="snapshotfloat">
		      
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
			