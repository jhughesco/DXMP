<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.FeedBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls" TagPrefix="xmod" %>
<xmod:masterview runat="server">
<xmod:Feed runat="server" ContentType="text/html">

<ListDataSource CommandText="SELECT * FROM (

    SELECT
       p.CategoryID
      ,p.Category_Name
      ,p.Sort_Order + ' - ' + CategoryID AS First_Level
      ,NULL AS Second_Level
      ,p.Active
      ,'parent' AS [Class]
      ,@Location AS LocId
      ,(SELECT COUNT(*) FROM XMP_Classified_Ad a
        INNER JOIN XMP_Classified_AdCategory ac ON a.AdID = ac.AdID
        INNER JOIN XMP_Classified_Seller s ON a.SellerID = s.SellerID
        INNER JOIN Users u ON s.UserID = u.UserID
        INNER JOIN UserPortals up ON s.UserID = up.UserID
        WHERE a.Approved = 1
        AND a.Active = 1
        AND a.Ad_Expires > getdate()
        AND s.Banned = 0
        AND s.IsDeleted = 0
        AND up.IsDeleted = 0                               
        AND up.Authorised = 1
        AND ac.CategoryID = p.CategoryID
        AND a.LocationID = CASE WHEN(@Location = -1) THEN a.LocationID ELSE @Location END) AS AdCount

    FROM XMP_Classified_Category p
    WHERE p.ParentID IS NULL

    UNION ALL

    SELECT
       c.CategoryID
      ,c.Category_Name AS Category_Name
      ,d.Sort_Order + ' - ' + d.CategoryID AS First_Level
      ,c.Sort_Order AS Second_Level
      ,c.Active
      ,'child' AS [Class]
      ,@Location AS LocId
      ,(SELECT COUNT(*) FROM XMP_Classified_Ad a
        INNER JOIN XMP_Classified_AdCategory ac ON a.AdID = ac.AdID
        INNER JOIN XMP_Classified_Seller s ON a.SellerID = s.SellerID
        INNER JOIN Users u ON s.UserID = u.UserID
        INNER JOIN UserPortals up ON s.UserID = up.UserID
        WHERE a.Approved = 1
        AND a.Active = 1
        AND a.Ad_Expires > getdate()
        AND s.Banned = 0
        AND s.IsDeleted = 0
        AND up.IsDeleted = 0                               
        AND up.Authorised = 1
        AND ac.CategoryID = c.CategoryID
        AND a.LocationID = CASE WHEN(@Location = -1) THEN a.LocationID ELSE @Location END) AS AdCount

    FROM XMP_Classified_Category c
    INNER JOIN XMP_Classified_Category d ON c.ParentID = d.CategoryID
    WHERE c.ParentID IS NOT NULL
  ) AS Categories

  WHERE Active = 1
  ORDER BY Categories.First_Level, Categories.Second_Level">
  
  <Parameter Name="Location" Value='<%#FormData("loc")%>' DataType="Int32" />
</ListDataSource>

  <ItemTemplate>
    <li class="<%#Eval("Values")("Class")%>"><a href="/Ads?Id=<%#Eval("Values")("CategoryID")%>&LocId=<%#Eval("Values")("LocId")%>"><%#Eval("Values")("Category_Name")%>&nbsp;&nbsp;<span class="text text-muted">(</span><%#Eval("Values")("AdCount")%><span class="text text-muted">)</span></a></li>
  </ItemTemplate>

</xmod:Feed></xmod:masterview>