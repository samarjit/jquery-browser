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
			<link type="text/css" href="APIBrowser.css" rel="stylesheet" />
			<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"  ></script>
			<script language="javascript">
			<![CDATA[
			function filterSnapshot(query){
			//var query = 'Fading';
			$('.snapshot div').each(function(i,v){ 
				//console.log($('span' ,$(v)).find('[class="'+query+'"]')); 
			if($('span' ,$(v)).find('[class="'+query+'"]').length == 0 ) { 		$(v).hide();    }
			else{ $(v).show();} 
			});
			}
			
			function removeFilter(){
			$('.snapshot div').each(function(i,v){
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
			
			function showDemo(obj){
				if(obj.innerHTML == "Demo"){ 
					var s = $("#demotext").val();
					s = s.replace("STYLEDATA",$(obj.parentNode).find(".css pre").html());
					s = s.replace("HTMLDATA",$(obj.parentNode).find(".html pre").text());
					s = s.replace("SCRIPTDATA",$(obj.parentNode).find(".code pre").html());
					var ifr = $("<iframe id='newifr' width='100%' height='200' style='display:none' />");
					 
					  $(obj.parentNode).append(ifr);
					ifrm =  ifr[0];
					ifrm = (ifrm.contentWindow) ? ifrm.contentWindow : (ifrm.contentDocument.document) ? ifrm.contentDocument.document : ifrm.contentDocument;
		            ifrm.document.open();
		            ifrm.document.write(s);
		            ifrm.document.close();
				    $(obj.parentNode).find("iframe").delay().fadeIn(1000); 
			    	obj.innerHTML = "Edit";
			    }
			    else if(obj.innerHTML == "Edit"){ 
			      $(obj.parentNode).find("iframe").remove();
				    	
				      if($(obj.parentNode).find(".edittextarea").length != 0){
				       $(obj.parentNode).find(".edittextarea").fadeIn(400);
				      
				      }else{
				       
				       var txtedit = $("<textarea type='text' class='edittextarea' style='width:100%;height:200px;display:none'   />");
					   $(obj.parentNode).append(txtedit);
					    var s = $("#demotext").val();
						s = s.replace("STYLEDATA",$(obj.parentNode).find(".css pre").html());
						s = s.replace("HTMLDATA",$(obj.parentNode).find(".html pre").text());
						s = s.replace("SCRIPTDATA",$(obj.parentNode).find(".code pre").html());
				    	txtedit.val(s);
				    	 txtedit.fadeIn(400);
				  }	
				  obj.innerHTML = "Edit Done";
			    }
			    else if(obj.innerHTML == "Edit Done"){
			     	var ifr = $("<iframe id='newifr' width='100%' height='200' style='display:none' />");
					 $(obj.parentNode).find(".edittextarea").fadeOut();
					  $(obj.parentNode).append(ifr);
					ifrm =  ifr[0];
					ifrm = (ifrm.contentWindow) ? ifrm.contentWindow : (ifrm.contentDocument.document) ? ifrm.contentDocument.document : ifrm.contentDocument;
		            ifrm.document.open();
		            ifrm.document.write($(obj.parentNode).find(".edittextarea").val());
		            ifrm.document.close();
				    $(obj.parentNode).find("iframe").delay().fadeIn(1000); 
			    	obj.innerHTML = "Edit";
			    }
			}
			function closeDemo(obj){
				var ifrmobj = $(obj.parentNode).find("iframe").slideUp(1000);
				ifrmobj.delay(1200).remove();
				$(obj.parentNode).find(".edittextarea").remove();
				$(obj).prev().html("Demo");
			}
			]]>
			</script>
		</head>
		<body>

			<h1>
				jQuery 1.4 Documentation
			</h1>

			<!--
				Apply templates to direct descendents of the
				root node (should be the CAT nodes).
			-->
			 
			<xsl:apply-templates />
			<xsl:call-template name="snapshot" /> 
			<textarea id="demotext" style="display:none" >
			  <![CDATA[ 
 <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="http://docs.jquery.com" />
<script src="http://code.jquery.com/jquery-1.4.4.js"></script>

<style>
 STYLEDATA
</style>
<script>
	function closeMe(){
		window.close();
	}
</script>

</head>
<body>
 HTMLDATA
<script>
 SCRIPTDATA
</script>
 
</body>
</html>
				]]>
			</textarea>
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


	<xsl:template match="method">

		<h3>
			<xsl:value-of select="@name" />

			<!-- Output the named params. -->
			<span class="params">
				<xsl:text>( </xsl:text>
				<xsl:for-each select="params">

					<xsl:value-of select="@name" />
					<xsl:if test="position() != last()">
						<xsl:text>, </xsl:text>
					</xsl:if>

				</xsl:for-each>
				<xsl:text> )</xsl:text>
			</span>
		</h3>

		<div class="methodbody">

			<xsl:apply-templates select="desc" />

			<xsl:if test="params">

				<h4>
					<xsl:text>Parameterss</xsl:text>
				</h4>

				<xsl:apply-templates select="params" />

			</xsl:if>

			<xsl:if test="options">

				<h4>
					<xsl:text>Hash Options</xsl:text>
				</h4>

				<xsl:apply-templates select="options" />

			</xsl:if>

			<xsl:if test="@type">

				<h4>
					<xsl:text>Returns</xsl:text>
				</h4>

				<p>
					<xsl:value-of select="@type" />
				</p>

			</xsl:if>

			<xsl:apply-templates select="examples" />

			<xsl:if test="see">

				<h4>
					<xsl:text>See Also</xsl:text>
				</h4>

				<p>
					<xsl:for-each select="see">
						<xsl:value-of select="." />
						<br />
					</xsl:for-each>
				</p>

			</xsl:if>

		</div>

	</xsl:template>


	<!--
		This template will match params or options
		which are formatted in the same way.
	-->
	<xsl:template match="params|options">

		<p>
			<xsl:if test="@name != ''">
				<strong>
					<xsl:value-of select="@name" />
				</strong>
				<xsl:text>: </xsl:text>
			</xsl:if>

			<xsl:if test="@type != ''">
				<em>
					<xsl:value-of select="@type" />
				</em>
				<xsl:text>: </xsl:text>
			</xsl:if>

			<xsl:value-of select="." />
		</p>

	</xsl:template>
	
	<xsl:template match="entry">
		<p> <xsl:text> | </xsl:text> </p>
		<p> <xsl:text>  </xsl:text> </p>
		<div class="entry" >
			<xsl:for-each select="category">	
						<xsl:call-template name="catlink"  />
			</xsl:for-each>	
			<a > <!-- <a name="jQuery.trim"/> for TOC link-->
			  <xsl:attribute name="name">
			  	<xsl:value-of select="@name" />
			  	<xsl:for-each select="signature/argument">
					<xsl:value-of select="@name" /> 
					<xsl:if test="position() != last()">
						<xsl:text></xsl:text>
					</xsl:if>
				</xsl:for-each>
			  </xsl:attribute>
			</a>
			 
			<div class="entrybanner">
			<h2>
			<xsl:if test="@type = 'selector'">
				<xsl:text>:</xsl:text>
			</xsl:if>
			 <xsl:value-of select="@name" />
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
			
			</h2>
			Type: <xsl:value-of select="@type" />
			<div style="float:right" >Returns: <xsl:value-of select="@return" /> </div>
				<xsl:if test="sample">	
					Sample: <xsl:value-of select="sample" />
				</xsl:if>
			</div>
					
			 <xsl:apply-templates />
		</div><!--  end of description -->
		 
		  
	</xsl:template>
	<xsl:template match="sample"  >
		
	</xsl:template>
		
	<xsl:template match="entry/category"  >
		  <xsl:variable name="myurl">
			    #<xsl:value-of select="../@name"     /> <xsl:value-of select="@name"     />
		  </xsl:variable>
		<span class="linkup">
			 
			 <a  > 
			     
			    <xsl:attribute name="onclick" >
			      $('#filter').val('<xsl:value-of select="@name" />')
			    </xsl:attribute>
			  <xsl:value-of select="@name"     /></a>
		</span><xsl:text> </xsl:text><!--  end of description -->
		
	</xsl:template>
	<xsl:template   name="catlink">
			<xsl:variable name="myurl">
			    <xsl:value-of select="../@name"     /> <xsl:value-of select="@name"     />
			</xsl:variable>
		<span   >
		 	
			 <a >
			  <xsl:attribute name="name">
			  	<xsl:value-of select="$myurl" />
			  </xsl:attribute>
			 </a>
		</span><xsl:text> </xsl:text><!--  end of description -->
		
	</xsl:template>
	 
	<xsl:template match="signature">
		<div class="signature">
		Arguments:<div class="version" style="float:right">Added: <xsl:value-of select="added"     /></div><br/>	
		        <xsl:for-each select="argument">

					(<b><xsl:value-of select="@name" />: </b>
					<xsl:value-of select="@type" /><xsl:text/>) 
					<i style="font-size:.8em;">Optional: <xsl:value-of select="@optional" /><xsl:text/></i>
					- <xsl:value-of select="desc" /> 
						<xsl:text></xsl:text>
					  	 
					<br/>
				</xsl:for-each>	
		</div> 

	</xsl:template>
		
	<xsl:template match="desc">

		<p class="description">
			<xsl:value-of select="."     />
		</p><!--  end of description -->

	</xsl:template>
	<xsl:template match="longdesc">

		 <xsl:for-each select="child::node()">
		   <xsl:variable name="addresses" select="/"/>
		   <xsl:variable name="var2" select="name()"/>
		   <xsl:variable name="vartxt" select="text()"/>
		   
		   <xsl:choose>
		    <xsl:when test="name()='code'"><span class="code"> <xsl:value-of select="."     /></span></xsl:when>
		    <xsl:when test="name()='p'"><p> <xsl:call-template name="code" /></p></xsl:when>
		    <xsl:when test="name()='blockquote'"><blockquote> <xsl:value-of select="."     /></blockquote></xsl:when>
		    <xsl:when test="name()='strong'"><strong> <xsl:value-of select="."     /></strong></xsl:when>
		    <xsl:when test="self::text()" >  <xsl:value-of select="."  disable-output-escaping="no"     /> </xsl:when>
		    <xsl:otherwise  >  
		    	<xsl:call-template name="code" /> 
			</xsl:otherwise>
		   </xsl:choose>
		   
		   <!--<xsl:if test="name()='code'">
		       <span class="code"> <xsl:value-of select="."     /></span>
		   </xsl:if>
		   <xsl:if test="name()='p'">
		      <p><xsl:call-template name="code" /></p> 
		   </xsl:if>
		   <xsl:if test="self::text()">
			<xsl:value-of select="."     />
		   </xsl:if>
			 
				 
		 --></xsl:for-each>
		 
	</xsl:template>	
	
	<xsl:template name="code">
		 <xsl:for-each select="child::node()">
		   <xsl:variable name="addresses" select="/"/>
		   <xsl:variable name="var2" select="name()"/>
		   <xsl:variable name="vartxt" select="text()"/>
		    
		   <xsl:choose>
		    <xsl:when test="name()='code'"><span class="code"> <xsl:value-of select="."     /></span></xsl:when>
		    <xsl:when test="name()='p'"><p> <xsl:value-of select="."     /></p></xsl:when>
		    <xsl:when test="name()='blockquote'"><blockquote> <xsl:value-of select="."     /></blockquote></xsl:when>
		    <xsl:when test="name()='strong'"><strong> <xsl:value-of select="."     /></strong></xsl:when>
		    <xsl:when test="name()='a'"><span class="code" ><a style="color: inherit;"><xsl:attribute name="href"><xsl:value-of select="@href"     />
		    								</xsl:attribute> <xsl:value-of select="."     />
		    							</a></span></xsl:when>
		    							
		    <xsl:when test="self::text()" >  <xsl:value-of select="."     /> </xsl:when>
		    <xsl:otherwise  >  
		    	<xsl:value-of select="."  disable-output-escaping="no"   /> 
			</xsl:otherwise>
		   </xsl:choose>
		   <!--<xsl:if test="name()='code'">
		       <span class="code"> <xsl:value-of select="."     /></span>
		   </xsl:if>
		   <xsl:if test="name()='p'">
		       <p><xsl:call-template name="code" /></p>
		   </xsl:if>
		   <xsl:if test="self::text()">
		       <xsl:value-of select="."     />
		   </xsl:if>
				 
		 --></xsl:for-each>
	 
	</xsl:template>

	<xsl:template match="code">
	 	<xsl:value-of select="."     />
	</xsl:template>	
	
	
		
	<xsl:template match="example">
	<div class="example">
		<h4>
			<xsl:text>Example</xsl:text>
		</h4>

		<xsl:if test="desc">
			<p>
				<xsl:value-of select="desc" />
			</p>
		</xsl:if>

		<xsl:if test="code">
			<pre>
				<xsl:value-of select="code" />
			</pre>
		</xsl:if>

		<xsl:if test="before">
			<h5>
				<xsl:text>Before</xsl:text>
			</h5>

			<p>
				<xsl:value-of select="before" />
			</p>
		</xsl:if>

		<xsl:if test="results">
			<h5>
				<xsl:text>Result</xsl:text>
			</h5>

			<pre>
				<xsl:value-of select="results" />
			</pre>
		</xsl:if>
		<xsl:if test="css">
			<h5>
				<xsl:text>CSS</xsl:text>
			</h5>
			<div class="css">
			<pre>
				<xsl:value-of select="css" />
			</pre>
			</div>
		</xsl:if>
		<xsl:if test="code">
			<h5>
				<xsl:text>Code</xsl:text>
			</h5>
			<div class="code">
			<pre>
				<xsl:value-of select="code" />
			</pre>
			</div>
		</xsl:if>
		<xsl:if test="html">
			<h5>
				<xsl:text>HTML</xsl:text>
			</h5>
			<div class="html">
			<pre>
				<xsl:value-of select="html" />
			</pre>
			</div>
		</xsl:if>	
			<button type="button" onclick="showDemo(this);">Demo</button>
			<button type="button" onclick="closeDemo(this);">Close</button>
		</div>
	</xsl:template>
	<xsl:template match="note">
		<xsl:call-template name="code"></xsl:call-template>
	</xsl:template>
	<xsl:template name="snapshot">
		<div class="snapshot">
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