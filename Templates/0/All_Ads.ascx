<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.TemplateBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls" TagPrefix="xmod" %>
<xmod:masterview runat="server">
<xmod:ScriptBlock runat="server" ScriptId="RecentAds" BlockType="HeadScript" RegisterOnce="True">
  <style type="text/css">
    #Body { background: #E8F1F8; }

    #Popup_Modal .modal-body {
      background:url("/images/loading.gif") center no-repeat;
    }

    #AllAds div.media.ad {
      border: 1px solid #ebebeb;
      border-radius: 2px;
      position: relative;
      margin-bottom: 25px;
      background: white;
    }

    #AllAds div.media-left.middle {
      vertical-align: middle; 
    }

    #AllAds div.media a {
      text-decoration: none;
    }

    #AllAds div.media img {
      max-height: 100px;
    }

    #AllAds div.media .fa-picture-o {
      font-size: 28px;
      padding: 35px;
    }

    #AllAds div.media .fa-expand {
      opacity: 0;      
      position: absolute;
      right: 10px;
      top: 10px;
    }

    #AllAds div.media:hover .fa-expand {
      opacity: 1;
    }

    #AllAds div.media .media-left {
      padding: 0px;
      background: white;
      height: 130px;
    }

    #AllAds div.media .media-body {
      border-left: 1px dashed #ebebeb;
      padding: 5px 0 5px 10px;
    }

    .pager-active {
      color: #fff !important;
      background-color: #337ab7 !important;
      border-color: #337ab7 !important;
    }
    
    @media all and (-ms-high-contrast: none), (-ms-high-contrast: active) {
      .marketing .col-lg-4 { width: 33.33333333%; }
    }
   	
  </style>
</xmod:ScriptBlock>

<xmod:Template runat="server" UsePaging="True" Ajax="True">

  <ListDataSource CommandText= "SELECT *
                                FROM vw_XMP_All_Ads
                                WHERE (
                                    (
                                      EXISTS (
                                        SELECT *
                                        FROM XMP_Classified_AdCategory
                                        WHERE AdID = AdID
                                          AND CategoryID = @Category
                                        )
                                      )
                                    OR (@Category = - 1)
                                    )
                                  AND LocationID = CASE 
                                    WHEN (@Location = - 1)
                                      THEN LocationID
                                    ELSE @Location
                                    END
                                ORDER BY Date_Created DESC">
    <Parameter Name="Category" Value='<%#UrlData("Id")%>' DefaultValue="-1" DataType="Int32" />
	  <Parameter Name="Location" Value='<%#UrlData("LocId")%>' DefaultValue="-1" DataType="Int32" />
	</ListDataSource>
  
  <Pager 
    PageSize="50" 
    ShowTopPager="False" 
    ShowBottomPager="True" 
    ShowFirstLast="True" 
    FirstPageCaption="First" 
    LastPageCaption="Last" 
    ShowPrevNext="True" 
    NextPageCaption="&raquo;" 
    PrevPageCaption="&laquo;"
    ScrollToTop="True"
    CurrentPageCssClass="pager-active">
    <ul class="pagination">
      <li>{pager}</li>
    </ul>
  </Pager>
  
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
        <button type="button" 
                class="btn btn-primary" 
                data-toggle="modal" 
                data-target="#Category_Modal">Categories &amp; Locations
        </button>
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
  	<div class="ribbon-box">
      <ul id="RecentAds" class="media-list">
  </HeaderTemplate>
  
	<HeaderTemplate>
    <div id="AllAds" class="row">
  </HeaderTemplate>

  <ItemTemplate>
      <div class="col-md-4 col-sm-6">
        <div class="media ad">
          <a data-toggle="modal" data-target="#Popup_Modal" data-id="<%#Eval("Values")("AdID")%>" data-title="<%#Eval("Values")("Ad_Title")%>" href="#">
            <span class="fa fa-expand"></span>
            <div class="media-left middle">
              <xmod:IfNotEmpty runat="server" Value='<%#Eval("Values")("PrimaryImage")%>'>
                <img class="media-object" alt="<%#Eval("Values")("Ad_Title")%>" src="/Portals/<%#PortalData("ID")%>/Classifieds/Ads/<%#Eval("Values")("SellerID")%>/thm_<%#Eval("Values")("PrimaryImage")%>" />
              </xmod:IfNotEmpty>
              <xmod:IfEmpty runat="server" Value='<%#Eval("Values")("PrimaryImage")%>'>
                <img class="img-responsive center-block" alt="<%#Eval("Values")("Ad_Title")%>" src="http://placehold.it/80?text=no+image" />
              </xmod:IfEmpty>
            </div>
            <div class="media-body">
              <h4 class="media-heading"><%#Eval("Values")("Ad_Title")%></h4>
              <h5>
                <xmod:IfNotEmpty runat="server" Value='<%#Eval("Values")("Ad_Price")%>'>
                  <span class="label label-success"><xmod:Format runat="server" Type="Float" Value='<%#Eval("Values")("Ad_Price")%>' Pattern="c" /></span>
                </xmod:IfNotEmpty>
                <xmod:IfEmpty runat="server" Value='<%#Eval("Values")("Ad_Price")%>'>
                  <span class="label label-primary">FREE!</span>
                </xmod:IfEmpty>
                <span class="text text-muted"><small><%#Eval("Values")("CityState")%></small></span>
              </h5>            
              <div>
                <span><small><xmod:Format runat="server" Type="Text" Value='<%#Eval("Values")("Ad_Summary")%>' MaxLength="150" /></small></span>
              </div>
            </div>
          </a>
        </div>
      </div>
  </ItemTemplate>

  <FooterTemplate>
    </div>
  </FooterTemplate>
  
