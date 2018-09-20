<xmod:ScriptBlock ScriptId="RecentAds" BlockType="HeadScript" RegisterOnce="True">
  <style type="text/css">
    #Popup_Modal .modal-body,
    #Reply_Modal .modal-body {
      background: url("/images/loading.gif") center no-repeat;
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

    #RecentAds li.media:nth-child(odd) {
      background: #f1f1f1;
    }

    #RecentAds li.media a {
      text-decoration: none;
    }

    #RecentAds li.media a.focus {
      outline: none;
    }

    #RecentAds li.media .fa-picture-o {
      font-size: 36px;
      padding: 20px;
    }

    #RecentAds li.media .fa-expand {
      opacity: 0;
      position: absolute;
      right: 10px;
      top: 10px;
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

    .ribbon-box {
      position: relative;
      z-index: 9;
    }

    .ribbon {
      position: absolute;
      right: -5px;
      top: -5px;
      z-index: 1;
      overflow: hidden;
      width: 75px;
      height: 75px;
      text-align: right;
    }

    .ribbon span {
      font-size: 10px;
      font-weight: bold;
      color: #FFF;
      text-transform: uppercase;
      text-align: center;
      line-height: 20px;
      transform: rotate(45deg);
      -webkit-transform: rotate(45deg);
      width: 100px;
      display: block;
      background: #79A70A;
      background: linear-gradient(#F70505 0%, #8F0808 100%);
      box-shadow: 0 3px 10px -5px rgba(0, 0, 0, 1);
      position: absolute;
      top: 19px;
      right: -21px;
    }

    .ribbon span::before {
      content: "";
      position: absolute;
      left: 0px;
      top: 100%;
      z-index: -1;
      border-left: 3px solid #8F0808;
      border-right: 3px solid transparent;
      border-bottom: 3px solid transparent;
      border-top: 3px solid #8F0808;
    }

    .ribbon span::after {
      content: "";
      position: absolute;
      right: 0px;
      top: 100%;
      z-index: -1;
      border-left: 3px solid transparent;
      border-right: 3px solid #8F0808;
      border-bottom: 3px solid transparent;
      border-top: 3px solid #8F0808;
    }

    #ad-share {
      position: absolute;
      bottom: 13px;
    }
  </style>
</xmod:ScriptBlock>

<xmod:Template UsePaging="False">

  <ListDataSource CommandText="SELECT TOP 25 * FROM vw_XMP_All_Ads ORDER BY Date_Created DESC">
  </ListDataSource>

  <HeaderTemplate>
    <div class="ribbon-box">
      <div class="ribbon">
        <span>RECENT ADs!</span>
      </div>
      <ul id="RecentAds" class="media-list">
  </HeaderTemplate>

  <ItemTemplate>
    <li class="media">
      <a data-toggle="modal" data-target="#Popup_Modal" data-id="[[AdID]]" data-title="[[Ad_Title]]" data-source="/Ads/Details/Popup?AdID=[[AdID]]"
        href="#">
        <span class="fa fa-expand"></span>
        <div class="media-left">
          <xmod:IfNotEmpty Value='[[PrimaryImage]]'>
            <img class="media-object" alt="[[Ad_Title]]" src="/Portals/[[Portal:ID]]/Classifieds/Ads/[[SellerID]]/thm_[[PrimaryImage]]"
            />
          </xmod:IfNotEmpty>
          <xmod:IfEmpty Value='[[PrimaryImage]]'>
            <span class="fa fa-picture-o"></span>
          </xmod:IfEmpty>
        </div>
        <div class="media-body">
          <h4 class="media-heading">[[Ad_Title]]</h4>
          <h5>
            <xmod:IfNotEmpty Value='[[Ad_Price]]'>
              <span class="label label-success">
                <xmod:Format Type="Float" Value='[[Ad_Price]]' Pattern="c" />
              </span>
            </xmod:IfNotEmpty>
            <xmod:IfEmpty Value='[[Ad_Price]]'>
              <span class="label label-primary">FREE!</span>
            </xmod:IfEmpty>
            <span class="text text-muted">
              <small>[[CityState]]</small>
            </span>
          </h5>
          <div>
            <span>
              <small>
                <xmod:Format Type="Text" Value='[[Ad_Summary]]' MaxLength="150" />
              </small>
            </span>
          </div>
        </div>
      </a>

      <xmod:Select>
        <Case Comparetype="Role" Operator="=" Expression="Registered Users">
          <xmod:Select>
            <Case Comparetype="Numeric" Value='[[User:ID]]' Operator="<>" Expression='[[SellerUserID]]'>
              <button style="display: none" type="button" data-toggle="modal" data-target="#Reply_Modal" data-source="/Ads/Details/Reply?AdID=[[AdID]]"
                data-title="Re: [[Ad_Title]]" class="btn btn-warning reply-btn">Reply to Ad
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
    <!-- Go to www.addthis.com/dashboard to customize your tools -->
  </FooterTemplate>

</xmod:Template>

<div class="modal fade" id="Popup_Modal" tabindex="-1" role="dialog" aria-labelledby="Popup_Modal">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header" style="height: 56px">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title">&nbsp;</h4>
      </div>
      <div class="modal-body">

      </div>
      <div class="modal-footer" style="height: 65px">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <div id="ad-share" class="addthis_toolbox addthis_default_style addthis_32x32_style">
          <a class="addthis_button_facebook"></a>
          <a class="addthis_button_twitter"></a>
          <a class="addthis_button_google_plusone_share"></a>
          <a class="addthis_button_pinterest_share"></a>
          <a class="addthis_button_email"></a>
          <a class="addthis_button_compact"></a>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="Reply_Modal" tabindex="-1" role="dialog" aria-labelledby="Reply_Modal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header" style="height: 56px">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
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
  $(document).ready(function () {

    $('.modal').appendTo('body');
    var $modal = $('#Popup_Modal');
    var $replyModal = $('#Reply_Modal');

    ResizeModal($modal);


    $modal.on('shown.bs.modal', function (e) {
      e.preventDefault();

      //  You'll see below that instead of climbing up a level to the parent, we just 
      //  jump directly to the next element which is the reply button.
      var $invoker = $(e.relatedTarget),
        id = $invoker.data("id"),
        title = $invoker.data("title"),
        source = $invoker.data("source"),
        $replyBtn = $invoker.next('button').clone().show();

      $modal.find('.modal-title').html(title);

      addthis.toolbox("#ad-share", null, { title: title, url: "http://acich.org/Ads/Details/AdID/" + id });


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



    $replyModal.on('shown.bs.modal', function (e) {
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


    $(window).resize(function () {
      ResizeModal($modal);
    });


    $modal.add($replyModal).on('hide.bs.modal', function (e) {
      $(this).find('iframe.ad-frame, .reply-btn').remove();
    });

  });



  function ResizeModal($modal) {

    $modal.find('.modal-content').css('height', $(window).height() * 0.8);

    var totalHeight = parseInt($modal.find('.modal-content').css("height")),
      headerHeight = parseInt($modal.find('.modal-header').css("height")),
      footerHeight = parseInt($modal.find('.modal-footer').css("height")),
      bodyHeight = totalHeight - headerHeight - footerHeight;

    $modal.find('.modal-body').css("height", bodyHeight + "px");

  }

</script>

<!-- Go to www.addthis.com/dashboard to customize your tools -->
<script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-5b382d93b5e09337"></script>