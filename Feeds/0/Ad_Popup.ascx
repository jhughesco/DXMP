<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.FeedBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls" TagPrefix="xmod" %>
<xmod:masterview runat="server">
<xmod:Feed runat="server" ContentType="text/html" FileName="Ad_Popup">

  <ListDataSource CommandText="SELECT *,
                               				dbo.udf_XMP_GenerateImagesWithPath(AdID, '/Portals/' + CAST(@PortalID as nvarchar(10)) + '/Classifieds/Ads/' + CAST(SellerID as nvarchar(10)) + '/', '|') AS AdditionalImages
                               FROM vw_XMP_Admin_Ad_Detail 
                               WHERE [AdID] = @AdID">
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
            Posted by&nbsp;<a class="btn btn-primary btn-xs seller_link" href="/Sellers/Details/SellerID/<%#Eval("Values")("SellerID")%>" title="View seller's details and Ads." target="_blank"><%#Eval("Values")("Seller_Name")%></a>&nbsp;on: <xmod:Format runat="server" Type="Date" Value='<%#Eval("Values")("Date_Created")%>' Pattern="MM/dd/yyyy" />
          </li>
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


</xmod:Feed>
</xmod:masterview>