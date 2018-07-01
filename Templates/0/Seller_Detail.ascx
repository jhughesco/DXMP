<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.TemplateBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls" TagPrefix="xmod" %>
<xmod:masterview runat="server">
<xmod:ScriptBlock runat="server" ScriptId="SellerCSS" BlockType="HeadScript" RegisterOnce="True">
  <style type="text/css">
    
    #Body { background: #fff; }
    
    #Contact_Modal .modal-body,
    #Popup_Modal .modal-body,
    #Reply_Modal .modal-body {
      background:url("/images/loading.gif") center no-repeat;
      overflow-y: hidden;
    }

    
    ul.seller-address {
      list-style: none;
      margin-left: 0px;
    }
    
    #AllSellers div.media.ad {
      border: 1px solid #ebebeb;
      border-radius: 2px;
      position: relative;
      margin-bottom: 25px;
      background: white;
    }

    #AllSellers div.media-left.middle {
      vertical-align: middle; 
    }

    #AllSellers div.media a {
      text-decoration: none;
    }

    #AllSellers div.media img {
      max-height: 100px;
    }

    #AllSellers div.media .fa-picture-o {
      font-size: 28px;
      padding: 35px;
    }
    
    #AllSellers div.media .fa-expand {
        opacity: 0;      
        position: absolute;
        right: 10px;
        top: 10px;
      }

    #AllSellers div.media:hover .fa-expand {
        opacity: 1;
      }

    #AllSellers div.media .media-left {
      padding: 0px;
      background: white;
      height: 130px;
    }

    #AllSellers div.media .media-body {
      border-left: 1px dashed #ebebeb;
      padding: 5px 0 5px 10px;
    }

    .pager-active {
      color: #fff !important;
      background-color: #337ab7 !important;
      border-color: #337ab7 !important;
    }

    ol.breadcrumb { margin-left: 0px; margin-top: 40px; }
    
    .top10 { margin-top: 10px; }
  </style>    
</xmod:ScriptBlock>
<xmod:Template runat="server" id="SellerProfile" >
  <ListDataSource CommandText="SELECT * 
                               FROM vw_XMP_All_Sellers
                               WHERE Agree=1 AND Banned=0 AND IsDeleted=0 AND Authorised=1 AND UserIsDeleted=0 AND SellerID = @SellerID">
    <Parameter Name="SellerID" Value='<%#UrlData("SellerID")%>' DataType="Int32" />
  </ListDataSource>
  <DetailDataSource CommandText=""/>
  <DeleteCommand CommandText=""/>
  <HeaderTemplate>
    
  </HeaderTemplate>
  
  <ItemTemplate>
  
    <xmod:metatags runat="server">
      <Title><%#Eval("Values")("Seller_Name")%> in <%#Eval("Values")("CityState")%></Title>
      <Description>Browse ads by <%#Eval("Values")("Seller_Name")%> on acich.org!</Description>      
    </xmod:metatags>
    
    <xmod:IfNotEmpty runat="server" Value='<%#Eval("Values")("Seller_Image")%>'>
      <div class="row">
        <div class="col-xs-12 text-center">
          <img class="img-thumbnail img-responsive" alt="<%#Eval("Values")("Seller_Name")%>" src="/Portals/<%#PortalData("ID")%>/Classifieds/SellerImages/sm_<%#Eval("Values")("Seller_Image")%>" />
        </div>
      </div>    
    </xmod:IfNotEmpty>

    <div class="row">
      <div class="col-xs-12 text-center">
        <h1>
          <%#Eval("Values")("Seller_Name")%> <small>in</small> <%#Eval("Values")("CityState")%>
        </h1>
      </div>
    </div>

    <xmod:Select runat="server">
      <Case Comparetype="Role" Operator="=" Expression="Registered Users">
        <div class="row">
          <div class="col-xs-12 text-center">
            <ul class="seller-address">
              <xmod:Select runat="server" Mode="Inclusive">
                <Case Comparetype="Boolean" Value='<%#Eval("Values")("ShowAddress")%>' Operator="=" Expression="True">
                  <li><%#Eval("Values")("Seller_Address")%></li>
                  <li><%#Eval("Values")("CityState")%></li>
                </Case>
                <Case Comparetype="Boolean" Value='<%#Eval("Values")("ShowPhone")%>' Operator="=" Expression="True">
            	    <li><%#Eval("Values")("Seller_Phone")%></li>
                </Case>                  
              </xmod:Select>              
            </ul>
            <a class="btn btn-warning" data-toggle="modal" data-target="#Contact_Modal" data-title="<%#Eval("Values")("Seller_Name")%>" data-source="/Sellers/Details/Contact?SellerID=<%#Eval("Values")("SellerID")%>" href="#">Send me a message!</a>
          </div>
        </div>      	
      </Case>
      <Else>
        <div class="alert alert-warning text-center" style="max-width: 500px; margin: auto">
          To view contact details or contact this seller, you must<br/><a style="margin-top: 5px" class="btn btn-default btn-sm" href="/Join" target="_blank">Create a Free Account</a>
        </div>
      </Else>
    </xmod:Select>
    
  </ItemTemplate>
  
  <NoItemsTemplate>
  	
    <div class="row">
      <div class="col-sm-12 text-center">
        <i class="fa fa-warning" style="font-size: 5em; display: block"></i>
        <h3>We're sorry. This seller no longer exists.</h3>
        <h4>Feel free to browse the rest of the site while you're here!</h4>
      </div>
    </div>
    
  </NoItemsTemplate>
  
  <FooterTemplate>
      
  </FooterTemplate>

  <DetailTemplate>

    <xmod:ReturnLink runat="server" CssClass="dnnSecondaryAction" Text="&lt;&lt; Return" />

  </DetailTemplate>
