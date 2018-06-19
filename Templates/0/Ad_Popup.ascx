<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.TemplateBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls" TagPrefix="xmod" %>
<xmod:masterview runat="server">
<xmod:ScriptBlock runat="server" ScriptId="CustomCSS" BlockType="HeadScript" RegisterOnce="True">
  <style type="text/css">
    .summary-wrapper { margin-top: 50px; }
    .summary-wrapper .title-wrapper { text-align: center; }
    .summary-wrapper .title-wrapper h1 { margin: 0px; }
    .summary-wrapper .title-wrapper h2 { margin: 0px; }
    .summary-wrapper .title-wrapper h5 { margin: 0px; }
    .summary-wrapper .image-wrapper { text-align: center; margin-top: 20px; }
    .summary-wrapper .price-wrapper { text-align: center; font-size: 20px; color: darkgreen; }
    .summary-wrapper .contact-wrapper { text-align: center; margin-top: 10px; font-size: 16px; color: #555; }
    .summary-wrapper .adsummary-wrapper { max-width: 600px; margin: 20px auto; }
    .summary-wrapper .adsummary-wrapper p { font-size: 16px; color: #555; border: 4px solid #ebebeb; padding: 20px; border-radius: 10px; }
    .summary-wrapper .adinfo-wrapper { max-width: 600px; margin: 15px auto; }
    .summary-wrapper .addetails-wrapper { border: 4px solid #ebebeb; border-radius: 10px; padding: 20px; margin: 20px 0px;}
    .additional-images { margin-top: 10px; }
  </style>
 
  <link rel="stylesheet" href="/plugins/magnific/magnific-popup.css" type="text/css" />
  <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css?cdv=23" media="all" type="text/css" rel="stylesheet"/>
  <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css?cdv=23" media="all" type="text/css" rel="stylesheet"/>
  <script type="text/javascript" src="/plugins/magnific/jquery.magnific-popup.min.js"></script>
      
</xmod:ScriptBlock>


<xmod:Template runat="server" UsePaging="False">
  <ListDataSource CommandText="SELECT 
                                  
                                  -- From XMP_Classified_Ad Table
                                  a.[AdID]
                                 ,a.[SellerID]
                                 ,a.[LocationID]
                                 ,a.[Ad_Title]
                                 ,a.[Ad_Subtitle]
                                 ,a.[Ad_Price]
                                 ,a.[PrimaryImage]
                                 ,dbo.udf_XMP_GenerateImagesWithPath(a.AdID, '/Portals/' + CAST(@PortalID as nvarchar(10)) + '/Classifieds/Ads/' + CAST(a.SellerID as nvarchar(10)) + '/', '|') AS AdditionalImages
                                 ,a.[Ad_Summary]
                                 ,a.[Ad_Description]
                                 ,a.[Date_Created]
                                 ,a.[Date_Updated]
                                 ,a.[IsSold]
                                 ,a.[DateSold]
                                 ,a.[Ad_Expires]
                                 ,a.[Approved]
                                 ,a.[Active]
                                 ,a.[ShowAddress]
                                 ,a.[ShowPhone]
                                 ,a.[ShowEmail] 
                                 
                                 -- From XMP_Classified_Seller Table
                                 ,seller.[Seller_Name]
                                 ,seller.[Seller_Location]
                                 ,seller.[Seller_Address]
                                 ,seller.[Seller_Phone]
                                 ,seller.[Seller_Email]
                                 
                                 -- From XMP_Classified_Location Table
                                 ,loc.City + ', ' + loc.State AS CityState
                                 
                                 -- From XMP_Classified_Location Table
                                 ,loc2.City + ', ' + loc2.State AS SellerCityState
                                 
                                 FROM XMP_Classified_Ad a
                                 INNER JOIN XMP_Classified_Seller seller ON a.SellerID = seller.SellerID
                                 LEFT JOIN XMP_Classified_Location loc ON a.LocationID = loc.LocationID
                                 LEFT JOIN XMP_Classified_Location loc2 ON seller.Seller_Location = loc2.LocationID
                                 WHERE a.[AdID] = @AdID">
    <Parameter Name="AdID" Value='<%#UrlData("AdID")%>' DataType="Int32" />
    <Parameter Name="PortalID" Value='<%#PortalData("ID")%>' DataType="Int32" />
  </ListDataSource>
  
  <ItemTemplate>
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
            <img class="img-thumbnail" src="/Portals/<%#PortalData("ID")%>/Classifieds/Ads/<%#Eval("Values")("SellerID")%>/<%#Eval("Values")("PrimaryImage")%>" />
          </a>
        </xmod:IfNotEmpty>
        <xmod:IfEmpty runat="server" Value='<%#Eval("Values")("PrimaryImage")%>'>
          <img class="img-thumbnail" src="http://placehold.it/300x300&text=no+image" />
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
          <li class="list-group-item">Posted by <%#Eval("Values")("Seller_Name")%> on: <xmod:Format runat="server" Type="Date" Value='<%#Eval("Values")("Date_Created")%>' Pattern="MM/dd/yyyy" /></li>
          <li class="list-group-item">Expires on: <xmod:Format runat="server" Type="Date" Value='<%#Eval("Values")("Ad_Expires")%>' Pattern="MM/dd/yyyy" /></li>
          <xmod:Select runat="server">
            <Case Comparetype="Boolean" Value='<%#Eval("Values")("ShowAddress")%>' Operator="=" Expression="True">
              <li class="list-group-item">Address: <%#Eval("Values")("Seller_Address")%> - <%#Eval("Values")("SellerCityState")%></li>
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
        </xmod:Select>
      </div>      
    </div>        

  </ItemTemplate>                              

</xmod:Template>

<script>
	
  function pageLoad(){
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
    } else {
      $('.image-wrapper').unbind();
    }  	
  } 
  
</script></xmod:masterview>