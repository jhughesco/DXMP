<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.FormBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls.Form" TagPrefix="xmod" %>
<%@ Register tagprefix="rmg" namespace="reflect.xile" assembly="reflect.xile" %>
<xmod:FormView runat="server"><AddItemTemplate><xmod:AddForm runat="server" ClientName="Ad">

    <ScriptBlock ScriptId="CustomCSS" BlockType="HeadScript" RegisterOnce="true">
      <style type="text/css">
        .validate-error {
            position: absolute;
            top: 0;
            left: 0;
            color: red;
        }

        .validate-error-addon {
            left: -15px;
        }

        .required-field {
            border-left: 1px solid red;
        }

        #Categories_Container {
            list-style-type: none;
            margin-left: 0px;
        }

            #Categories_Container ul {
                list-style-type: none;
                margin-left: 25px
            }

        .Categories_Container {
            list-style-type: none;
            margin-left: 0px;
        }

            .Categories_Container ul {
                list-style-type: none;
                margin-left: 25px
            }

        li.children {
            display: none;
        }

            li.children.show {
                display: block;
            }

        .post-ad-form {
            margin-top: 40px;
        }

            .post-ad-form .checkbox {
                padding-left: 25px;
            }

            .post-ad-form .admin-functions, .post-ad-form .user-options {
                margin-top: 25px;
            }

                .post-ad-form .admin-functions h3, .post-ad-form .user-options h3, .post-ad-form .seller-name h3 {
                    margin-top: 0px;
                    padding-bottom: 10px;
                }

                .post-ad-form .admin-functions h3 {
                    border-bottom: 1px solid wheat;
                }

                .post-ad-form .user-options h3 {
                    border-bottom: 1px solid #e6e6e6;
                }

            .post-ad-form .seller-name h3 {
                border-bottom: 1px solid #e6e6e6;
            }

       .info_panel_spacing {
            margin-top: 10px;
        }

        .input-group .form-control:not(:first-child):not(:last-child) {
            border-radius: 0 4px 4px 0;
        }

        .HeaderLabel {
            color: inherit;
            opacity: 0.7;
            font-size: 75%;
            font-weight: normal;
        }
        .HeaderLabel_Small {
            color: inherit;
            opacity: 0.7;
            font-weight: normal;
        }
        </style>

	    <script src="/js/tinymce/tinymce.min.js"></script>
      
    </ScriptBlock>

    <SelectCommand CommandText="SELECT SellerID
                                			,Seller_Name
                                			,Seller_Level
                                			,CASE WHEN Seller_Level = 3 THEN 'You will receive an email confirmation when your ad is approved.' ELSE 'Your ad has been instantly approved.' END 'ApprovalMessage'
                                      ,LocationID
                                      ,ShowAddress
                                      ,ShowPhone
                                      ,0 AS ShowEmail
                                      ,@UserID AS CreatedBy
                                      ,@UserIP AS Created_IP

                                  FROM vw_XMP_Admin_Seller_Detail
                                  WHERE UserID = @UserID">
      
      	
      	<Parameter Name="UserID" Value='<%#UserData("ID")%>' DataType="int32" />
        <Parameter Name=UserIP Value='<%#RequestData("HostAddress")%>' DataType="string" />
    
  </SelectCommand>

    <SubmitCommand CommandText="XMP_Classified_Seller_PostAd" CommandType="StoredProcedure">
      <Parameter Name="SellerID" />
      <Parameter Name="Seller_Level" />
      <Parameter Name="LocationID" />
      <Parameter Name="Ad_Title" />
      <Parameter Name="Ad_Subtitle" />
      <Parameter Name="Ad_Price" />
      <Parameter Name="PrimaryImage" />
      <Parameter Name="AdditionalImages" />
      <Parameter Name="Categories" />
      <Parameter Name="Ad_Summary" />
      <Parameter Name="Ad_Description" />
      <Parameter Name="CreatedBy" />
      <Parameter Name="Created_IP" />
      <Parameter Name="ShowAddress" />
      <Parameter Name="ShowPhone" />
      <Parameter Name="ShowEmail" />
    </SubmitCommand>

    <ControlDataSource Id="cds_Locations" CommandText="SELECT [LocationID], [City] + ', ' + [State] AS CityState FROM [XMP_Classified_Location] ORDER BY [City] ASC"
    />

    <ControlDataSource Id="cds_Categories" CommandText="
			SELECT *
      FROM (
        SELECT CategoryID
          ,Category_Name
          ,ParentID
          ,Date_Created
          ,Date_Updated
          ,Sort_Order
          ,Sort_Order AS First_Level
          ,NULL AS Second_Level
          ,Active
        FROM XMP_Classified_Category
        WHERE ParentID IS NULL

      UNION ALL

        SELECT c.CategoryID
          ,' - ' + c.Category_Name AS Category_Name
          ,c.ParentID
          ,c.Date_Created
          ,c.Date_Updated
          ,c.Sort_Order
          ,d.Sort_Order AS First_Level
          ,c.Sort_Order AS Second_Level
          ,c.Active
        FROM XMP_Classified_Category c
        INNER JOIN XMP_Classified_Category d ON c.ParentID = d.CategoryID
        WHERE c.ParentID IS NOT NULL
        ) AS Categories
      ORDER BY Categories.First_Level,Categories.Second_Level" />