</xmod:Template>




<xmod:Template runat="server" ID="SellerAds" UsePaging="True" Ajax="True">
  <ListDataSource CommandText="SELECT 
                                a.[AdID]
                               ,a.[SellerID]
                               ,loc.City + ', ' + loc.State AS CityState
                               ,a.[Ad_Title]
                               ,a.[Ad_Summary]
                               ,a.[Ad_Price]
                               ,a.[PrimaryImage]
                               ,s.[UserID] AS SellerUserID

                               FROM XMP_Classified_Ad a
                               LEFT JOIN XMP_Classified_Location loc ON a.LocationID = loc.LocationID
                               INNER JOIN XMP_Classified_Seller s ON a.SellerID = s.SellerID
                               INNER JOIN Users u ON s.UserID = u.UserID
                               INNER JOIN UserPortals up ON s.UserID = up.UserID
                               WHERE a.Approved = 1
                               AND a.Active = 1
                               AND a.Ad_Expires > getdate()
                               AND s.Banned = 0
                               AND s.IsDeleted = 0
                               AND up.IsDeleted = 0                               
                               AND up.Authorised = 1
                               AND s.SellerID = @SellerID
                               ORDER BY a.[Date_Created] DESC">

    <Parameter Name="SellerID" Value='<%#UrlData("SellerID")%>' DataType="Int32" />

  </ListDataSource>

  <Pager 
     PageSize="50" 
     ShowTopPager="False" 
     ShowBottomPager="True" 
     ShowFirstLast="True" 
     FirstPageCaption="First" 
     LastPageCaption="Last" 
     ShowPrevNext="True" 
     NextPageCaption="&raquo;" 
     PrevPageCaption="&laquo;"
     ScrollToTop="True"
     CurrentPageCssClass="pager-active">

    <ul class="pagination">
      <li>{pager}</li>
    </ul>

  </Pager>

  <HeaderTemplate>
      
    <div class="row">
      <div class="col-sm-12">
        <ol class="breadcrumb">
          <li>My Ads</li>
        </ol>
      </div>  
    </div>

    <div id="AllSellers" class="row">
  </HeaderTemplate>
    
  <ItemTemplate>
      	<div class="col-md-4 col-sm-6">
        	<div class="media ad">
            <a data-toggle="modal" 
               data-target="#Popup_Modal" 
               data-id="<%#Eval("Values")("AdID")%>" 
               data-title="<%#Eval("Values")("Ad_Title")%>" 
               data-source="/Ads/Details/Popup?AdID=<%#Eval("Values")("AdID")%>"
               href="#">
              <span class="fa fa-expand"></span>
              <div class="media-left middle">
                <xmod:IfNotEmpty runat="server" Value='<%#Eval("Values")("PrimaryImage")%>'>
                  <img class="media-object" alt="<%#Eval("Values")("Ad_Title")%>" src="/Portals/<%#PortalData("ID")%>/Classifieds/Ads/<%#Eval("Values")("SellerID")%>/thm_<%#Eval("Values")("PrimaryImage")%>" />
                </xmod:IfNotEmpty>
                <xmod:IfEmpty runat="server" Value='<%#Eval("Values")("PrimaryImage")%>'>
                  <span class="fa fa-picture-o"></span>
                </xmod:IfEmpty>
              </div>
              <div class="media-body">
                <h4 class="media-heading"><%#Eval("Values")("Ad_Title")%></h4>
                <h5>
                  <xmod:IfNotEmpty runat="server" Value='<%#Eval("Values")("Ad_Price")%>'>
                    <span class="label label-success"><xmod:Format runat="server" Type="Float" Value='<%#Eval("Values")("Ad_Price")%>' Pattern="c" /></span>
                  </xmod:IfNotEmpty>
                  <xmod:IfEmpty runat="server" Value='<%#Eval("Values")("Ad_Price")%>'>
                    <span class="label label-primary">FREE!</span>
                  </xmod:IfEmpty>
                  <span class="text text-muted"><small><%#Eval("Values")("CityState")%></small></span>
                </h5>            
                <div>
                  <span><small><xmod:Format runat="server" Type="Text" Value='<%#Eval("Values")("Ad_Summary")%>' MaxLength="150" /></small></span>
                </div>
              </div>
            </a>
        </div>

          <xmod:Select runat="server">
            <Case Comparetype="Role" Operator="=" Expression="Registered Users">
              <xmod:Select runat="server">
                <Case Comparetype="Numeric" Value='<%#UserData("ID")%>' Operator="<>" Expression='<%#Eval("Values")("SellerUserID")%>'>
                  <button style="display: none"
                          type="button" 
                          data-toggle="modal" 
                          data-target="#Reply_Modal" 
                          data-source="/Ads/Details/Reply?AdID=<%#Eval("Values")("AdID")%>" 
                          data-title="Re: <%#Eval("Values")("Ad_Title")%>" 
                          class="btn btn-warning reply-btn reply-btn-<%#Eval("Values")("AdID")%>">Reply to Ad
                  </button>                          
                </Case>
              </xmod:Select>
            </Case>            	
          </xmod:Select>
          
      </div>
  </ItemTemplate>

  <FooterTemplate>
    </div>
  </FooterTemplate>

  <NoItemsTemplate>
    <div class="row top10">
      <div class="col-sm-12 text-center">
        <i class="fa fa-warning" style="font-size: 5em; display: block"></i>
        <h3>Bummer! No ads found.</h3>          
      </div>
    </div>
  </NoItemsTemplate>

