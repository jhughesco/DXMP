<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.TemplateBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls" TagPrefix="xmod" %>
<xmod:masterview runat="server">
<div id="Ads_Wrapper" style="margin-top: 40px">
  
  <xmod:ScriptBlock runat="server" ScriptId="CategoriesScripts" BlockType="HeadScript" RegisterOnce="True">
    <style type="text/css">
      ul.ad-categories {
        overflow: scroll;
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
      }
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

    <SearchSort 
      FilterExpression="Ad_Title LIKE '%{0}%'"
      SearchLabelText="Search For:" SearchButtonText="GO" 
      SearchBoxCssClass="form-control"
      SearchButtonCssClass="btn btn-default"
      SortButtonText="Go"
      SortButtonCssClass="btn btn-default"
      SortFieldListCssClass="form-control">

      <div class="row">
        <div class="col-lg-3 col-sm-12 text-right">
          <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#Category_Modal">Categories &amp; Locations</button>
        </div>
        <div class="col-lg-6 text-center">
          <div class="input-group ad-search">
            {SearchBox}
            <span class="input-group-btn">
              {SearchButton}
            </span>
          </div>
        </div>
        <div class="col-lg-3 col-sm-12 text-left">
          <div class="clear-search">
            <button id="clear_search" type="button" class="btn btn-warning">
              Clear Search
            </button>
            <a href="/Ads" class="btn btn-default">View All</a>
          </div>
        </div>
      </div><br/>
    </SearchSort>

    <HeaderTemplate>

      <div class="modal fade" id="Category_Modal" tabindex="-1" role="dialog" aria-labelledby="Category_Modal">
        <div class="modal-dialog modal-lg" role="document">
          <div class="modal-content">
            <div class="modal-header" style="height: 56px">
              Categories
            </div>
            <div class="modal-body" style="overflow: scroll">
              <div class="text-center">
                <a style="color: white" id="view_all_ads" class="btn btn-warning" href="/Ads">View All Ads</a>
                <hr/>
              </div>            
              <ul class="ad-categories">

    </HeaderTemplate>

    <ItemTemplate>
                <li class="<%#Eval("Values")("Class")%>">
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
</div>
  
<script>
  $(document).ready(function() {
    
    $('#clear_search').click(function() {
      $('.ad-search input[type="text"]').val("");
      $('.ad-search .input-group-btn').find('input[type="submit"]').trigger("click");
    });
    
    $('#Ads_Wrapper').on('click', '#clear_search', function() {
      $('.ad-search input[type="text"]').val("");
      $('.ad-search .input-group-btn').find('input[type="submit"]').trigger("click");
    });
		
    $('.modal').appendTo('body');
    var $modal = $('#Popup_Modal');
    var $cats = $('#Category_Modal');

    ResizeModal($modal);
    ResizeModal($cats);
    
    $modal.on('shown.bs.modal',function(e){
      e.preventDefault();
      
      var $invoker = $(e.relatedTarget),
          id = $invoker.data("id"),
          title = $invoker.data("title");
      
      $modal.find('.modal-title').html(title);
      $modal.find('iframe').attr("src", "/Ads/Details/Popup?AdID=" + id);			
		});
    
    $(window).resize(function() {
      ResizeModal($modal);
      ResizeModal($cats);
    });  
    
    $('.modal').on('hide.bs.modal', function(e) {
      $(this).find('iframe').removeAttr("src");      
    });
    
    
  });
  
  function ResizeModal($modal) {
    $modal.find('.modal-content').css('height', $(window).height()*0.8);
            
    var totalHeight = parseInt($modal.find('.modal-content').css("height")),
        headerHeight = parseInt($modal.find('.modal-header').css("height")),
        footerHeight = parseInt($modal.find('.modal-footer').css("height")),
        bodyHeight = totalHeight - headerHeight - footerHeight;
    
    $modal.find('.modal-body').css("height", bodyHeight + "px");		
    
  }
  
</script>
  </xmod:masterview>