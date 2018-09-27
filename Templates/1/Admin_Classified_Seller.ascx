<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.TemplateBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls" TagPrefix="xmod" %>
<xmod:masterview runat="server">
<xmod:Template runat="server" UsePaging="True" Ajax="False" AddRoles="" EditRoles="" DeleteRoles="" DetailRoles="">
  <ListDataSource CommandText="SELECT [SellerID], [UserID], [Date_Created], [Date_Updated], [UpdatedBy], [Seller_Name], [Seller_Address], [Seller_Location], [Seller_Phone], [Seller_Email], [Show_Address_By_Default], [Show_Phone_By_Default], [Seller_Image], [Seller_Level], [Approved_Ads], [Agree], [Banned], [IsDeleted] FROM XMP_Classified_Seller"/>
  <DetailDataSource CommandText="SELECT [SellerID], [UserID], [Date_Created], [Date_Updated], [UpdatedBy], [Seller_Name], [Seller_Address], [Seller_Location], [Seller_Phone], [Seller_Email], [Show_Address_By_Default], [Show_Phone_By_Default], [Seller_Image], [Seller_Level], [Approved_Ads], [Agree], [Banned], [IsDeleted] FROM XMP_Classified_Seller WHERE [SellerID] = @SellerID">
    <Parameter Name="SellerID" />
  </DetailDataSource>
  <DeleteCommand CommandText="DELETE FROM XMP_Classified_Seller WHERE [SellerID] = @SellerID">
    <Parameter Name="SellerID" />
  </DeleteCommand>
  <HeaderTemplate>
    <table>
      <thead>
        <tr>
          <th>Seller ID</th>
          <th>User ID</th>
          <th>Date_Created</th>
          <th>Date_Updated</th>
          <th>Updated By</th>
          <th>Seller_Name</th>
          <th>Seller_Address</th>
          <th>Seller_Location</th>
          <th>Seller_Phone</th>
          <th>Seller_Email</th>
          <th>Show_Address_By_Default</th>
          <th>Show_Phone_By_Default</th>
          <th>Seller_Image</th>
          <th>Seller_Level</th>
          <th>Approved_Ads</th>
          <th>Agree</th>
          <th>Banned</th>
          <th>Is Deleted</th>
          <th>&nbsp;</th>
        </tr>
      </thead>
      <tbody>
  </HeaderTemplate>
  <ItemTemplate>
        <tr>
          <td><%#Eval("Values")("SellerID")%></td>
          <td><%#Eval("Values")("UserID")%></td>
          <td><%#Eval("Values")("Date_Created")%></td>
          <td><%#Eval("Values")("Date_Updated")%></td>
          <td><%#Eval("Values")("UpdatedBy")%></td>
          <td><%#Eval("Values")("Seller_Name")%></td>
          <td><%#Eval("Values")("Seller_Address")%></td>
          <td><%#Eval("Values")("Seller_Location")%></td>
          <td><%#Eval("Values")("Seller_Phone")%></td>
          <td><%#Eval("Values")("Seller_Email")%></td>
          <td><%#Eval("Values")("Show_Address_By_Default")%></td>
          <td><%#Eval("Values")("Show_Phone_By_Default")%></td>
          <td><%#Eval("Values")("Seller_Image")%></td>
          <td><%#Eval("Values")("Seller_Level")%></td>
          <td><%#Eval("Values")("Approved_Ads")%></td>
          <td><%#Eval("Values")("Agree")%></td>
          <td><%#Eval("Values")("Banned")%></td>
          <td><%#Eval("Values")("IsDeleted")%></td>
          <td>
            <xmod:EditLink runat="server" Text="Edit">
              <Parameter Name="SellerID" Value='<%#Eval("Values")("SellerID")%>' />
            </xmod:EditLink>
            <xmod:DeleteLink runat="server" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this?');">
              <Parameter Name="SellerID" Value='<%#Eval("Values")("SellerID")%>' />
            </xmod:DeleteLink>
            <xmod:DetailLink runat="server" Text="Details">
              <Parameter Name="SellerID" Value='<%#Eval("Values")("SellerID")%>' />
            </xmod:DetailLink>
          </td>
        </tr>
  </ItemTemplate>
  <FooterTemplate>
      </tbody>
    </table>
  </FooterTemplate>

  <DetailTemplate>

    <strong>SellerID</strong> <%#Eval("Values")("SellerID")%><br />
    <strong>UserID</strong> <%#Eval("Values")("UserID")%><br />
    <strong>Date_Created</strong> <%#Eval("Values")("Date_Created")%><br />
    <strong>Date_Updated</strong> <%#Eval("Values")("Date_Updated")%><br />
    <strong>UpdatedBy</strong> <%#Eval("Values")("UpdatedBy")%><br />
    <strong>Seller_Name</strong> <%#Eval("Values")("Seller_Name")%><br />
    <strong>Seller_Address</strong> <%#Eval("Values")("Seller_Address")%><br />
    <strong>Seller_Location</strong> <%#Eval("Values")("Seller_Location")%><br />
    <strong>Seller_Phone</strong> <%#Eval("Values")("Seller_Phone")%><br />
    <strong>Seller_Email</strong> <%#Eval("Values")("Seller_Email")%><br />
    <strong>Show_Address_By_Default</strong> <%#Eval("Values")("Show_Address_By_Default")%><br />
    <strong>Show_Phone_By_Default</strong> <%#Eval("Values")("Show_Phone_By_Default")%><br />
    <strong>Seller_Image</strong> <%#Eval("Values")("Seller_Image")%><br />
    <strong>Seller_Level</strong> <%#Eval("Values")("Seller_Level")%><br />
    <strong>Approved_Ads</strong> <%#Eval("Values")("Approved_Ads")%><br />
    <strong>Agree</strong> <%#Eval("Values")("Agree")%><br />
    <strong>Banned</strong> <%#Eval("Values")("Banned")%><br />
    <strong>IsDeleted</strong> <%#Eval("Values")("IsDeleted")%><br />
    <xmod:ReturnLink runat="server" CssClass="dnnSecondaryAction" Text="&lt;&lt; Return" />

  </DetailTemplate>
</xmod:Template>
<div>
  <xmod:AddLink runat="server" Text="New" />
  </div>
</xmod:masterview>