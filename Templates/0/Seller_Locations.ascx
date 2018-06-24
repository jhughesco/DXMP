<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.TemplateBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls" TagPrefix="xmod" %>
<xmod:masterview runat="server">
<xmod:ScriptBlock runat="server" ScriptId="LocationScripts" BlockType="HeadScript" RegisterOnce="True">
  <style type="text/css">
    ul.locations {
      column-count: 2;
      column-gap: 10px;
      -moz-column-count: 2;
      -moz-column-gap: 10px;
      -webkit-column-count: 2;
      -webkit-column-gap : 10px;
      list-style: none;
    }
    
  </style>
</xmod:ScriptBlock>

<xmod:template runat="server" usepaging="False" ajax="True">

  <ListDataSource CommandText= "SELECT 
                                	loc.LocationID
                                  ,loc.City
                                  ,loc.STATE
                                  ,(SELECT COUNT(*)
                                    FROM XMP_Classified_Seller AS s
                                    INNER JOIN XMP_Classified_Level AS lvl ON s.Seller_Level = lvl.LevelID
                                    INNER JOIN XMP_Classified_Location AS l ON s.Seller_Location = l.LocationID
                                    INNER JOIN Users AS u ON s.UserID = u.UserID
                                    INNER JOIN UserPortals AS up ON s.UserID = up.UserId
                                    WHERE s.Seller_Location = loc.LocationID
                                    AND s.Agree = 1
                                    AND s.Banned = 0
                                    AND s.IsDeleted = 0
                                    AND up.Authorised = 1
                                    AND up.IsDeleted = 0
                                    ) AS SellerCount
                                FROM XMP_Classified_Location AS loc
                                ORDER BY loc.City" />

  
  <HeaderTemplate>

    <div class="modal fade" id="Location_Modal" tabindex="-1" role="dialog" aria-labelledby="Location_Modal">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
          	Locations
          </div>
          <div class="modal-body" style="overflow: auto;">
            <div class="text-center">
              <a style="color: white" id="view_all_ads" class="btn btn-warning" href="/Ads">View All Ads</a>
              <hr/>
            </div>            
            <ul class="ad-categories">

  </HeaderTemplate>

  <ItemTemplate>
              <li id="loc-<%#Eval("Values")("LocationID")%>">
                <a href="/Sellers?LocID=<%#Eval("Values")("LocationID")%>"><%#Eval("Values")("City")%>, <%#Eval("Values")("State")%>&nbsp;
                  <span class="text text-muted">(</span><%#Eval("Values")("SellerCount")%><span class="text text-muted">)</span>
                </a>
              </li>
  </ItemTemplate>

  <FooterTemplate>
            </ul>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal" aria-label="Close">Close</button>
            <a href="/Contact" class="btn btn-default">Suggest a Category</a>        
          </div>          
        </div>
      </div>
    </div>
  </FooterTemplate>

</xmod:template>

<script>
  
  var loc_url = "<%#UrlData("LocId")%>";  
  
  function pageLoad(){
    breadcrumb();
  }

  function breadcrumb() {
    
    var crumb = '<li><a href="/Sellers">All Sellers</a></li>';
    var placeholder = "Search sellers in ";

    if (loc_url) {

      var locLink = $('#loc-' + loc_url);

      crumb += '<li class="active"><a href="' + locLink.find("a").attr("href") + '">' + locLink.find("a").text() + '</a></li>';
      placeholder += locLink.find('a').text();
      
    } else {
     	placeholder += "all locations...";      
    }
    
    $('.seller-search').find('input[type="text"]').attr('placeholder', placeholder);
    $('#Sellers_Breadcrumb').html(crumb);

  } 
  
  $(document).ready(function() {
    $('.modal').appendTo('body');
  });
  
</script></xmod:masterview>