<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.TemplateBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls" TagPrefix="xmod" %>
<xmod:masterview runat="server">
<xmod:Template runat="server" UsePaging="True" Ajax="True" AddRoles="Administrators" EditRoles="Administrators" DeleteRoles="Administrators" DetailRoles="Administrators">
  <ListDataSource CommandText="SELECT [SellerID], [UserID], [Date_Created], [Date_Updated], [UpdatedBy], [Seller_Name], [Seller_Location], [Seller_Level], [Banned], [IsDeleted] FROM XMP_Classified_Seller"/>
  <DetailDataSource CommandText="SELECT [SellerID], [UserID], [Date_Created], [Date_Updated], [UpdatedBy], [Seller_Name], [Seller_Address], [Seller_Location], [Seller_Phone], [Seller_Email], [Show_Address_By_Default], [Show_Phone_By_Default], [Seller_Image], [Seller_Level], [Approved_Ads], [Agree], [Banned], [IsDeleted] FROM XMP_Classified_Seller WHERE [SellerID] = @SellerID">
    <Parameter Name="SellerID" />
  </DetailDataSource>
  <DeleteCommand CommandText="DELETE FROM XMP_Classified_Seller WHERE [SellerID] = @SellerID">
    <Parameter Name="SellerID" />
  </DeleteCommand>
  <HeaderTemplate>
    <table class="table table-bordered table-striped">
      <thead>
        <tr>
          <th>ID</th>
          <th>User ID</th>
          <th>Created</th>
          <th>Updated</th>
          <th>Updated By</th>
          <th>Name</th>
          <th>Location</th>
          <th>Level</th>
          <th>Banned</th>
          <th>Is Deleted</th>
          <th width="150">&nbsp;</th>
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
          <td><%#Eval("Values")("Seller_Location")%></td>
          <td><%#Eval("Values")("Seller_Level")%></td>
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
    <xmod:ReturnLink runat="server" CssClass="btn btn-default" Text="&lt;&lt; Return" />

  </DetailTemplate>
</xmod:Template>
<div>
  <xmod:AddLink runat="server" CssClass="btn btn-primary" Text="Ad Seller" />
  </div></xmod:masterview>