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
      	<xmod:Select runat="server">
          <Case Comparetype="Text" Value='<%#ModuleData("Menu")%>' Operator="=" Expression="Dashboard">
            <div class="text-center">
              <h1>Dashboard</h1>
              <h2>Why not create a seller account and post some ads?</h2>
              <a style="color: white" href="/Dashboard/Sign-Up" class="btn btn-primary btn-lg">
                Create a Seller Account
              </a>
            </div>    
          </Case>
          <Case Comparetype="Text" Value='<%#ModuleData("Menu")%>' Operator="=" Expression="Messages">
            <div class="text-center">
              <h1>Private Messages</h1>
              <h2>Manage your communications with sellers on this page.</h2>
              <a style="color: white" href="/Dashboard/Sign-Up" class="btn btn-primary btn-lg">
                Create a Seller Account
              </a>
            </div>    
          </Case>
          <Case Comparetype="Text" Value='<%#ModuleData("Menu")%>' Operator="=" Expression="Profile">
            <div class="text-center">
              <h1>Profile</h1>
              <h2>Manage your Seller Profile on this page.</h2>
              <a style="color: white" href="/Dashboard/Sign-Up" class="btn btn-primary btn-lg">
                Edit Profile
              </a>
            </div>    
          </Case>  
        </xmod:Select>
      </Else>
    
    </xmod:Select>
    
    
  </ItemTemplate> 

  <NoItemsTemplate>
    <xmod:Select runat="server">
      <Case Comparetype="Text" Value='<%#ModuleData("Menu")%>' Operator="=" Expression="Dashboard">
        <div class="text-center">
          <h1>Dashboard</h1>
          <h2>Why not create a seller account and post some ads?</h2>
          <a style="color: white" href="/Dashboard/Sign-Up" class="btn btn-primary btn-lg">
            Create a Seller Account
          </a>
        </div>    
      </Case>
      <Case Comparetype="Text" Value='<%#ModuleData("Menu")%>' Operator="=" Expression="Messages">
        <div class="text-center">
          <h1>Private Messages</h1>
          <h2>Manage your communications with sellers on this page.</h2>
          <a style="color: white" href="/Dashboard/Sign-Up" class="btn btn-primary btn-lg">
            Create a Seller Account
          </a>
        </div>    
      </Case>
    </xmod:Select>    
  </NoItemsTemplate>
  

</xmod:Template></xmod:masterview>