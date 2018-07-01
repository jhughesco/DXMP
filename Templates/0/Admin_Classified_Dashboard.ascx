<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.TemplateBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls" TagPrefix="xmod" %>
<xmod:masterview runat="server">
<xmod:ScriptBlock runat="server" ScriptId="RecentAds" BlockType="HeadScript" RegisterOnce="True">
  <style type="text/css">
    .top10 {
      margin-top: 10px;
    }
  </style>
</xmod:ScriptBlock>

<div class="row top10">
  <div class="col-sm-12">
    <xmod:Template runat="server">
      <ListDataSource CommandText="SELECT COUNT(*) AS Unapproved FROM XMP_Classified_Ad WHERE Approved = 0" />
      <ItemTemplate>
        <xmod:Select runat="server">
          <Case Comparetype="Numeric" Value='<%#Eval("Values")("Unapproved")%>' Operator=">" Expression="0">
            <div class="alert alert-danger">
              You currently have <%#Eval("Values")("Unapproved")%> ads needing review.
            </div>  	
          </Case>
          <Else>
            <div class="alert alert-success">
              No work to do today... Kudos to you!
            </div>
          </Else>
        </xmod:Select>
      </ItemTemplate>
    </xmod:Template>
  </div>
</div>


<div class="row">
  <div class="col-sm-3">
    <xmod:Template runat="server" ID="Level">
      <ListDataSource CommandText="SELECT 
                                   COUNT(*) AS SellerCount
                                   ,s.[Seller_Level]
                                   ,l.[Level_Name]
                                   ,(SELECT COUNT(*) 
                                   FROM XMP_Classified_Seller 
                                   WHERE Banned = 1 
                                   AND Seller_Level = s.Seller_Level) AS BannedCount
                                   FROM XMP_Classified_Seller s
                                   INNER JOIN XMP_Classified_Level l ON s.Seller_Level = l.LevelID
                                   GROUP BY s.[Seller_Level], l.[Level_Name]" />

      <HeaderTemplate>
        <div class="panel panel-default">
          <div class="panel-heading">By Level</div>
          <table class="table">
            <thead>
              <tr>
                <th>Level</th>
                <th>Sellers</th>
                <th>Banned</th>
              </tr>
            </thead>
            <tbody>
            </HeaderTemplate>
          <ItemTemplate>
            <tr>
              <td><%#Eval("Values")("Level_Name")%></td>
              <td><%#Eval("Values")("SellerCount")%></td>
              <td><%#Eval("Values")("BannedCount")%></td>
            </tr>    
          </ItemTemplate>
          <FooterTemplate>
            </tbody>
          </table>
        </div>
      </FooterTemplate>    	
    </xmod:Template>
</div>

<div class="col-sm-3">
  <xmod:Template runat="server" ID="AdsByLocation">
    <ListDataSource CommandText="XMP_Classified_Dashboard_AdsByLocation" CommandType="StoredProcedure">
      <Parameter Name="TotalAds" Direction="OUTPUT" Size="100" DataType="Int32" />        
    </ListDataSource>

    <HeaderTemplate>
      <div class="panel panel-default">
        <div class="panel-heading">Ads By Location</div>
        <table class="table">
          <thead>
            <tr>
              <th>Where</th>
              <th>Ads</th>
            </tr>
          </thead>
          <tbody>
          </HeaderTemplate>
        <ItemTemplate>
          <tr>
            <td><%#Eval("Values")("CityState")%></td>
            <td><%#Eval("Values")("AdCount")%></td>
          </tr>    
        </ItemTemplate>
        <FooterTemplate>
          <tr>
            <td><strong>Total:</strong></td>
            <td><strong><%#DBParamData("AdsByLocation_list@TotalAds")%></strong></td>
          </tr>
          </tbody>
        </table>
      </div>
    </FooterTemplate>    	
  </xmod:Template>
  </div>

  <div class="col-sm-3">
    <xmod:Template runat="server" ID="SellersByLocation">

      <ListDataSource CommandText="XMP_Classified_Dashboard_SellersByLocation" CommandType="StoredProcedure">
        <Parameter Name="TotalSellers" Direction="OUTPUT" Size="100" DataType="Int32" />
        <Parameter Name="TotalBanned" Direction="OUTPUT" Size="100" DataType="Int32" />
      </ListDataSource>

      <HeaderTemplate>
        <div class="panel panel-default">
          <div class="panel-heading">Sellers By Location</div>
          <table class="table">
            <thead>
              <tr>
                <th>Where</th>
                <th>Sellers</th>
                <th>Banned</th>
              </tr>
            </thead>
            <tbody>
            </HeaderTemplate>
          <ItemTemplate>
            <tr>
              <td><%#Eval("Values")("CityState")%></td>
              <td><%#Eval("Values")("SellerCount")%></td>
              <td><%#Eval("Values")("BannedCount")%></td>
            </tr>    
          </ItemTemplate>
          <FooterTemplate>
            <tr>
              <td><strong>Total:</strong></td>
              <td><strong><%#DBParamData("SellersByLocation_list@TotalSellers")%></strong></td>
              <td><strong><%#DBParamData("SellersByLocation_list@TotalBanned")%></strong></td>
            </tr>
            </tbody>
          </table>
        </div>
      </FooterTemplate>    	
    </xmod:Template>
  </div>

  <div class="col-sm-3">
    <xmod:Template runat="server" ID="Revenue">
      <ListDataSource CommandText="XMP_Classified_Dashboard_EstimatedRevenue" CommandType="StoredProcedure">
        <Parameter Name="GrandTotal" Direction="Output" Size="100" DataType="Decimal" />        
      </ListDataSource>

      <HeaderTemplate>
        <div class="panel panel-default">
          <div class="panel-heading">Estimated Monthly Revenue</div>
          <table class="table">
            <thead>
              <tr>
                <th>Level</th>
                <th>Estimated Sum</th>                
              </tr>
            </thead>
            <tbody>
            </HeaderTemplate>
          <ItemTemplate>
            <tr>
              <td><%#Eval("Values")("Level_Name")%></td>
              <td><xmod:Format runat="server" Type="Float" Value='<%#Eval("Values")("EstimatedSum")%>' Pattern="c" /></td>
            </tr>    
          </ItemTemplate>
          <FooterTemplate>
            <tr>
              <td><strong>Total:</strong></td>
              <td><strong><xmod:Format runat="server" Type="Float" Value='<%#DBParamData("Revenue_list@GrandTotal")%>' Pattern="c" /></strong></td>
            </tr>
            </tbody>
          </table>
        </div>
      </FooterTemplate>    	
    </xmod:Template>    
  </div>

</div></xmod:masterview>