</xmod:Template>

<div class="modal fade" id="Popup_Modal" tabindex="-1" role="dialog" aria-labelledby="Popup_Modal">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header" style="height: 56px">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">&nbsp;</h4>
      </div>
      <div class="modal-body">

      </div>
      <div class="modal-footer" style="height: 65px">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>        
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="Contact_Modal" tabindex="-1" role="dialog" aria-labelledby="Contact_Modal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">&nbsp;</h4>
      </div>
      <div class="modal-body" style="min-height: 375px">
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>        
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="Reply_Modal" tabindex="-1" role="dialog" aria-labelledby="Reply_Modal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header" style="height: 56px">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">&nbsp;</h4>
      </div>
      <div class="modal-body" style="min-height: 270px">

      </div>
      <div class="modal-footer" style="height: 65px">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>        
      </div>
    </div>
  </div>
</div>

<script>
  $(document).ready(function() {
        
    $('.modal').appendTo('body');
    
    // Cache both the contact modal and the ad modal
    var $contact = $('#Contact_Modal'),
        $ad = $('#Popup_Modal'),
    		$replyModal = $('#Reply_Modal');
    
    // We only want to resize the ad modal on page load
    ResizeModal($ad);
    
    // We only want to resize the ad modal on resize
    $(window).resize(function() {
      ResizeModal($ad);      
    });
    
    // I'm using el.add() to trigger a listener for both the ad modal
    // and the contact modal
    $contact.add($ad).on('shown.bs.modal',function(e){
      e.preventDefault();
      
      var $modal = $(this),
          $invoker = $(e.relatedTarget),
          id = $invoker.data("id"),
          title = $invoker.data("title"),
          source = $invoker.data("source"),
      		$replyBtn = $invoker.parent().next('button').clone().show();
      
      $modal.find('.modal-title').html(title);
      
      if ($replyBtn.length) {
      	$modal.find('.modal-footer').prepend($replyBtn);  
      }
      
      var iframe = $('<iframe />', {
                     style: 'overflow-y:auto;width:100%',
                     src: source,
                     // This is the main difference. Our contact form's height can be controlled.
                     // I'm using a ternary operator similar to what we used in our category checkbox solution.
                     // If the modal has the id of "Contact_Modal" we give the iframe a height of 375.
                     // If not, we just default to 100%
                     height: ($modal.attr("id") === "Contact_Modal") ? 375 : "100%"
                   });
      
      $modal.find('.modal-body').html(iframe);
      
      if (/iPhone|iPod|iPad/.test(navigator.userAgent)) {
        $modal.find('.modal-body').css("overflow-y", "scroll");
      }           
      
    });
    
    $replyModal.on('shown.bs.modal',function(e){
      e.preventDefault();
      
      $ad.modal('hide');
      
      var $invoker = $(e.relatedTarget),
          source = $invoker.data("source"),
          title = $invoker.data("title");
      
      $replyModal.find('.modal-title').html(title);
      
      var iframe = $('<iframe />', {
                     style: 'overflow-y:auto;width:100%',
                     src: source,
                     height: 235
                   });
      
      $replyModal.find('.modal-body').html(iframe);
    });
    
    
    // I'm using the el.add() method to trigger a listener for both the ad modal
    // and contact modal    
    $contact.add($ad).add($replyModal).on('hide.bs.modal', function(e) {
      $(this).find('iframe').remove();
      $(this).find('.reply-btn').remove();
    });   
    
  });
    
  function ResizeModal($modal) {
    $modal.find('.modal-content').css('height', $(window).height()*0.8);
            
    var totalHeight = parseInt($modal.find('.modal-content').css("height")),
        headerHeight = parseInt($modal.find('.modal-header').css("height")),
        footerHeight = parseInt($modal.find('.modal-footer').css("height")),
        bodyHeight = totalHeight - headerHeight - footerHeight;
    
    $modal.find('.modal-body').css("height", bodyHeight + "px");		
    
  }

</script></xmod:masterview>