</xmod:Template>

<div class="modal fade" id="Popup_Modal" tabindex="-1" role="dialog" aria-labelledby="Popup_Modal">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header" style="height: 56px">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">&nbsp;</h4>
      </div>
      <div class="modal-body">
        <iframe style="overflow:hidden;height:100%;width:100%"></iframe>        
      </div>
      <div class="modal-footer" style="height: 65px">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>        
      </div>
    </div>
  </div>
</div>

<script>
  $(document).ready(function() {
		
    // Helps prevent styling conflict on certain browsers
    $('.modal').appendTo('body');
    
    // Caching the popup so we don't have to keep looking for it
    var $modal = $('#Popup_Modal');

    // Sizing it initially although hidden from view to prevent first load size jump
    ResizeModal($modal);
    
    $modal.on('shown.bs.modal',function(e){
      // Prevent any default behavior
      e.preventDefault();
      
      // The invoker is the link that was clicked on where we hide data attributes
      var $invoker = $(e.relatedTarget),
          id = $invoker.data("id"),
          title = $invoker.data("title");
      
      // Now that we have the title of the ad, and id of the ad, we can populate:      
      $modal.find('.modal-title').html(title);
      $modal.find('iframe').attr("src", "/Ads/Details/Popup?AdID=" + id);
			
		});
    
    // In the event that the browser window is resized, we need to resize the modal on the fly
    $(window).resize(function() {
      ResizeModal($modal);
    });  
    
    $('.modal').on('hide.bs.modal', function(e) {
      // When a modal is closed, we need to wipe out the src attribute.
      $(this).find('iframe').removeAttr("src");      
    });
    
    
  });
  
  function ResizeModal($modal) {
    $modal.find('.modal-content').css('height', $(window).height()*0.8);
            
    // Simple math. Grab the total height and remove the header and footer from it, leaving us with the correct size for the body
    var totalHeight = parseInt($modal.find('.modal-content').css("height")),
        headerHeight = parseInt($modal.find('.modal-header').css("height")),
        footerHeight = parseInt($modal.find('.modal-footer').css("height")),
        bodyHeight = totalHeight - headerHeight - footerHeight;
    
    // Finally, force sizing on the modal body
    $modal.find('.modal-body').css("height", bodyHeight + "px");		
    
  }
  
</script></xmod:masterview>