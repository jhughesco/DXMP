<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.TemplateBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls" TagPrefix="xmod" %>
<xmod:masterview runat="server">
<div id="Ads_Wrapper" style="margin-top: 40px">
  <xmod:ScriptBlock runat="server" ScriptId="RecentAds" BlockType="HeadScript" RegisterOnce="True">
    <style type="text/css">

      #Body { background: #fff; }

      #Popup_Modal .modal-body {
        background:url("/images/loading.gif") center no-repeat;
        overflow-y: hidden;
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
        font-size: 36px;
        padding: 20px;
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
      
      ol.breadcrumb { margin-left: 0px; }
    		ol.breadcrumb li.pull-right:before {
      		content: "";
    	}

  	</style>
  </xmod:ScriptBlock>

  <xmod:Template runat="server" UsePaging="True" Ajax="True">

    <ListDataSource CommandText= "SELECT 
                                   a.[AdID]
                                  ,a.[SellerID]
                                  ,loc.City + ', ' + loc.State AS CityState
                                  ,a.[Ad_Title]
                                  ,a.[Ad_Summary]
                                  ,a.[Ad_Price]
                                  ,a.[PrimaryImage]
                                 	
                                 FROM XMP_Classified_Ad a
                                 LEFT JOIN XMP_Classified_Location loc ON a.LocationID = loc.LocationID
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
                                 AND 
                                  (
                                    (
                                      EXISTS(SELECT * FROM XMP_Classified_AdCategory WHERE AdID = a.AdID AND CategoryID = @Category)
                                    )

                                    OR

                                    (
                                      @Category = -1
                                    )
                                  )
                                 AND a.LocationID = CASE WHEN(@Location = -1) THEN a.LocationID ELSE @Location END

                                 ORDER BY a.[Date_Created] DESC">
      
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
      
      <div class="row">
        <div class="col-sm-12">
          <ol id="Ads_Breadcrumb" class="breadcrumb">
            <li>All Ads</li>
          </ol>
        </div>  
      </div>
      
      <div id="AllAds" class="row">
  </HeaderTemplate>

  <ItemTemplate>
      	<div class="col-md-4 col-sm-6">
        	<div class="media ad">
            <a data-toggle="modal" 
               data-target="#Popup_Modal" 
               data-id="<%#Eval("Values")("AdID")%>" 
               data-title="<%#Eval("Values")("Ad_Title")%>" 
               data-source="/Ads/Details/Popup?AdID=<%#Eval("Values")("AdID")%>"
               href="#">
              <span class="fa fa-expand"></span>
              <div class="media-left middle">
                <xmod:IfNotEmpty runat="server" Value='<%#Eval("Values")("PrimaryImage")%>'>
                  <img class="media-object" alt="<%#Eval("Values")("Ad_Title")%>" src="/Portals/<%#PortalData("ID")%>/Classifieds/Ads/<%#Eval("Values")("SellerID")%>/thm_<%#Eval("Values")("PrimaryImage")%>" />
                </xmod:IfNotEmpty>
                <xmod:IfEmpty runat="server" Value='<%#Eval("Values")("PrimaryImage")%>'>
                  <span class="fa fa-picture-o"></span>
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
    
  <NoItemsTemplate>
    <div class="row">
      <div class="col-sm-12">
        <ol id="Ads_Breadcrumb" class="breadcrumb">
          <li>All Ads</li>
        </ol>
      </div>  
    </div>
    <div class="row">
      <div class="col-sm-12 text-center">
        <i class="fa fa-warning" style="font-size: 5em; display: block"></i>
        <h3>Bummer! No ads found.</h3>
        <h4>Try changing your search, location, or category.</h4>
      </div>
    </div>
  </NoItemsTemplate>

  </xmod:Template>

  <div class="modal fade" id="Popup_Modal" tabindex="-1" role="dialog" aria-labelledby="Popup_Modal">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header" style="height: 56px">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title">&nbsp;</h4>
        </div>
        <div class="modal-body">

        </div>
        <div class="modal-footer" style="height: 65px">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>        
        </div>
      </div>
    </div>
  </div>
</div>    

<script>
  $(document).ready(function() {
    
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
          title = $invoker.data("title"),
          source = $invoker.data("source");
      
      $modal.find('.modal-title').html(title);
        var iframe = $('<iframe />', {
                       style: 'overflow-y:auto;height:100%;width:100%',
                       src: source    						 
                     });
  
  		$modal.find('.modal-body').html(iframe);
      
      if (/iPhone|iPod|iPad/.test(navigator.userAgent)) {
        $modal.find('.modal-body').css("overflow-y", "scroll");
      }
      
		});
    
    $(window).resize(function() {
      ResizeModal($modal);
      ResizeModal($cats);
    });  
    
    $('.modal').on('hide.bs.modal', function(e) {
      $(this).find('iframe').remove();      
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
  
</script></xmod:masterview>