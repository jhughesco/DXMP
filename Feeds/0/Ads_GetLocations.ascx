<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.FeedBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls" TagPrefix="xmod" %>
<xmod:masterview runat="server">
<xmod:Feed runat="server" ContentType="text/html">

<ListDataSource CommandText="SELECT LocationID,City,State FROM XMP_Classified_Location" />
<HeaderTemplate><option value="-1">All Locations</option></HeaderTemplate>
<ItemTemplate><option value="<%#Eval("Values")("LocationID")%>"><%#Eval("Values")("City")%>, <%#Eval("Values")("State")%></option></ItemTemplate>

</xmod:Feed></xmod:masterview>