<div style="text-align: center;"><h2>Post Classified Ad</h2></div>

	<div class="panel panel-primary info_panel_spacing">
      <div class="panel-heading">
        <h3 class="panel-title">Primary Information</h3>
      </div>
      <div class="panel-body">

        <div class="form-group">
          <Label For="LocationID">Location |<small Class="HeaderLabel_Small"> This is where the item is located.</small></Label>
          <DropDownList Id="LocationID" CssClass="form-control required-field" Nullable="true" DataField="LocationID" DataSourceId="cds_Locations"
                    DataTextField="CityState" DataValueField="LocationID" AppendDataBoundItems="true" DataType="int32">
            <ListItem Value="">
            - Select Location -
            </ListItem>
          </DropDownList>
          <Validate Target="LocationID" CssClass="validate-error" Type="required" Text="*" Message="Location is required." />
        </div>

        <div class="alert alert-warning" style="margin-top: 15px;">
          <strong>Location not found?</strong> We currently service the Maricopa County area. We will consider expansion within reason. <a href="/Contact" target="_blank">Contact Us</a> to inquire.
        </div>

        <div class="form-group">
          <Label For="Ad_Title">Ad Title |<small Class="HeaderLabel_Small"> The main title for your ad.</small></Label>
          <TextBox Id="Ad_Title" CssClass="form-control required-field" Nullable="true" MaxLength="150" DataField="Ad_Title" DataType="string"/>
          <Validate Target="Ad_Title" CssClass="validate-error" Type="required" Text="*" Message="Ad Title is required." />
        </div>

        <div class="form-group">
          <Label For="Ad_Subtitle">Ad Subtitle |<small Class="HeaderLabel_Small"> You can use this like a <em>call-to-action</em> as well</small></Label>
          <TextBox Id="Ad_Subtitle" CssClass="form-control" Nullable="true" MaxLength="150" DataField="Ad_Subtitle" DataType="string" />
        </div>

        <div class="form-group">
          <Label For="Ad_Price">Ad Price |<small Class="HeaderLabel_Small"> Leave this blank if it's free.</small></Label>
          <div class="input-group">
            <div class="input-group-addon">$</div>
                <TextBox Id="Ad_Price" CssClass="form-control" Width="150px" Nullable="True" DataField="Ad_Price" DataType="decimal" />
                <Validate Target="Ad_Price" CssClass="validate-error validate-error-addon" Type="regex" Message="Please enter price only (1234.00)" Text="*" ValidationExpression="^\d{0,10}(\.\d{1,2})?$" />
            </div>
        </div>

      </div>
    </div>


    <div class="panel panel-default">
        <div class="panel-heading">
        <h3 class="panel-title">Describe It</h3>
        </div>
        <div class="panel-body">
            <div class="form-group">
              <Label For="Ad_summary">Ad Summary |<small Class="HeaderLabel_Small"> Think of this like a short teaser.</small></Label>
              <TextArea Id="Ad_summary" MaxLength="250" CharacterCount="CountDown" CharacterCountLabel="remaining" CssClass="form-control" Nullable="true" DataField="Ad_Summary" DataType="string" />
            </div>

            <div class="form-group">
              <Label For="Ad_Description">Ad Description |<small Class="HeaderLabel_Small"> This will show on your ads detailed description.</small></Label>
              <TextArea Id="Ad_Description" CssClass="form-control tinymce" Height="200" Nullable="true" DataField="Ad_Description" DataType="string" />
            </div>
        </div>
    </div>
    
    <div class="panel panel-default">
        <div class="panel-heading">
        <h3 class="panel-title">Panel title</h3>
        </div>
        <div class="panel-body">
            <div class="form-group">
                <Label For="PrimaryImage">Primary Image |<small Class="HeaderLabel_Small"> This will be the first image shown.</small></Label>
                <rmg:Xile runat="server" Id="PrimaryImage" 
                          Nullable="True" 
                          DataField="PrimaryImage" 
                          Dropzone="False" 
                          AcceptFileTypes="jpg,jpeg,png" 
                          MaxNumberOfFiles="1"
                          MaxFileSize="2097152" 
                          AutoUpload="True" 
                          AutoCreateFolder="True" 
                          FileUploadPath='<%#Join("~/Portals/{0}/Classifieds/Ads/{1}/", PortalData("ID"), SelectData("SellerID"))%>'
                          ResizeVersions="width=800;height=600;mode=max, md_:width=400;height=400; sm_:width=200;height=200;mode=max;mode=max, thm_:width=80;height=80;mode=max"
                          UniqueFileName="True" 
                          UploadMode="Single" 
                          AddFilesButtonText="Add Image" 
                          WrapperClass="rmg-singleupload"
                          ShowTopCancelButton="False" 
                          ShowTopCheckBox="False" 
                          ShowTopProgressBar="False" 
                          ShowTopDeleteButton="False"
                          AllowedRoles="Sellers">
                </rmg:Xile>
            </div>

            <div class="form-group">
                <Label For="AdditionalImages">Additional Images |<small Class="HeaderLabel_Small"> Seen on your ads detail page.</small></Label>
                <rmg:Xile runat="server" Id="AdditionalImages" 
                          Nullable="True" 
                          DataField="AdditionalImages" 
                          Dropzone="True" 
                          AcceptFileTypes="jpg,jpeg,png"
                          MaxNumberOfFiles="20" 
                          AutoUpload="True" 
                          AutoCreateFolder="True" 
                          ResizeVersions="width=800;height=600;mode=max, md_:width=400;height=400; sm_:width=200;height=200;mode=max;mode=max, thm_:width=80;height=80;mode=max"
                          FileUploadPath='<%#Join("~/Portals/{0}/Classifieds/Ads/{1}/", PortalData("ID"), SelectData("SellerID"))%>' 
                          UniqueFileName="True"
                          UploadMode="Multiple" 
                          AddFilesButtonText="Add Files..."
                          AllowedRoles="Sellers">
                </rmg:Xile>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading">
        <h3 class="panel-title">Categories |<span Class="HeaderLabel"> Select at least one.</span></h3>
        </div>
        <div class="panel-body">
            <ListBox Id="Categories" CssClass="form-control" Nullable="true" DataField="Categories" DataType="String" DataSourceId="cds_Categories"
                        DataTextField="Category_Name" DataValueField="CategoryID" AppendDataBoundItems="true" Rows="4" SelectionMode="Multiple" />
      	    <ul Id="Categories_Container"></ul>
            <Validate Target="Categories" CssClass="validate-error validate-error-addon" Type="Required" Text="*" Message="Category is required" />
        </div>
    </div>
            
    <div class="panel panel-warning">
        <div class="panel-heading">
        <h3 class="panel-title">Visibility Options |<span class="HeaderLabel"> Control what is publicly seen on this ad. (seller defaults selected)</span></h3>
        </div>
        <div class="panel-body">
            <ul class="Categories_Container">
                <li>
                    <CheckBox Id="ShowAddress" DataField="ShowAddress" DataType="boolean" />
                <strong>Show Address</strong>
                </li>
                <li>
                    <CheckBox Id="ShowPhone" DataField="ShowPhone" DataType="boolean" />
                <strong>Show Phone</strong>
                </li>
                <li>
                    <CheckBox Id="ShowEmail" DataField="ShowEmail" DataType="boolean" />
                <strong>Show Email</strong>
                </li>
            </ul>
         </div>
    </div>
    

    <ValidationSummary CssClass="col-sm-offset-2 col-sm-10 alert alert-danger" Id="vsXMP_Classified_Ad" />

    <div class="form-group">
      <Label class="control-label">&nbsp;</Label>
      <AddButton CssClass="btn btn-primary" Text="Post Ad" />
      <CancelButton CssClass="btn btn-default" Text="Cancel" Redirect="/Dashboard" RedirectMethod="get" />
    </div>
  </div>


  <TextBox Id="SellerID" DataField="SellerID" DataType="int32" visible="false" />
  <TextBox Id="Seller_Level" DataField="Seller_Level" DataType="int32" visible="false" />
  <TextBox Id="Seller_Name" DataField="Seller_Name" DataType="String" visible="false" />
  <TextBox Id="ApprovalMessage" DataField="ApprovalMessage" DataType="String" Visible="False" /> 
  <TextBox Id="CreatedBy" DataField="CreatedBy" DataType="int32" visible="false" />
  <TextBox Id="Created_IP" Width="200" Nullable="True" MaxLength="50" DataField="Created_IP" DataType="string" visible="false" />

	<Email To="admin@hughesco.org" From="admin@acich.org" Format="text" Subject="New ad posted - Needs review!">
    [[Seller_Name]] posted a new ad that needs approval.
  </Email>  

  
  <script>
      $(document).ready(function () {
          let $select = $('#' + Ad.Categories).hide();
          let $container = $('#Categories_Container');
          let checkboxes = '';

          $select.children('option').each(function () {
              let $option, val, text, textTrim, checkbox, isParent;
              $option = $(this);
              val = $option.val();
              text = $option.text().trim();
              textTrim = (text.indexOf('-') !== 0) ? text : text.substring(1);
              isParent = (text.indexOf('-') !== 0) ? true : false;
              checkbox = '<li class="parent-' + isParent + '"><input type="checkbox" value="' + val + '"' + ($option.is(":selected") ? "checked" : "") + '> <span><strong>' + textTrim + '</strong></span></li>';
              checkboxes += checkbox;

          });

          $(checkboxes).appendTo($container);

          $container.children('.parent-false:not(.parent-false + .parent-false)').each(function () {
              $(this).nextUntil('.parent-true').andSelf().wrapAll('<li class="children"><ul>');
          });

          $container.find('li.parent-true input:checked').parent('li').next('li.children').addClass('show');

          //Capture clicks
          $container.find('input').click(function () {
              let $checkbox, val, checked;
              $checkbox = $(this);
              val = $checkbox.val();
              checked = $checkbox.is(':checked');

              // Sync with ListBox
              $select.find('option[value="' + val + '"]').prop('selected', checked);

              //Deal with the kids
              if ($checkbox.parent().hasClass('parent-true')) {
                  $checkbox.parent().next('li.children').toggleClass('show');
                  if (checked === false) {
                      $checkbox.parent().next('li.children').find('input').each(function () {
                          let $child, childVal;
                          $child = $(this);
                          childVal = $(this).val();
                          $child.prop('checked', false);
                          $select.find('option[value="' + childVal + '"]').prop('selected', false);
                      });
                  }
              }
          });
      });

  </script>

  <jQueryReady>
    tinymce.init({ 
      selector: '.tinymce',
      menubar: false,
      statusbar: false });
  </jQueryReady>
  
        </xmod:AddForm></AddItemTemplate>
    

    <AddSuccessTemplate><xmod:AddSuccess runat="server">
        
            <ItemTemplate>
                <xmod:ScriptBlock runat="server" ScriptId="SuccessCSS" BlockType="HeadScript" RegisterOnce="true">
                    <style type="text/css">
                        .success-message {
                            max-width: 800px;
                            margin: auto;
                            margin-top: 25px;
                            text-align: center;
                        }
                    </style>
                </xmod:ScriptBlock>

                <div class="alert alert-success success-message">
                    <h1>Success!</h1>
                    <p><%#Eval("Values")("ApprovalMessage")%></p>
                    <p>Your ad has been posted! What would you like to do next?</p>
                    <br />
                    <p>
                        <xmod:ContinueButton runat="server" CssClass="btn btn-default" Text="Post Another" />
                        <a class="btn btn-default" href="/Dashboard">Back to Dashboard</a>
                    </p>
                </div>

            </ItemTemplate>
        
    </xmod:AddSuccess></AddSuccessTemplate><EditItemTemplate><xmod:EditForm runat="server" ClientName="Ad">

  <ScriptBlock ScriptId="CustomCSS" BlockType="HeadScript" RegisterOnce="true">
    <style type="text/css">
        .validate-error {
            position: absolute;
            top: 0;
            left: 0;
            color: red;
        }

        .required-field {
            border-left: 1px solid red;
        }


        .validate-error-addon {
            left: -15px;
        }

        #Categories_Container {
            list-style-type: none;
            margin-left: 0px;
        }

            #Categories_Container ul {
                list-style-type: none;
                margin-left: 25px
            }


        li.children {
            display: none;
        }

            li.children.show {
                display: block;
            }

        .post-ad-form {
            margin-top: 40px;
        }

        .header-alt-text {
            font-size: 65%;
            font-style: italic;
        }

        .post-ad-form .checkbox {
            padding-left: 25px;
        }

        .post-ad-form .admin-functions, .post-ad-form .user-options {
            margin-top: 25px;
        }

            .post-ad-form .admin-functions h3, .post-ad-form .user-options h3, .post-ad-form .seller-name h3 {
                margin-top: 0px;
                padding-bottom: 10px;
            }

            .post-ad-form .admin-functions h3 {
                border-bottom: 1px solid wheat;
            }

            .post-ad-form .user-options h3 {
                border-bottom: 1px solid #e6e6e6;
            }

        .post-ad-form .seller-name h3 {
            border-bottom: 1px solid #e6e6e6;
        }
    </style>

	  <script src="/js/tinymce/tinymce.min.js"></script>
      
  </ScriptBlock>


  <SelectCommand CommandText="SELECT 
                              [AdID]
                              ,s.[Seller_Name]
                              ,s.[SellerID]
                              ,[LocationID]
                              ,[Ad_Title]
                              ,[Ad_Subtitle]
                              ,[Ad_Price]
                              ,[PrimaryImage]
                              ,[Ad_Summary]
                              ,[Ad_Description]
                              ,[Approved]
                              ,[Active]
                              ,[ShowAddress]
                              ,[ShowPhone]
                              ,[ShowEmail]
                              ,@UserID AS UpdatedBy
                              ,@UserIP AS Updated_IP
                              ,dbo.udf_XMP_GenerateDelimitedString (@AdID, 'cat', '|') AS Categories
                              ,dbo.udf_XMP_GenerateDelimitedString (@AdID, 'img', '|') AS AdditionalImages

                              FROM XMP_Classified_Ad AS ca LEFT JOIN
                              XMP_Classified_Seller AS s ON ca.SellerID = s.SellerID
                              WHERE ca.AdID=@AdID">

    <Parameter Name="UserID" Value='<%#UserData("ID")%>' DataType="int32" />
    <Parameter Name=UserIP Value='<%#RequestData("HostAddress")%>' DataType="string" />
  </SelectCommand>

  <SubmitCommand CommandText="XMP_Classified_Admin_UpdateAd" CommandType="StoredProcedure">
    <Parameter Name="AdID" />
    <Parameter Name="LocationID" />
    <Parameter Name="Ad_Title" />
    <Parameter Name="Ad_Subtitle" />
    <Parameter Name="Ad_Price" />
    <Parameter Name="PrimaryImage" />
    <Parameter Name="AdditionalImages" />
    <Parameter Name="Categories" />
    <Parameter Name="Ad_Summary" />
    <Parameter Name="Ad_Description" />
    <Parameter Name="UpdatedBy" />
    <Parameter Name="Updated_IP" />
    <Parameter Name="Approved" />
    <Parameter Name="ShowAddress" />
    <Parameter Name="ShowPhone" />
    <Parameter Name="ShowEmail" />
  </SubmitCommand>



  <ControlDataSource Id="cds_Locations" CommandText="SELECT [LocationID], [City] + ', ' + [State] AS CityState FROM [XMP_Classified_Location] ORDER BY [City] ASC"
                     />

  <ControlDataSource Id="cds_Categories" CommandText="
                                                      SELECT *
                                                      FROM (
                                                      SELECT CategoryID
                                                      ,Category_Name
                                                      ,ParentID
                                                      ,Date_Created
                                                      ,Date_Updated
                                                      ,Sort_Order
                                                      ,Sort_Order AS First_Level
                                                      ,NULL AS Second_Level
                                                      ,Active
                                                      FROM XMP_Classified_Category
                                                      WHERE ParentID IS NULL

                                                      UNION ALL

                                                      SELECT c.CategoryID
                                                      ,' - ' + c.Category_Name AS Category_Name
                                                      ,c.ParentID
                                                      ,c.Date_Created
                                                      ,c.Date_Updated
                                                      ,c.Sort_Order
                                                      ,d.Sort_Order AS First_Level
                                                      ,c.Sort_Order AS Second_Level
                                                      ,c.Active
                                                      FROM XMP_Classified_Category c
                                                      INNER JOIN XMP_Classified_Category d ON c.ParentID = d.CategoryID
                                                      WHERE c.ParentID IS NOT NULL
                                                      ) AS Categories
                                                      ORDER BY Categories.First_Level,Categories.Second_Level" />
  
  <div class="form-horizontal post-ad-form">
		<div class="seller-name">
      <h3>Impersonating <%#SelectData("Seller_Name")%> (<%#SelectData("SellerID")%>)</h3>
      <hr />
    </div>  
    
    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="LocationID">
        Location
      </Label>
      <div class="col-sm-10">
        <DropDownList Id="LocationID" CssClass="form-control required-field" Nullable="true" DataField="LocationID" DataSourceId="cds_Locations"
                      DataTextField="CityState" DataValueField="LocationID" AppendDataBoundItems="true" DataType="int32">
          <ListItem Value="">
            - Select Location -
          </ListItem>
        </DropDownList>
        <Validate Target="LocationID" CssClass="validate-error" Type="required" Text="*" Message="Location is required." />
      </div>
    </div>

    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Ad_Title">
        Ad Title
      </Label>
      <div class="col-sm-10">
        <TextBox Id="Ad_Title" HtmlEncode="True" CssClass="form-control required-field" Nullable="true" MaxLength="150" DataField="Ad_Title" DataType="string"
                 />
        <Validate Target="Ad_Title" CssClass="validate-error" Type="required" Text="*" Message="Ad Title is required." />
      </div>

    </div>
    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Ad_Subtitle">
        Ad Subtitle
      </Label>
      <div class="col-sm-10">
        <TextBox Id="Ad_Subtitle" HtmlEncode="True" CssClass="form-control" Width="200" Nullable="true" MaxLength="150" DataField="Ad_Subtitle" DataType="string"
                 />
      </div>
    </div>

    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Ad_Price">Ad Price</Label>
      <div class="col-sm-10">
        <div class="input-group">
          <div class="input-group-addon">$</div>
          <TextBox Id="Ad_Price" CssClass="form-control" Nullable="True" DataField="Ad_Price" DataType="decimal" />
          <Validate Target="Ad_Price" CssClass="validate-error validate-error-addon" Type="regex" Message="Please enter price only (1234.00)" Text="*" ValidationExpression="^\d{0,10}(\.\d{1,2})?$" />
        </div>
      </div>
    </div>0

    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="PrimaryImage">
        Primary Image
      </Label>
      <div class="col-sm-10">
        <rmg:Xile runat="server" Id="PrimaryImage" Nullable="True" DataField="PrimaryImage" Dropzone="False" AcceptFileTypes="jpg,jpeg,png" MaxNumberOfFiles="1"
                  MaxFileSize="2097152" AutoUpload="True" AutoCreateFolder="True" FileUploadPath='<%#Join("~/Portals/{0}/Classifieds/Ads/{1}/", PortalData("ID"), SelectData("SellerID"))%>'
                  ResizeVersions="width=800;height=600;mode=max, md_:width=400;height=400; sm_:width=200;height=200;mode=max;mode=max, thm_:width=80;height=80;mode=max"
                  UniqueFileName="True" UploadMode="Single" AddFilesButtonText="Add Image" WrapperClass="rmg-singleupload"
                  ShowTopCancelButton="False" ShowTopCheckBox="False" ShowTopProgressBar="False" ShowTopDeleteButton="False">
        </rmg:Xile>
      </div>
    </div>

    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="AdditionalImages">
        Additional Images
      </Label>
      <div class="col-sm-10">
        <rmg:Xile runat="server" Id="AdditionalImages" Nullable="True" DataField="AdditionalImages" Dropzone="True" AcceptFileTypes="jpg,jpeg,png"
                  MaxNumberOfFiles="20" AutoUpload="True" AutoCreateFolder="True" ResizeVersions="width=800;height=600;mode=max, md_:width=400;height=400; sm_:width=200;height=200;mode=max;mode=max, thm_:width=80;height=80;mode=max"
                  FileUploadPath='<%#Join("~/Portals/{0}/Classifieds/Ads/{1}/", PortalData("ID"), SelectData("SellerID"))%>' UniqueFileName="True"
                  UploadMode="Multiple" AddFilesButtonText="Add Files...">
        </rmg:Xile>
      </div>
    </div>

    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Ad_summary">Ad Summary</Label>
      <div class="col-sm-10">
        <TextArea Id="Ad_summary" HtmlEncode="True" MaxLength="250" CharacterCount="CountDown" CharacterCountLabel="remaining" CssClass="form-control" Nullable="true" DataField="Ad_Summary" DataType="string" />
      </div>
    </div>

    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Ad_Description">
        Ad Description
      </Label>
      <div class="col-sm-10">
        <TextArea Id="Ad_Description" CssClass="form-control tinymce" Height="200" Nullable="true" DataField="Ad_Description" DataType="string"
                  />
      </div>
    </div>

	<div class="well well-small col-sm-offset-2 col-sm-10 user-options">
    <h3>Categories <span class="header-alt-text">Select at least one category.</span></h3>
    <div class="checkbox">
        <ListBox Id="Categories" CssClass="form-control" Nullable="true" DataField="Categories" DataType="String" DataSourceId="cds_Categories"
                 DataTextField="Category_Name" DataValueField="CategoryID" AppendDataBoundItems="true" Rows="4" SelectionMode="Multiple"
                 />
      	<ul Id="Categories_Container"></ul>
        <Validate Target="Categories" CssClass="validate-error validate-error-addon" Type="Required" Text="*" Message="Category is required" />
    </div>
  </div>

	<div class="well well-small col-sm-offset-2 col-sm-10 user-options">
    <h3>Visibility Options <span class="header-alt-text">Control what is publicly seen on this Ad.</span></h3>

    <div class="checkbox">
        <CheckBox Id="ShowAddress" DataField="ShowAddress" DataType="boolean" />
        <strong>Show Address</strong>
    </div>

    <div class="checkbox">
        <CheckBox Id="ShowPhone" DataField="ShowPhone" DataType="boolean" />
        <strong>Show Phone</strong>
    </div>

    <div class="checkbox">
        <CheckBox Id="ShowEmail" DataField="ShowEmail" DataType="boolean" />
        <strong>Show Email</strong>
    </div>
		
  </div>
    
  <div class="alert alert-warning col-sm-offset-2 col-sm-10 admin-functions">
    <h3>Adminstrative</h3>

    <div class="checkbox">
        <CheckBox Id="Approved" DataField="Approved" DataType="boolean" />
        <strong>Approved</strong>
    </div>

    <div class="checkbox">
        <CheckBox Id="Active" DataField="Active" DataType="boolean" />
        <strong>Active</strong>
    </div>

  </div>

    <ValidationSummary CssClass="col-sm-offset-2 col-sm-10 alert alert-danger" Id="vsXMP_Classified_Ad" />

    <div class="form-group">
      <Label class="col-sm-2 control-label">
        &nbsp;
      </Label>
      <div class="col-sm-10">
        <UpdateButton CssClass="btn btn-primary" Text="Save Changes"  Redirect="/Classifieds-Admin/Ads" RedirectMethod="get" />
        <CancelButton CssClass="btn btn-default" Text="Cancel"  Redirect="/Classifieds-Admin/Ads" RedirectMethod="get" />
      </div>

    </div>
  </div>


  <TextBox Id="SellerID" DataField="SellerID" DataType="int32" visible="False" />
  <TextBox Id="UpdatedBy" DataField="UpdatedBy" DataType="int32" visible="False" />
  <TextBox Id="Updated_IP" Width="200" Nullable="True" MaxLength="50" DataField="Updated_IP" DataType="string" visible="False" />

  <TextBox Visible="False" Id="AdID" DataField="AdID" />

  <script>
      $(document).ready(function () {
          let $select = $('#' + Ad.Categories).hide();
          let $container = $('#Categories_Container');
          let checkboxes = '';

          $select.children('option').each(function () {
              let $option, val, text, textTrim, checkbox, isParent;
              $option = $(this);
              val = $option.val();
              text = $option.text().trim();
              textTrim = (text.indexOf('-') !== 0) ? text : text.substring(1);
              isParent = (text.indexOf('-') !== 0) ? true : false;
              checkbox = '<li class="parent-' + isParent + '"><input type="checkbox" value="' + val + '"' + ($option.is(":selected") ? "checked" : "") + '> <span><strong>' + textTrim + '</strong></span></li>';
              checkboxes += checkbox;

          }
          );

          $(checkboxes).appendTo($container);

          $container.children('.parent-false:not(.parent-false + .parent-false)').each(function () {
              $(this).nextUntil('.parent-true').andSelf().wrapAll('<li class="children"><ul>');
          }
          );

          $container.find('li.parent-true input:checked').parent('li').next('li.children').addClass('show');

          //Capture clicks
          $container.find('input').click(function () {
              let $checkbox, val, checked;
              $checkbox = $(this);
              val = $checkbox.val();
              checked = $checkbox.is(':checked');

              // Sync with ListBox
              $select.find('option[value="' + val + '"]').prop('selected', checked);

              //Deal with the kids
              if ($checkbox.parent().hasClass('parent-true')) {
                  $checkbox.parent().next('li.children').toggleClass('show');
                  if (checked === false) {
                      $checkbox.parent().next('li.children').find('input').each(function () {
                          let $child, childVal;
                          $child = $(this);
                          childVal = $(this).val();
                          $child.prop('checked', false);
                          $select.find('option[value="' + childVal + '"]').prop('selected', false);
                      }
                      );
                  }
              }
          }
          );
      }
      );


  </script>

  <jQueryReady>
    tinymce.init({ 
      selector: '.tinymce',
      menubar: false,
      statusbar: false });
  </jQueryReady>

        </xmod:EditForm></EditItemTemplate></xmod:FormView>
