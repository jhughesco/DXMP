<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.TemplateBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls" TagPrefix="xmod" %>
<xmod:masterview runat="server">
<ScriptBlock ScriptId="CustomCSS" BlockType="HeadScript" RegisterOnce="true">
	<style type="text/css">
  	.dash-header { margin-bottom: 25px; }
    .dash-header h3 { margin: 0px 0px 15px; }
    .btn-success { color: white !important; }
    a.fix_link, a.fix_link:visited, a.fix_link:hover { color: #fff; font-size: 14px; }
    .topbot10 { margin: 10px 0; }
    
    /*When the modal fills the screen it has an even 2.5% on top and bottom*/
    /*Centers the modal*/
    /*
    .modal-dialog {
      margin: 2.5vh auto;
    }
		*/
    
    /*Sets the maximum height of the entire modal to 95% of the screen height*/
    /*
    .modal-content {
      max-height: 20vh;
    }
    */

    /*Sets the maximum height of the modal body to 90% of the screen height*/
    /*
    .modal-body {
      max-height: 13vh;
    }
    */
    
    /*Sets the maximum height of the modal image to 69% of the screen height*/
    /*
    .modal-body img {
      max-height: 17vh;
    }
    */
         
    
	</style>
</ScriptBlock>

<xmod:Template runat="server">

  <ListDataSource CommandText="
        IF (
            (
              SELECT COUNT(*)
              FROM Users
              WHERE UserID = @UserID
              ) > 0
            )
          --We have a logged in User
        BEGIN
          IF (
              (
                SELECT COUNT(*)
                FROM XMP_Classified_Seller s
                INNER JOIN Users u ON u.UserID = s.UserID
                WHERE u.UserID = @UserID
                ) > 0
              )
          BEGIN
            IF (
                SELECT COUNT(*) AS Seller
                FROM ROLES r
                INNER JOIN UserRoles ur ON r.RoleID = ur.RoleID
                WHERE r.RoleName = 'Sellers'
                ) > 0
            BEGIN
              SELECT UserType = CASE 
                  WHEN up.Authorised = 0
                    THEN 'UnAuthorised'
                  WHEN up.IsDeleted = 1
                    THEN 'UserIsDeleted'
                  WHEN s.Banned = 1
                    THEN 'SellerBanned'
                  WHEN s.IsDeleted = 1
                    THEN 'SellerIsDeleted'
                  ELSE 'Seller'
                  END
              FROM Users u
              INNER JOIN UserPortals up ON u.UserID = up.UserId
              INNER JOIN XMP_Classified_Seller s ON u.UserID = s.UserID
              WHERE U.UserID = @UserID
            END
            ELSE
              SELECT 'NoSellersRole' AS UserType
          END
          ELSE
            SELECT 'NotSeller' AS UserType
        END
        ELSE
          SELECT 'UnRegistered' AS UserType --Not Registered User | Not logged in">
    
    <Parameter Name="UserID" Value='<%#UserData("ID")%>' DefaultValue="-1" DataType="int32" /> 
  </ListDataSource>


  <ItemTemplate>
		
    <xmod:Select runat="server">

      <Case CompareType="Text" Expression='<%#Eval("Values")("UserType")%>' Operator="=" Value="Seller">
        <div class="topbot10">
            <a href="/Dashboard/Post-Ad" class="btn btn-success fix_link btn-block">
              Post Ad
            </a>
        </div>
      </Case>
      <Case CompareType="Text" Expression='<%#Eval("Values")("UserType")%>' Operator="=" Value="NotSeller">
        <div class="topbot10">
            <a href="/Dashboard/Sign-Up?postad=NotSeller" class="btn btn-success fix_link btn-block">
              Post Ad
            </a>
        </div>
      </Case>
      <Case CompareType="Text" Expression='<%#Eval("Values")("UserType")%>' Operator="=" Value="UnRegistered">
        <div class="topbot10">
            <a href="/Join?postad=UnRegistered" class="btn btn-success fix_link btn-block">
              Post Ad
            </a>
        </div>
      </Case>
      <Case CompareType="Role" Expression="Unverified Users" Operator="=">
        <div class="topbot10">
            <a href="/Join/Verify" class="btn btn-success fix_link btn-block">
              Post Ad
            </a>
        </div>
      </Case>
      
      <Else>
      	<div class="topbot10">
            <a data-toggle="modal" 
               data-target="#Popup_Modal" 
               data-id='<%#UserData("ID")%>' 
               data-title="Account Error" 
               data-source="/Home/Popup"
               href="#"
               class="btn btn-success fix_link btn-block">
              Post Ad
            </a>
        </div>
      </Else>

    </xmod:Select>


  </ItemTemplate> 



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
          title = $invoker.data("title"),
          source = $invoker.data("source");
      
      // Now that we have the title of the ad, and id of the ad, we can populate:      
      $modal.find('.modal-title').html(title);
      
      var iframe = $('<iframe />', {
                     style: 'overflow-y:auto;height:100%;width:100%',
                     src: source    						 
                   });
  
      $modal.find('.modal-body').html(iframe);
			
		});
    
    // In the event that the browser window is resized, we need to resize the modal on the fly
    $(window).resize(function() {
      ResizeModal($modal);
    });  
    
    $('.modal').on('hide.bs.modal', function(e) {
      // When a modal is closed, we need to destroy iframe.
      $(this).find('iframe').remove();      
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