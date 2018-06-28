<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.TemplateBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls" TagPrefix="xmod" %>
<xmod:masterview runat="server">
<xmod:ScriptBlock runat="server" ScriptId="MessagesScripts" BlockType="HeadScript" RegisterOnce="True">
  <style type="text/css">
    div.messages {
      height: 650px;
    }
    
    div.messages .conversation-list,
    div.messages .conversation-list > div {
      height: 100%;
      padding: 0;
    }
    
    .conversation-list .list-group {
      margin: 0;
      padding: 0px;
      height: 100%;
      overflow-y: auto;
      background: #f1f1f1;
      border: 1px solid #ddd;
      border-top-left-radius: 4px;
      border-bottom-left-radius: 4px;
    }
    
    
    .conversation-list .list-group-item {
      background-color: transparent;
      border: 0px;
      border-bottom: 1px solid #ddd;
      border-top-right-radius: 0px;
      border-bottom-right-radius: 0px;
      border-bottom-left-radius: 0px;
      margin-bottom: 0px;
      cursor: pointer;
    }
    
    .conversation-list .list-group-item .media {
      margin-top: 0px;
    }
    
    .conversation-list .list-group-item:hover {
      background-color: #ebebeb;
    }
    
    .conversation-list .list-group-item.viewing {
      background-color: #2d86f9;
      color: white;      
    }
    .conversation-list .media-left.user-pic {
      width: 45px;
      height: 45px;
      background-size: cover;
      background-position: center;
      border-radius: 50%;
    }
    .conversation-list .media-body {
      padding-left: 5px;
    }
    .conversation-list .media-body span {
      font-size: 12px;
    }
    .conversation-list .media-heading {
      font-size: 12px;
      max-width: 105px;
    }
    .conversation-list .media {
      position: relative;
      padding-left: 5px;
    }
    .conversation-list .date-stamp {
      position: absolute;
      font-size: 11px;
      right: 10px;
    }
    .conversation-list .read-stamp {
      position: absolute;
      left: -10px;
      color: #2d86f9;
      font-size: 28px;
      opacity: 0;
    }
    .conversation-list .read-stamp.False {
      opacity: 1;
    }
    
    .message-list {
      padding-left: 0px; 
      height: 100%;
    }
    
    .message-list .message-box {
      padding: 0px;
      height: 100%;
      border: 1px solid #ddd;
      border-left: 0px;    
    }
    
    .message-list .input-wrapper {
      background:url('/images/loading.gif') center no-repeat;
      height: 100px;
      overflow: hidden;
      display: none;
    }
    .message-list .message-heading {
      height: 65px;
      padding: 10px;
      border-bottom: 1px solid #ddd;
      background: #f1f1f1;
    }
    .message-list .message-body {
    	height: 470px;
      overflow-y: auto;
    }
    .message-list .message-footer {
    	padding: 10px;
      background: #f1f1f1;
      border-top: 1px solid #ddd;
      height: 113px;
    }
    
    ul.messages { list-style: none; margin-left: 0px; padding: 20px;}
    ul.messages li {}
    ul.messages li.bubble {
      margin-bottom: 20px;
    }
    ul.messages li.bubble.me {
      padding-left: 100px;
    }
    ul.messages li.bubble.them {
      padding-right: 100px;
    }
    
    ul.messages .message {
      padding: 10px;
      border-radius: 20px;
      position: relative;
    }
    
    ul.messages li.bubble.me .message {
      background-color: #2d86f9;
      color: white;     
    }
    ul.messages li.bubble.them .message {
      background-color: #f1f1f1;
      color: black;
    }
    
    ul.messages li.bubble .message:before {
      content: "";
      position: absolute;
      bottom: 0px;
      border-style: solid;
      display: block;
      width: 0;
    }
    
    ul.messages li.bubble.them .message:before {
      left: 3px;
      border-width: 0px 0px 10px 7px;
      border-color: transparent #f1f1f1;
    }
    
    ul.messages li.bubble.me .message:before {
      right: 3px;
      border-width: 0 7px 10px 0px;
      border-color: transparent #2d86f9;
    }
    
    ul.messages .date-stamp {
      text-align: center;
      font-size: 11px;
    }
    
    @media only screen and (max-width : 767px) {
      div.messages {
        height: auto;
      }
      div.messages .conversation-list {
        padding-right: 15px !important;
        padding-left: 15px !important;
        margin-bottom: 10px;
      }
      
      .message-list {
        padding-left: 15px !important;
        padding-right: 15px !important;
        height: 100%;
      }
      
      .message-list .message-box {
        border-left: 1px solid #ddd !important;    
      }
    }
  </style>
