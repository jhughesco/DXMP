<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.TemplateBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls" TagPrefix="xmod" %>
<xmod:masterview runat="server">
<xmod:ScriptBlock runat="server" ScriptId="RecentAds" BlockType="HeadScript" RegisterOnce="True">
  <style type="text/css">
    #Popup_Modal .modal-body {
      background:url("/images/loading.gif") center no-repeat;
      overflow-y: hidden;
    }
    #RecentAds {
      margin-left: 0px;
      border: 1px solid #ebebeb;
      border-radius: 2px;
      position: relative;
    }
    
    #RecentAds li.media {
      border-bottom: 1px solid #ebebeb;
      margin-top: 0px;
      position: relative;      
    }
    
    #RecentAds li.media:nth-child(odd) { background: #f1f1f1; }
    
    #RecentAds li.media a {
      text-decoration: none;
    }
    
    #RecentAds li.media .fa-picture-o {
      font-size: 28px;
    	padding: 35px;
    }
    
    #RecentAds li.media .fa-expand {
      opacity: 0;      
      position: absolute;
      right: 10px;
      top: 10px;
    }
    
    #RecentAds li.media:hover .fa-expand {
      opacity: 1;
    }
    
    #RecentAds li.media .media-left {
      padding: 0px;
      background: white;
    }
    
    #RecentAds li.media .media-body {
      border-left: 1px dashed #ebebeb;
      padding: 5px 0 5px 10px !important;
    }
    
    #RecentAds li.media .media-body h4 {
     	text-align: left !important; 
    }
    #RecentAds li.media .media-body h5 {
     	text-align: left !important; 
    }
    
    #RecentAds li.media .media-body div {
     	text-align: left !important; 
    }
    
    .media {
      margin-top: 0px !important;
      border-bottom: solid 1px #e4e4e4 !important; 
    }
    
    .media-heading {
     	margin-top: 2px !important; 
    }
    
    .media-body {
      padding: 0 !important;
    }
    .ribbon-box {
      position: relative;
      border: 1px solid transparent;
    }
    .ribbon {
      position: absolute;
      right: -5px; top: -5px;
      z-index: 1;
      overflow: hidden;
      width: 75px; height: 75px;
      text-align: right;
    }
    .ribbon span {
      font-size: 10px;
      font-weight: bold;
      color: #FFF;
      text-transform: uppercase;
      text-align: center;
      line-height: 20px;
      transform: rotate(45deg);
      -webkit-transform: rotate(45deg);
      width: 100px;
      display: block;
      background: #79A70A;
      background: linear-gradient(#F70505 0%, #8F0808 100%);
      box-shadow: 0 3px 10px -5px rgba(0, 0, 0, 1);
      position: absolute;
      top: 19px; right: -21px;
    }
    .ribbon span::before {
      content: "";
      position: absolute; left: 0px; top: 100%;
      z-index: -1;
      border-left: 3px solid #8F0808;
      border-right: 3px solid transparent;
      border-bottom: 3px solid transparent;
      border-top: 3px solid #8F0808;
    }
    .ribbon span::after {
      content: "";
      position: absolute; right: 0px; top: 100%;
      z-index: -1;
      border-left: 3px solid transparent;
      border-right: 3px solid #8F0808;
      border-bottom: 3px solid transparent;
      border-top: 3px solid #8F0808;
    }
           	
  </style>
</xmod:ScriptBlock>

<xmod:Template runat="server" UsePaging="False">

  <ListDataSource CommandText="SELECT TOP 25 * FROM vw_XMP_All_Ads ORDER BY Date_Created DESC">
  </ListDataSource>
  
  <HeaderTemplate>
  	<div class="ribbon-box">
      <div class="ribbon"><span>RECENT ADs!</span></div>
    	<ul id="RecentAds" class="media-list">
  </HeaderTemplate>
  
	<ItemTemplate>
    <li class="media">
      <div class="media-left media-middle">
        <a data-toggle="modal" 
           data-target="#Popup_Modal" 
           data-id="<%#Eval("Values")("AdID")%>" 
           data-title="<%#Eval("Values")("Ad_Title")%>"
           data-source="/Ads/Details/Popup?AdID=<%#Eval("Values")("AdID")%>"
           href="#">
          <xmod:IfNotEmpty runat="server" Value='<%#Eval("Values")("PrimaryImage")%>'>
            <img class="img-responsive center-block" alt="<%#Eval("Values")("Ad_Title")%>" src="/Portals/<%#PortalData("ID")%>/Classifieds/Ads/<%#Eval("Values")("SellerID")%>/thm_<%#Eval("Values")("PrimaryImage")%>" />
          </xmod:IfNotEmpty>
          <xmod:IfEmpty runat="server" Value='<%#Eval("Values")("PrimaryImage")%>'>
            <img class="img-responsive center-block" alt="<%#Eval("Values")("Ad_Title")%>" src="http://placehold.it/80?text=no+image" />
          </xmod:IfEmpty>
        </a>
      </div>
      <div class="media-body">
        <h4 class="media-heading">
          <a data-toggle="modal" data-target="#Popup_Modal" data-id="<%#Eval("Values")("AdID")%>" data-title="<%#Eval("Values")("Ad_Title")%>" href="#"><%#Eval("Values")("Ad_Title")%></a>
        </h4>
        <h5>
          <xmod:IfNotEmpty runat="server" Value='<%#Eval("Values")("Ad_Price")%>'>
            <span class="label label-success"><xmod:Format runat="server" Type="Float" Value='<%#Eval("Values")("Ad_Price")%>' Pattern="c" /></span>
          </xmod:IfNotEmpty>
          <xmod:IfEmpty runat="server" Value='<%#Eval("Values")("Ad_Price")%>'>
            <span class="label label-primary">FREE!</span>
          </xmod:IfEmpty>
            <small><%#Eval("Values")("Location")%></small>
        </h5>            
        <div>
          <%#Eval("Values")("Ad_Summary")%>
        </div>
      </div>
    </li>
  </ItemTemplate>
  
  <FooterTemplate>
  		</ul>
    </div>
    <a href="/Ads" class="btn btn-block btn-primary" style="color: white">See em' all!</a>
  </FooterTemplate>
  
</xmod:Template>

<div class="modal fade" id="Popup_Modal" tabindex="-1" role="dialog" aria-labelledby="Popup_Modal">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header" style="height: 56px">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">&nbsp;</h4>
      </div>
      <div class="modal-body">&nbsp;</div>
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
          title = $invoker.data("title"),
      		source = $invoker.data("source");
      
      // Now that we have the title of the ad, and id of the ad, we can populate:      
      $modal.find('.modal-title').html(title);
      
      var iframe = $('<iframe />', {
        style: 'overflow-y:auto;height:100%;width:100%',
        src: source    						 
      });
  
  		$modal.find('.modal-body').html(iframe);
      			
		});
    
    // In the event that the browser window is resized, we need to resize the modal on the fly
    $(window).resize(function() {
      ResizeModal($modal);
    });  
    
    $('.modal').on('hide.bs.modal', function(e) {
      // When a modal is closed, we need to destroy it.
      $(this).find('iframe').remove();
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