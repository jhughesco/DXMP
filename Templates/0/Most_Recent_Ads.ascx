<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.TemplateBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls" TagPrefix="xmod" %>
<xmod:masterview runat="server">
<xmod:ScriptBlock runat="server" ScriptId="RecentAds" BlockType="HeadScript" RegisterOnce="True">
  <style type="text/css">
    #Popup_Modal .modal-body {
      background:url("/images/loading.gif") center no-repeat;
    }
  </style>
</xmod:ScriptBlock>

<xmod:Template runat="server" UsePaging="False">

  <ListDataSource CommandText="SELECT TOP 25
                               a.[AdID]
                               ,a.[SellerID]
                               ,loc.City + ', ' + loc.State AS Location
                               ,a.[Ad_Title]
                               ,a.[Ad_Summary]
                               ,a.[Ad_Price]
                               ,a.[PrimaryImage]

                               FROM XMP_Classified_Ad a
                               LEFT JOIN XMP_Classified_Location loc ON a.LocationID = loc.LocationID
                               ORDER BY a.[Date_Created] DESC">
  </ListDataSource>
  
  <HeaderTemplate>
  	<ul class="media-list">
  </HeaderTemplate>
  
	<ItemTemplate>
    	<li class="media">
        <div class="media-left">
          <a data-toggle="modal" data-target="#Popup_Modal" data-id="<%#Eval("Values")("AdID")%>" data-title="<%#Eval("Values")("Ad_Title")%>" href="#">
            <xmod:IfNotEmpty runat="server" Value='<%#Eval("Values")("PrimaryImage")%>'>
              <img class="media-object" alt="<%#Eval("Values")("Ad_Title")%>" src="/Portals/<%#PortalData("ID")%>/Classifieds/Ads/<%#Eval("Values")("SellerID")%>/thm_<%#Eval("Values")("PrimaryImage")%>" />
            </xmod:IfNotEmpty>
            <xmod:IfEmpty runat="server" Value='<%#Eval("Values")("PrimaryImage")%>'>
              <img class="media-object" alt="<%#Eval("Values")("Ad_Title")%>" src="http://placehold.it/100x100?text=no+image" />
            </xmod:IfEmpty>
          </a>
        </div>
        <div class="media-body">
          <h4 class="media-heading">
            <a data-toggle="modal" data-target="#Popup_Modal" data-id="<%#Eval("Values")("AdID")%>" data-title="<%#Eval("Values")("Ad_Title")%>" href="#"><%#Eval("Values")("Ad_Title")%></a>
          </h4>
          <h5>
            <xmod:IfNotEmpty runat="server" Value='<%#Eval("Values")("Ad_Price")%>'>
              <xmod:Format runat="server" Type="Float" Value='<%#Eval("Values")("Ad_Price")%>' Pattern="c" />
            </xmod:IfNotEmpty>
            <xmod:IfEmpty runat="server" Value='<%#Eval("Values")("Ad_Price")%>'>
              FREE!
            </xmod:IfEmpty>
             - <%#Eval("Values")("Location")%>
          </h5>            
          <div>
            <%#Eval("Values")("Ad_Summary")%>
          </div>
        </div>
      </li>
    
  </ItemTemplate>
  
  <FooterTemplate>
  	</ul>
  </FooterTemplate>
  
</xmod:Template>

<div class="modal fade" id="Popup_Modal" tabindex="-1" role="dialog" aria-labelledby="Popup_Modal">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header" style="height: 56px">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">&nbsp;</h4>
      </div>
      <div class="modal-body">
        <iframe style="overflow:hidden;height:100%;width:100%"></iframe>        
      </div>
      <div class="modal-footer" style="height: 65px">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>        
      </div>
    </div>
  </div>
</div>

<script>
  $(document).ready(function() {
		
    // Helps prevent styling conflict on certain browsers
    $('.modal').appendTo('body');
    
    // Caching the popup so we don't have to keep looking for it
    var $modal = $('#Popup_Modal');

    // Sizing it initially although hidden from view to prevent first load size jump
    ResizeModal($modal);
    
    $modal.on('shown.bs.modal',function(e){
      // Prevent any default behavior
      e.preventDefault();
      
      // The invoker is the link that was clicked on where we hide data attributes
      var $invoker = $(e.relatedTarget),
          id = $invoker.data("id"),
          title = $invoker.data("title");
      
      // Now that we have the title of the ad, and id of the ad, we can populate:      
      $modal.find('.modal-title').html(title);
      $modal.find('iframe').attr("src", "/Ads/Details/Popup?AdID=" + id);
			
		});
    
    // In the event that the browser window is resized, we need to resize the modal on the fly
    $(window).resize(function() {
      ResizeModal($modal);
    });  
    
    $('.modal').on('hide.bs.modal', function(e) {
      // When a modal is closed, we need to wipe out the src attribute.
      $(this).find('iframe').removeAttr("src");      
    });
    
    
  });
  
  function ResizeModal($modal) {
    $modal.find('.modal-content').css('height', $(window).height()*0.8);
            
    // Simple math. Grab the total height and remove the header and footer from it, leaving us with the correct size for the body
    var totalHeight = parseInt($modal.find('.modal-content').css("height")),
        headerHeight = parseInt($modal.find('.modal-header').css("height")),
        footerHeight = parseInt($modal.find('.modal-footer').css("height")),
        bodyHeight = totalHeight - headerHeight - footerHeight;
    
    // Finally, force sizing on the modal body
    $modal.find('.modal-body').css("height", bodyHeight + "px");		
    
  }
  
</script></xmod:masterview>