</xmod:ScriptBlock>

<div class="row messages">
  <div class="col-sm-4 conversation-list">
    <ul class="list-group">
      <xmod:Template runat="server" UsePaging="False" Ajax="False">
        <ListDataSource CommandText="
                     SELECT 

                         c.[ConversationID]
                        ,c.[Initiator]
                        ,a.[Ad_Title]
                        ,a.[AdID]
                        ,s.[Seller_Image]
                        ,recent.[Created] AS MostRecentDate
                        ,recent.[Message] AS MostRecentMessage
                        ,[status].[Read] 
                        ,convwith.[UserID] AS cwUserID
                        ,CASE WHEN(c.[Initiator] = @UserID) THEN s.Seller_Name
                            ELSE convwith.Username END 'cwUsername'
                        ,CASE WHEN(c.[Initiator] = @userID) THEN CAST(1 AS BIT)
                            ELSE CAST(0 AS BIT) END 'ShowSellerPic'

                      FROM XMP_Classified_Conversation c

                      INNER JOIN XMP_Classified_Ad a ON c.AdID = a.AdID
                        INNER JOIN XMP_Classified_Seller s ON a.SellerID = s.SellerID

                      INNER JOIN XMP_Classified_ConversationMessage recent 
                      ON (
                        c.[ConversationID] = recent.[ConversationID] AND
                        recent.MessageID = (SELECT TOP 1 MessageID 
                                  FROM XMP_Classified_ConversationMessage
                                  WHERE ConversationID = c.ConversationID
                                  ORDER BY Created DESC)
                         )

                      INNER JOIN XMP_Classified_ConversationStatus [status] 
                      ON (c.ConversationID = [status].[ConversationID] AND [status].[UserID] = @UserID)

                      INNER JOIN Users convwith 
                      ON convwith.[UserID] = (SELECT TOP 1 [UserID] 
                                  FROM XMP_Classified_ConversationStatus 
                                  WHERE ConversationID = c.ConversationID
                                  AND [UserID] <> @UserID)

                      ORDER BY recent.Created DESC">

          <Parameter Name="UserID" Value='<%#UserData("ID")%>' DataType="Int32" />    
        </ListDataSource>


          <ItemTemplate>
            <li class="list-group-item" data-cid="<%#Eval("Values")("ConversationID")%>">
              <div class="media">
                <span class="date-stamp"><xmod:Format runat="server" Type="Date" Value='<%#Eval("Values")("MostRecentDate")%>' Pattern="M/dd h:mm tt" /></span>
                <span class="read-stamp <%#Eval("Values")("Read")%>">&bull;</span>
                <xmod:Select runat="server">
                  <Case Comparetype="Boolean" Value='<%#Eval("Values")("ShowSellerPic")%>' Operator="=" Expression="True">
                    <xmod:IfNotEmpty runat="server" Value='<%#Eval("Values")("Seller_Image")%>'>
                      <div class="media-left user-pic" style="background-image: url('/Portals/<%#PortalData("ID")%>/Classifieds/SellerImages/thm_<%#Eval("Values")("Seller_Image")%>')"></div>
                    </xmod:IfNotEmpty>
                    <xmod:IfEmpty runat="server" Value='<%#Eval("Values")("Seller_Image")%>'>
                      <div class="media-left user-pic" style="background-image: url('/profilepic.ashx?userId=0&h=60&w=60')"></div>
                    </xmod:IfEmpty>

                  </Case>
                  <Else>
                    <div class="media-left user-pic" style="background-image: url('/profilepic.ashx?userId=<%#Eval("Values")("cwUserID")%>&h=60&w=60')"></div>
                  </Else>
                </xmod:Select>


                <div class="media-body">
                  <h4 class="media-heading to"><xmod:Format runat="server" Type="Text" Value='<%#Eval("Values")("cwUsername")%>' MaxLength="40" /></h4>
                  <h4 class="media-heading re" style="display: none"><%#Eval("Values")("Ad_Title")%></h4>
                  <span class="recent-msg"><em><xmod:Format runat="server" Type="Text" Value='<%#Eval("Values")("MostRecentMessage")%>' MaxLength="40" /></em></span>
                </div>
              </div>    	
            </li>    
          </ItemTemplate>

        <NoItemsTemplate>

            <li style="padding: 15px; list-style: none">No messages...</li>

        </NoItemsTemplate>
      </xmod:Template>
    </ul>

  </div>
  <div class="col-sm-8 message-list">
    <div class="message-box">
      <div class="message-heading">
        <span class="to" style="display: block"></span>
        <span class="re" style="display: block"></span>
      </div>
      <div class="message-body">
        <ul class="messages">

        </ul>
      </div>
      <div class="message-footer">
        <div class="input-wrapper">

        </div>
      </div>
    </div>
  </div>


