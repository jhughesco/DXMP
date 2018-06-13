<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.TemplateBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls" TagPrefix="xmod" %>
<xmod:masterview runat="server">
<xmod:Template runat="server" UsePaging="True" Ajax="False" AddRoles="" EditRoles="" DeleteRoles="" DetailRoles="">
  
	<ListDataSource CommandText="
		SELECT CASE 
            WHEN EXISTS (
                SELECT *
                FROM XMP_Classified_Seller
                WHERE UserID = @UserID
                )
              THEN CAST(1 AS BIT)
            ELSE CAST(0 AS BIT)
            END AS IsSeller
          ,(
            SELECT COUNT(*)
            FROM XMP_Classified_Ad ad
            INNER JOIN XMP_Classified_Seller s ON ad.SellerID = s.SellerID
            WHERE s.UserID = @UserID
            ) AS AdCount">    
    
    <Parameter Name="UserID" Value='<%#UserData("ID")%>' DataType="Int32" />    
  </ListDataSource>
  
  <ItemTemplate>
    <div class="list-group">
      <a href="/Dashboard" class="list-group-item active">
        My Ads <span class="badge"><%#Eval("Values")("AdCount")%></span>
      </a>
      <a href="/Dashboard/Messages" class="list-group-item">
        My Messages <span class="badge">0</span>
      </a>
      
      <xmod:Select runat="server">
        <Case Comparetype="Boolean" Value='<%#Eval("Values")("IsSeller")%>' Operator="=" Expression="True">
          <xmod:Select runat="server" Mode="Standard">
						<Case CompareType="Role" Operator="=" Expression="Sellers">
            	<a href="/Dashboard/Profile" class="list-group-item">My Seller Profile</a>
            </Case>
          </xmod:Select>
        </Case>        
      </xmod:Select>
    
    </div>    
  </ItemTemplate>  
  
</xmod:Template></xmod:masterview>