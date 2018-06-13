<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.TemplateBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls" TagPrefix="xmod" %>
<xmod:masterview runat="server">
<xmod:Template runat="server">
  
  <ListDataSource CommandText="SELECT Seller_Name, Banned, IsDeleted FROM XMP_Classified_Seller WHERE UserID = @UserID">
  	<Parameter Name="UserID" Value='<%#UserData("ID")%>' DataType="int32" /> 
  </ListDataSource>
  
  
  <ItemTemplate>
    
    <xmod:Select runat="server">
      
      <Case CompareType="Role" Operator="<>" Expression="Sellers">
    		Seller account exists, but user lacking role.
      </Case>
      
      <Case CompareType="Boolean" Expression='<%#Eval("Values")("Banned")%>' Operator="=" Value="True">
    		Seller account exists, but seller is banned.
      </Case>
      
      <Case CompareType="Boolean" Expression='<%#Eval("Values")("IsDeleted")%>' Operator="=" Value="True">
    		Seller account exists, but seller is soft deleted.
      </Case>
      
      <Else>
      	<div><h1>I'm a Validated Seller!</h1></div>
      </Else>
    
    </xmod:Select>
    
    
  </ItemTemplate> 

  <NoItemsTemplate>
	<div><h1>No Seller Account Here!</h1></div>
  </NoItemsTemplate>
  

</xmod:Template></xmod:masterview>