</div>
	

<script type="text/javascript">

  var $msgHeader = $('.message-box').find('.message-heading'),
      $msgFooter = $('.message-box .message-footer'),
      $home = $('.message-box .messages'),
      $body = $('.message-box .message-body'),
      $convList = $('.conversation-list ul'),
      $activeConv = $convList.children('li.list-group-item').first(),
      $Count = $('#Menu_Messages').find('span');

  $(document).ready(function() {


    if ($activeConv.length) {
      $msgFooter.find('.input-wrapper').fadeIn('fast');
      GetConversation(false);        
    }


    $convList.children("li.list-group-item").click(function() {
      $activeConv = $(this);
      GetConversation(false);      
    });

  });



  function GetConversation(reload) {

    var cid = $activeConv.data("cid"),
        to  = $activeConv.find('.to').text(),
        re  = $activeConv.find('.re').text(),
        $NewMsg = undefined;
    
    $.ajax({
      url: '/DesktopModules/XModPro/Feed.aspx',
      type: 'POST',
      dataType: 'HTML',
      data: {
        "xfd" : "GetConversation",
        "pid" : 0,
        "cid" : parseInt(cid)
      },

      success: function(data) {
        $home.html(data);
        $body.scrollTop(999999);

        if (reload) {
          
          $NewMsg = $home.children('li').last();
          var recentMsg = $NewMsg.find('.message').text();
          var recentDate = $NewMsg.find('.date-stamp').text();

          $activeConv.find('.date-stamp').text(recentDate);
          $activeConv.find('.recent-msg').text(recentMsg);
        
        }
      }      
    });

    $msgHeader.find('.to').text("To: " + to);
    $msgHeader.find('.re').text("Re: " + re);

    if (!reload) {
      
      $msgFooter.find('iframe').remove();
      $activeConv.siblings().removeClass('viewing');
      
      if ($activeConv.find('.read-stamp').hasClass("False")) {
       	var count = parseInt($Count.text());
        count --
        $Count.text(count);
      }
      
      $activeConv.addClass('viewing').find('.read-stamp').removeClass("False"); 

      var iframe = $('<iframe />', {
        style: 'overflow-y:auto;width: 100%; height: 100px; visibility: hidden',
        src: '/Dashboard/Messages/Reply?&ConversationID=' + cid,
        border: 0,
        onload: "this.style.visibility = 'visible';"
      });

      $msgFooter.find('.input-wrapper').html(iframe);
    }
  }
</script></xmod:masterview>