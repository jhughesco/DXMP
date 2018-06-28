<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.FeedBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls" TagPrefix="xmod" %>
<xmod:masterview runat="server">
<xmod:Feed runat="server" ContentType="text/html" ViewRoles="Registered Users">

  <ListDataSource CommandText="XMP_Classified_GetConversation" CommandType="StoredProcedure">
  	<Parameter Name="UserID" Value='<%#UserData("ID")%>' DataType="Int32" />
    <Parameter Name="ConversationID" Value='<%#FormData("cid")%>' DataType="Int32" />
  </ListDataSource>
     
  <ItemTemplate>
    <li class="bubble <%#Eval("Values")("BubbleClass")%>">
      <div class="date-stamp"><xmod:Format runat="server" Type="Date" Value='<%#Eval("Values")("Created")%>' Pattern="M/dd h:mm tt" /></div>
      <div class="message"><%#Eval("Values")("Message")%></div>
    </li>
  </ItemTemplate>

</xmod:Feed></xmod:masterview>