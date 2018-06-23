<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.TemplateBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls" TagPrefix="xmod" %>
<xmod:masterview runat="server">
<xmod:ScriptBlock runat="server" ScriptId="CategoriesScripts" BlockType="HeadScript" RegisterOnce="True">
  <style type="text/css">
    ul.ad-categories {
      overflow: auto;
      column-count: 3;
      column-gap: 10px;
      -moz-column-count: 3;
      -moz-column-gap: 10px;
      -webkit-column-count: 3;
      -webkit-column-gap : 10px;
    }
    ul.ad-categories li.parent {
      font-size: 16px;
      font-weight: bold;
    }
    ul.ad-categories li.child {
      font-size: 14px;
      margin-left: 10px;
      list-style: none;
    }
    
    .modal-content { height: auto !important; }
    .modal-body { height: auto !important; }
    
  </style>
</xmod:ScriptBlock>

<xmod:template runat="server" usepaging="False" ajax="True">

  <ListDataSource CommandText= "SELECT *
                                FROM (
                                SELECT p.CategoryID
                                ,p.Category_Name
                                ,p.Sort_Order + ' - ' + p.CategoryID AS First_Level
                                ,NULL AS Second_Level
                                ,p.Active
                                ,'parent' AS [Class]
                                ,@Location AS LocId
                                ,(
                                SELECT COUNT(*)
                                FROM XMP_Classified_Ad a
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
                                AND a.LocationID = CASE 
                                WHEN (@Location = - 1)
                                THEN a.LocationID
                                ELSE @Location
                                END
                                ) AS AdCount
                                FROM XMP_Classified_Category p
                                WHERE p.ParentID IS NULL

                                UNION ALL

                                SELECT c.CategoryID
                                ,' - ' + c.Category_Name AS Category_Name
                                ,d.Sort_Order + ' - ' + d.CategoryID AS First_Level
                                ,c.Sort_Order AS Second_Level
                                ,c.Active
                                ,'child' AS [Class]
                                ,@Location AS LocId
                                ,(
                                SELECT COUNT(*)
                                FROM XMP_Classified_Ad a
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
                                AND a.LocationID = CASE 
                                WHEN (@Location = - 1)
                                THEN a.LocationID
                                ELSE @Location
                                END
                                ) AS AdCount
                                FROM XMP_Classified_Category c
                                INNER JOIN XMP_Classified_Category d ON c.ParentID = d.CategoryID
                                WHERE c.ParentID IS NOT NULL
                                ) AS Categories
                                ORDER BY Categories.First_Level
                                ,Categories.Second_Level">

    <Parameter Name="Location" Value='<%#UrlData("LocId")%>' DefaultValue="-1" DataType="Int32" />

  </ListDataSource>

  <HeaderTemplate>

    <div class="modal fade" id="Category_Modal" tabindex="-1" role="dialog" aria-labelledby="Category_Modal">
      <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
          <div class="modal-header" style="height: 56px;">
            <select class="form-control" id="Ad_Locations"></select>
            <xmod:LoadFeed runat="server" FeedName="Ads_GetLocations" Target="#Ad_Locations" />
          </div>
          <div class="modal-body" style="overflow: auto;">
            <div class="text-center">
              <a style="color: white" id="view_all_ads" class="btn btn-warning" href="/Ads">View All Ads</a>
              <hr/>
            </div>            
            <ul class="ad-categories">

  </HeaderTemplate>

  <ItemTemplate>
              <li id="cat-<%#Eval("Values")("CategoryID")%>" class="<%#Eval("Values")("Class")%>">
                <a href="/Ads?Id=<%#Eval("Values")("CategoryID")%>&LocId=<%#Eval("Values")("LocId")%>"><%#Eval("Values")("Category_Name")%>&nbsp;&nbsp;
                  <span class="text text-muted">(</span><%#Eval("Values")("AdCount")%><span class="text text-muted">)</span>
                </a>
              </li>
  </ItemTemplate>

  <FooterTemplate>
            </ul>
          </div>
          <div class="modal-footer" style="height: 65px">
            <button type="button" class="btn btn-default" data-dismiss="modal" aria-label="Close">Close</button>
            <a href="/Contact" class="btn btn-default">Suggest a Category</a>        
          </div>          
        </div>
      </div>
    </div>
  </FooterTemplate>

</xmod:template>

<script>

  var $location_select = $('#Ad_Locations'),
      loc_url = "<%#UrlData("LocId")%>",
      cat_url = "<%#UrlData("Id")%>",
      $viewall = $('#view_all_ads');
    
  function reloadlinks() {
    $.ajax({
      url: "/DesktopModules/XmodPro/Feed.aspx",
      dataType: "HTML",
      type: "POST",
      data: {
        "xfd" : "Ads_GetCounts",
        "pid" : <%#PortalData("ID")%>,
        "loc" : parseInt($location_select.val())
      },
      success: function(data) {
        $('ul.ad-categories').html(data);
        alterlinks();
      }          
    });
  }
    
  function alterlinks() {
    var locId = $location_select.val(),
        locText = $('option:selected', $location_select).text(),
        link;
      
    if (locId > 0) {
      link = "/Ads?LocId=" + locId;
      $viewall.attr("href", link);          
      $viewall.text("View all ads in " + locText);
    } else {
      link = "/Ads";
      $viewall.text("View All Ads");
    }      
  }
    
  function checkfeed() {
    if (!$location_select.children('option').length) {
      return setTimeout(checkfeed, 1000);
    }      
      
    if (loc_url) {
      $location_select.val(parseInt(loc_url));
      alterlinks();
    }
    
    breadcrumb();
		  
  }
  

  
  function pageLoad(){
    breadcrumb();
  }
  
  function breadcrumb() {
    
    var crumb = '<li><a href="/Ads">All Ads</a></li>';
    var placeholder = "Search ";

    if (cat_url) {

      var catLink = $('#cat-' + cat_url),
          parent,
          isParent = catLink.hasClass('parent') ? true : false;

    if (isParent) {
      crumb += '<li class="active"><a href="' + catLink.find("a").attr("href") + '">' + catLink.find("a").text() + '</a></li>';
      placeholder += catLink.find('a').text() + " in ";
      
    } else {

      parent = catLink.prevAll('.parent:first');
      crumb += '<li><a href="' + parent.find("a").attr("href") + '">' + parent.find("a").text() + '</a></li>' +
               '<li class="active"><a href="' + catLink.find("a").attr("href") + '">' + catLink.find("a").text() + '</a></li>';

        placeholder += parent.find('a').text() + " / " + catLink.find('a').text() + " in ";
      }
    
    } else {
      placeholder += "all categories in ";      
    }

    crumb += '<li class="pull-right">' + $('option:selected', $location_select).text() + '</li>';
	
    placeholder += $('option:selected', $location_select).text(); 
  
    $('.ad-search').find('input[type="text"]').attr('placeholder', placeholder);
    $('#Ads_Breadcrumb').html(crumb);

  }
  

  $(document).ready(function() {
    
    checkfeed();
    
    $location_select.change(function() {
      reloadlinks();      
    });
     
  });
</script></xmod:masterview>