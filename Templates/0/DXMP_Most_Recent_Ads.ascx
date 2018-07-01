<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.TemplateBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls" TagPrefix="xmod" %>
<xmod:masterview runat="server">
<xmod:ScriptBlock runat="server" ScriptId="RecentAds" BlockType="HeadScript" RegisterOnce="True">
  <style type="text/css">
    #Popup_Modal .modal-body,
    #Reply_Modal .modal-body {
      background:url("/images/loading.gif") center no-repeat;
      overflow-y: hidden;
    }
    
    #RecentAds {
      margin-left: 0px;
      border: 1px solid #ebebeb;
      border-radius: 2px;
      position: relative;
    }
    
    #RecentAds li.media {
      border-bottom: 1px solid #ebebeb;
      margin-top: 0px;
      position: relative;      
    }
    
    #RecentAds li.media:nth-child(odd) { background: #f1f1f1; }
    
    #RecentAds li.media a {
      text-decoration: none;
    }
    
    #RecentAds li.media .fa-picture-o {
      font-size: 28px;
    	padding: 35px;
    }
    
    
    #RecentAds li.media:hover .fa-expand {
      opacity: 1;
    }
    
    #RecentAds li.media .media-left {
      padding: 0px;
      background: white;
    }
    
    #RecentAds li.media .media-body {
      border-left: 1px dashed #ebebeb;
      padding: 5px 0 5px 10px;
    }
    
    .recent-wrapper {
      position: relative;
      z-index: 9;
    }

    .ribbon-wrapper-green {
      width: 150px;
    	height: 150px;
      overflow: hidden;
      position: absolute;
      top: -3px;
      right: -3px;
      z-index: 99;
    }

    .ribbon-green {
      font: bold 15px Sans-Serif;
      color: #333;
      text-align: center;
      text-shadow: rgba(255,255,255,0.5) 0px 1px 0px;
      -webkit-transform: rotate(45deg);
      -moz-transform:    rotate(45deg);
      -ms-transform:     rotate(45deg);
      -o-transform:      rotate(45deg);
      position: relative;
      padding: 7px 0;
      left: -5px;
      top: 42px;
      width: 195px;
      background-color: #BFDC7A;
      background-image: -webkit-gradient(linear, left top, left bottom, from(#BFDC7A), to(#8EBF45)); 
      background-image: -webkit-linear-gradient(top, #BFDC7A, #8EBF45); 
      background-image:    -moz-linear-gradient(top, #BFDC7A, #8EBF45); 
      background-image:     -ms-linear-gradient(top, #BFDC7A, #8EBF45); 
      background-image:      -o-linear-gradient(top, #BFDC7A, #8EBF45); 
      color: #6a6340;
      -webkit-box-shadow: 0px 0px 3px rgba(0,0,0,0.3);
      -moz-box-shadow:    0px 0px 3px rgba(0,0,0,0.3);
      box-shadow:         0px 0px 3px rgba(0,0,0,0.3);
    }

    .ribbon-green:before, .ribbon-green:after {
      content: "";
      border-top:   3px solid #6e8900;   
      border-left:  3px solid transparent;
      border-right: 3px solid transparent;
      position:absolute;
      bottom: -3px;
    }

    .ribbon-green:before {
      left: 0;
    }
    .ribbon-green:after {
      right: 0;
    }
    
    #ad-share {
      position: absolute;
    	bottom: 13px;
    }
        
  </style>
  
</xmod:ScriptBlock>

<xmod:Template runat="server" UsePaging="False">
  <ListDataSource CommandText="SELECT TOP 25
                               	 a.[AdID]
                               	,a.[SellerID]
                               	,loc.City + ', ' + loc.State AS Location
                               	,a.[Ad_Title]
                               	,a.[Ad_Summary]
                               	,a.[Ad_Price]
                               	,a.[PrimaryImage]
                               	,s.[UserID] AS [SellerUserID]
                               
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
                               
                               ORDER BY a.[Date_Created] DESC">
  </ListDataSource>
  
  <HeaderTemplate>
 
    <div class="recent-wrapper">
      <div class="ribbon-wrapper-green"><div class="ribbon-green">MOST RECENT</div></div>
    	<ul id="RecentAds" class="media-list">
  </HeaderTemplate>
  
  <ItemTemplate>
        <li class="media">
          <a data-toggle="modal" 
             data-target="#Popup_Modal" 
             data-id="<%#Eval("Values")("AdID")%>" 
             data-title="<%#Eval("Values")("Ad_Title")%>" 
             data-source="/Ads/Details/Popup?AdID=<%#Eval("Values")("AdID")%>" href="#">
            <div class="media-left">
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
                 <span class="text text-muted"><small><%#Eval("Values")("Location")%></small></span>
              </h5>            
              <div>
                <span><small><xmod:Format runat="server" Type="Text" Value='<%#Eval("Values")("Ad_Summary")%>' MaxLength="150" /></small></span>
              </div>
            </div>
          </a>
          <xmod:Select runat="server">
            <Case Comparetype="Role" Operator="=" Expression="Registered Users">
              <xmod:Select runat="server">
                <Case Comparetype="Numeric" Value='<%#UserData("ID")%>' Operator="<>" Expression='<%#Eval("Values")("SellerUserID")%>'>
                  <button style="display: none"
                          type="button" 
                          data-toggle="modal" 
                          data-target="#Reply_Modal" 
                          data-source="/Ads/Details/Reply?AdID=<%#Eval("Values")("AdID")%>" 
                          data-title="Re: <%#Eval("Values")("Ad_Title")%>" 
                          class="btn btn-warning reply-btn">Reply to Ad
                  </button>                          
                </Case>
              </xmod:Select>
            </Case>            	
          </xmod:Select>   
        </li>
  </ItemTemplate>
  
  <FooterTemplate>
      </ul>
    </div>
    <a href="/Ads" class="btn btn-block btn-primary" style="color: white">See em' all!</a>
  </FooterTemplate>
                               

</xmod:Template>

<div class="modal fade" id="Popup_Modal" tabindex="-1" role="dialog" aria-labelledby="Popup_Modal">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header" style="height: 56px">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"></h4>
      </div>
      <div class="modal-body">
              
      </div>
      <div class="modal-footer" style="height: 65px">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <div class="addthis_sharing_toolbox"></div>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="Reply_Modal" tabindex="-1" role="dialog" aria-labelledby="Reply_Modal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header" style="height: 56px">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">&nbsp;</h4>
      </div>
      <div class="modal-body" style="min-height: 270px">

      </div>
      <div class="modal-footer" style="height: 65px">
        
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        
      </div>
    </div>
  </div>
</div>

<script>
  $(document).ready(function() {
    
    $('.modal').appendTo('body');
    var $modal = $('#Popup_Modal');
    var $replyModal = $('#Reply_Modal');

    ResizeModal($modal);
    
    
    $modal.on('shown.bs.modal',function(e){
      e.preventDefault();
      
      var $invoker = $(e.relatedTarget),
          id = $invoker.data("id"),
          title = $invoker.data("title"),
          source = $invoker.data("source"),
          $replyBtn = $invoker.next('button').clone().show();
      
      $modal.find('.modal-title').html(title);
      
      
      
      addthis.toolbox("#ad-share", null, { title: title, url: "http://aza-z.com/Ads/Details/AdID/" + id });
      
      if ($replyBtn.length) {
      	$modal.find('.modal-footer').prepend($replyBtn);  
      }
      
      var iframe = $('<iframe />', {
                     style: 'overflow-y:auto;height:100%;width:100%',
                     src: source,
                     class: 'ad-frame'        						 
                   });
      
      $modal.find('.modal-body').html(iframe);
      if (/iPhone|iPod|iPad/.test(navigator.userAgent)) {
        $modal.find('.modal-body').css("overflow-y", "scroll");
      }
    });
    
    $replyModal.on('shown.bs.modal',function(e){
      e.preventDefault();
      
      $modal.modal('hide');
      
      var $invoker = $(e.relatedTarget),
          source = $invoker.data("source"),
          title = $invoker.data("title");
      
      $replyModal.find('.modal-title').html(title);
      
      
      var iframe = $('<iframe />', {
                     style: 'overflow-y:auto;width:100%',
                     src: source,
                     height: 235,
                     class: 'ad-frame'
                   });
      
      $replyModal.find('.modal-body').html(iframe);
    });
    
    $(window).resize(function() {
      ResizeModal($modal);
    });  
    
    $modal.add($replyModal).on('hide.bs.modal', function(e) {
      $(this).find('iframe.ad-frame, .reply-btn').remove();
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

<script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-5b382d93b5e09337" async="async"></script></xmod:masterview>