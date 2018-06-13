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
        <div class="alert alert-danger">
          <p>
						There seems to be a problem with your account.  Please <a href="/contact">Contact Us</a> to resolve this issue.
          </p>
        </div>
      </Case>
      
      <Case CompareType="Boolean" Expression='<%#Eval("Values")("Banned")%>' Operator="=" Value="True">
    		<div class="alert alert-danger">
          <p>
						Your account is currently suspended.  Please <a href="/contact">Contact Us</a> to resolve this issue.
          </p>
        </div>
      </Case>
      
      <Case CompareType="Boolean" Expression='<%#Eval("Values")("IsDeleted")%>' Operator="=" Value="True">
    		<div class="alert alert-danger">
          <p>
						Your account is pending deletion.  Please <a href="/contact">Contact Us</a> to resolve this issue.
          </p>
        </div>
      </Case>
      
      <Else>
      	<div class="text-center">
          <h1>Welcome back, <%#Eval("Values")("Seller_Name")%>!</h1>
          <h2>Manager your ads and seller settings.</h2>
          <a style="color: white" href="/Dashboard/Post-Ad" class="btn btn-success btn-lg">Post Ad</a>
        </div>
      </Else>
    
    </xmod:Select>
    
    
  </ItemTemplate> 

  <NoItemsTemplate>
    <div class="text-center">
      <h1>Hello, <%#UserData("Displayname")%>!</h1>
      <h2>You can manage your communications with sellers from this page.</h2>
      <a style="color: white" href="/Dashboard/Sign-Up" class="btn btn-primary btn-lg">Create a Seller Account</a>
    </div>  
  </NoItemsTemplate>
  

</xmod:Template></xmod:masterview>