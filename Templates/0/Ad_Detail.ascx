<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.TemplateBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls" TagPrefix="xmod" %>
<xmod:masterview runat="server">
<xmod:ScriptBlock runat="server" ScriptId="CustomCSS" BlockType="HeadScript" RegisterOnce="True">
  <style type="text/css">
    #Reply_Modal .modal-body {
      background:url("/images/loading.gif") center no-repeat;
      overflow-y: hidden;
    }
    .summary-wrapper { margin-top: 50px; }
    .summary-wrapper .title-wrapper { text-align: center; }
    .summary-wrapper .title-wrapper h1 { margin: 0px; }
    .summary-wrapper .title-wrapper h2 { margin: 0px; }
    .summary-wrapper .title-wrapper h5 { margin: 0px; }
    .summary-wrapper .image-wrapper { text-align: center; margin-top: 20px; }
    .image-wrapper img { display: inherit!important; }
    .summary-wrapper .price-wrapper { text-align: center; font-size: 20px; color: darkgreen; }
    .summary-wrapper .contact-wrapper { text-align: center; margin-top: 10px; font-size: 16px; color: #555; }
    .summary-wrapper .adsummary-wrapper { max-width: 600px; margin: 20px auto; border: 4px solid #ebebeb; border-radius: 10px;}
    .summary-wrapper .adsummary-wrapper p { font-size: 16px!important; color: #555 !important; padding: 10px !important; }
    .summary-wrapper .adinfo-wrapper { max-width: 600px; margin: 15px auto; }
    .summary-wrapper .addetails-wrapper { border: 4px solid #ebebeb; border-radius: 10px; padding: 20px; margin: 20px 0px;}
    .additional-images { margin-top: 10px; }
    .img-thumbnail { display: inline-block !important; }
    .top10 { margin-top: 10px;}
    a.fix_link, a.fix_link:visited, a.fix_link:hover { color: #fff; font-size: 14px; }
  </style>
 
  <link href="/js/magnific/magnific-popup.css" rel="stylesheet" />
  <script src="/js/magnific/jquery.magnific-popup.min.js"></script>
      
</xmod:ScriptBlock>

<xmod:Select runat="server">
  <Case Comparetype="Role" Operator="<>" Expression="Sellers">
    <div class="row top10">
      <div class="col-xm-12 text-center">
        <a href="/Join" class="btn btn-success btn-lg active" role="button">Join to become a Seller!</a>
      </div>
    </div>
  </Case>
</xmod:Select>

<div class="row">
  <div class="col-xm-12 text-center">
    <div class="btn btn-group">
      <a type="button" class="btn btn-primary" data-toggle="modal" data-target="#Category_Modal">Categories &amp; Locations</a>
      <a href="/Ads" class="btn btn-default">View All Ads</a>
    </div>
  </div>
</div>

<hr />

<xmod:Template runat="server" UsePaging="False">
  <ListDataSource CommandText="SELECT *,
                               				dbo.udf_XMP_GenerateImagesWithPath(AdID, '/Portals/' + CAST(@PortalID as nvarchar(10)) + '/Classifieds/Ads/' + CAST(SellerID as nvarchar(10)) + '/', '|') AS AdditionalImages
                               FROM vw_XMP_Admin_Ad_Detail 
                               WHERE [AdID] = @AdID">
    <Parameter Name="AdID" Value='<%#UrlData("AdID")%>' DataType="Int32" />
    <Parameter Name="PortalID" Value='<%#PortalData("ID")%>' DataType="Int32" />
  </ListDataSource>
  
  <ItemTemplate>
    
    <xmod:metatags runat="server">
      <Title><%#Eval("Values")("Ad_Title")%> in <%#Eval("Values")("CityState")%></Title>
      <Description><%#Eval("Values")("Ad_Summary")%></Description>      
    </xmod:metatags> 

    <div class="summary-wrapper">
      <div class="title-wrapper">
        <h1><%#Eval("Values")("Ad_Title")%></h1>
        <xmod:IfNotEmpty runat="server" Value='<%#Eval("Values")("Ad_Subtitle")%>'>
          <h2><%#Eval("Values")("Ad_Subtitle")%></h2>
        </xmod:IfNotEmpty>
        <h5>Item located in <%#Eval("Values")("CityState")%></h5>
      </div>
      <div class="price-wrapper">
        <xmod:IfNotEmpty runat="server" Value='<%#Eval("Values")("Ad_Price")%>'>
          <xmod:Format runat="server" Type="Float" Value='<%#Eval("Values")("Ad_Price")%>' Pattern="c" />
        </xmod:IfNotEmpty>
        <xmod:IfEmpty runat="server" Value='<%#Eval("Values")("Ad_Price")%>'>
          FREE!
        </xmod:IfEmpty>
      </div>
      <div class="contact-wrapper">
        <xmod:Select runat="server" Mode="Inclusive">
          <Case Comparetype="Boolean" Value='<%#Eval("Values")("ShowPhone")%>' Operator="=" Expression="True">
            Phone: <%#Eval("Values")("Seller_Phone")%><br/>
          </Case>
          <Case Comparetype="Boolean" Value='<%#Eval("Values")("ShowEmail")%>' Operator="=" Expression="True">
            Email: <a href="mailto:<%#Eval("Values")("Seller_Email")%>"><%#Eval("Values")("Seller_Email")%></a>
          </Case>
        </xmod:Select>
      </div>
      <div class="image-wrapper">
        <xmod:IfNotEmpty runat="server" Value='<%#Eval("Values")("PrimaryImage")%>'>
          <a href="/Portals/<%#PortalData("ID")%>/Classifieds/Ads/<%#Eval("Values")("SellerID")%>/<%#Eval("Values")("PrimaryImage")%>">
            <img class="img-responsive center-block" src="/Portals/<%#PortalData("ID")%>/Classifieds/Ads/<%#Eval("Values")("SellerID")%>/<%#Eval("Values")("PrimaryImage")%>" />
          </a>
        </xmod:IfNotEmpty>
        <xmod:IfEmpty runat="server" Value='<%#Eval("Values")("PrimaryImage")%>'>
          <img class="img-responsive center-block" src="http://placehold.it/300x300&text=no+image" />
        </xmod:IfEmpty>
        <xmod:IfNotEmpty runat="server" Value='<%#Eval("Values")("AdditionalImages")%>'>
          <div class="additional-images">
            <xmod:Each runat="server" Value='<%#Eval("Values")("AdditionalImages")%>' Delimiter="|">
              <ItemTemplate>
                {value}
              </ItemTemplate>
            </xmod:Each>
          </div>              
        </xmod:IfNotEmpty>              
      </div>
     <div class="adsummary-wrapper">
        <xmod:IfNotEmpty runat="server" Value='<%#Eval("Values")("Ad_Description")%>'>
          <div><%#Eval("Values")("Ad_Description")%></div>
        </xmod:IfNotEmpty>
        <xmod:IfEmpty runat="server" Value='<%#Eval("Values")("Ad_Description")%>'>
          <div>Contact seller for details...</div>
        </xmod:IfEmpty>
      </div>
      <div class="adinfo-wrapper">
        <ul class="list-group" style="margin-left: 0px">
          <li class="list-group-item">
            Posted by&nbsp;<a class="btn btn-primary btn-xs fix_link" href="/Sellers/Details/SellerID/<%#Eval("Values")("SellerID")%>" title="View seller's details and Ads."><%#Eval("Values")("Seller_Name")%></a>&nbsp;on: <xmod:Format runat="server" Type="Date" Value='<%#Eval("Values")("Date_Created")%>' Pattern="MM/dd/yyyy" />
          </li>
          <li class="list-group-item">Expires on: <xmod:Format runat="server" Type="Date" Value='<%#Eval("Values")("Ad_Expires")%>' Pattern="MM/dd/yyyy" /></li>
          <xmod:Select runat="server">
            <Case Comparetype="Boolean" Value='<%#Eval("Values")("ShowAddress")%>' Operator="=" Expression="True">
              <li class="list-group-item">Item Location: <%#Eval("Values")("Seller_Address")%> - <%#Eval("Values")("SellerCityState")%></li>
            </Case>
          </xmod:Select>
        </ul>
      </div>
    </div>        

    <div class="summary-wrapper">
      
      <div class="contact-wrapper">
        <xmod:Select runat="server" Mode="Inclusive">
          <Case Comparetype="Boolean" Value='<%#Eval("Values")("ShowPhone")%>' Operator="=" Expression="True">
            Phone: <%#Eval("Values")("Seller_Phone")%><br/>
          </Case>
          <Case Comparetype="Boolean" Value='<%#Eval("Values")("ShowEmail")%>' Operator="=" Expression="True">
            Email: <a href="mailto:<%#Eval("Values")("Seller_Email")%>"><%#Eval("Values")("Seller_Email")%></a>
          </Case>
          <Case Comparetype="Numeric" Value='<%#UserData("ID")%>' Operator="<>" Expression='<%#Eval("Values")("SellerUserID")%>'>
            <button type="button" 
                    data-toggle="modal" 
                    data-target="#Reply_Modal" 
                    data-source="/Ads/Details/Reply?AdID=<%#Eval("Values")("AdID")%>" 
                    data-title="Re: <%#Eval("Values")("Ad_Title")%>" 
                    class="btn btn-warning reply-btn reply-btn-<%#Eval("Values")("AdID")%>">Reply to Ad
            </button>                          
          </Case>
        </xmod:Select>
      </div>      
    </div>        

  </ItemTemplate>
  
  <NoItemsTemplate>
    <div class="row">
      <div class="col-sm-12 text-center">
        <i class="fa fa-warning" style="font-size: 5em; display: block"></i>
        <h3>We're sorry. This ad no longer exists.</h3>
        <h4>
          It most likely expired by the time you got here. 
          Feel free to browse our other ads by clicking one of 
          the buttons above!
        </h4>
      </div>
    </div>
  </NoItemsTemplate>

</xmod:Template>

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
    var $cats = $('#Category_Modal'),
        $replyModal = $('#Reply_Modal');

    ResizeModal($cats);
    
    $(window).resize(function() {
      ResizeModal($cats);
    });
    
    if ( $('.image-wrapper').length ) {
      $('.image-wrapper').magnificPopup({
        delegate: 'a',
        type: 'image',
        tLoading: 'Loading image #%curr%...',
        mainClass: 'mfp-fade',
        gallery: {
          enabled: true,
          navigateByImgClick: true,
          preload: [0,1]
        },
        image: {
          tError: '<a href="%url%">The image #%curr%</a> could not be loaded.'        
        },
        zoom: {
          enabled: true, 
          duration: 300, 
          easing: 'ease-in-out', 
          opener: function(openerElement) {
            return openerElement.is('img') ? openerElement : openerElement.find('img');
          }
        }
      });
    }   
    
  });
  
  $replyModal.on('shown.bs.modal',function(e){
      e.preventDefault();
      
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
    
    $replyModal.on('hide.bs.modal', function(e) {
      $(this).find('iframe').remove();      
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