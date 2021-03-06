<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.FormBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls.Form" TagPrefix="xmod" %>
<%@ Register tagprefix="rmg" namespace="reflect.xile" assembly="reflect.xile" %>
<xmod:FormView runat="server"><AddItemTemplate><xmod:AddForm runat="server" Clientname="Ad">

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


        li.children {
          display: none;
        }

        li.children.show {
          display: block;
        }
      
        .header-alt-text {
          font-size: 65%;
          font-style: italic;
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
        
        .post-ad-form .admin-functions h3, .post-ad-form .user-options h3, .post-ad-form .seller-name h3{
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

    <SelectCommand CommandText="SELECT SellerID
                                			,Seller_Name
                                      ,Seller_Location AS LocationID
                                      ,Show_Address_By_Default AS ShowAddress
                                      ,Show_Phone_By_Default AS ShowPhone
                                      ,0 AS ShowEmail
                                      ,0 AS Approved
                                      ,1 AS Active
                                      ,@UserID AS CreatedBy
                                      ,@UserIP AS Created_IP

                                  FROM XMP_Classified_Seller
                                  WHERE SellerID = @SellerID">
      
      	<Parameter Name="SellerID" Value='<%#FormData("SellerID")%>' DataType="int32" />
        <Parameter Name="UserID" Value='<%#UserData("ID")%>' DataType="int32" />
        <Parameter Name=UserIP Value='<%#RequestData("HostAddress")%>' DataType="string" />
    
  </SelectCommand>

    <SubmitCommand CommandText="XMP_Classified_Admin_PostAd" CommandType="StoredProcedure">
      <Parameter Name="SellerID" />
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
      <Label CssClass="col-sm-2 control-label" For="LocationID">Location</Label>
      <div class="col-sm-10">
        <DropDownList Id="LocationID" CssClass="form-control required-field" Nullable="true" DataField="LocationID" DataSourceId="cds_Locations"
                      DataTextField="CityState" DataValueField="LocationID" AppendDataBoundItems="true" DataType="int32">
          <ListItem Value="">- Select Location -</ListItem>
        </DropDownList>
        <Validate Target="LocationID" CssClass="validate-error" Type="required" Text="*" Message="Location is required." />
      </div>
    </div>

    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Ad_Title">Ad Title</Label>
      <div class="col-sm-10">
        <TextBox Id="Ad_Title" CssClass="form-control required-field" Nullable="true" MaxLength="150" DataField="Ad_Title" DataType="string"
                 />
        <Validate Target="Ad_Title" CssClass="validate-error" Type="required" Text="*" Message="Ad Title is required." />
      </div>

    </div>
    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Ad_Subtitle">Ad Subtitle</Label>
      <div class="col-sm-10">
        <TextBox Id="Ad_Subtitle" CssClass="form-control" Width="200" Nullable="true" MaxLength="150" DataField="Ad_Subtitle" DataType="string"
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
    </div>

    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="PrimaryImage">Primary Image</Label>
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
      <Label CssClass="col-sm-2 control-label" For="AdditionalImages">Additional Images</Label>
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
        <TextArea Id="Ad_summary" MaxLength="250" CharacterCount="CountDown" CharacterCountLabel="remaining" CssClass="form-control" Nullable="true" DataField="Ad_Summary" DataType="string" />
      </div>
    </div>

    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Ad_Description">Ad Description</Label>
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
      <Label class="col-sm-2 control-label">&nbsp;</Label>
      <div class="col-sm-10">
        <AddButton CssClass="btn btn-primary" Text="Post Ad" Redirect="/Classifieds-Admin/Sellers" RedirectMethod="get" />
        <CancelButton CssClass="btn btn-default" Text="Cancel" Redirect="/Classifieds-Admin/Sellers" RedirectMethod="get" />
      </div>

    </div>
  </div>


  <TextBox Id="SellerID" DataField="SellerID" DataType="int32" visible="false" />
  <TextBox Id="CreatedBy" DataField="CreatedBy" DataType="int32" visible="false" />
  <TextBox Id="Created_IP" Width="200" Nullable="True" MaxLength="50" DataField="Created_IP" DataType="string" visible="false" />

  
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
  
</xmod:AddForm></AddItemTemplate><EditItemTemplate><xmod:EditForm runat="server" Clientname="Ad">

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

      .post-ad-form .admin-functions h3, .post-ad-form .user-options h3, .post-ad-form .seller-name h3{
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
                              ,[Seller_Name]
                              ,[Seller_Email]
                              ,[SellerID]
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

                              FROM vw_XMP_Admin_Ad_Detail
                              WHERE AdID=@AdID">

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
        <TextBox Id="Ad_Title" CssClass="form-control required-field" Nullable="true" MaxLength="150" DataField="Ad_Title" DataType="string"
                 />
        <Validate Target="Ad_Title" CssClass="validate-error" Type="required" Text="*" Message="Ad Title is required." />
      </div>

    </div>
    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Ad_Subtitle">
        Ad Subtitle
      </Label>
      <div class="col-sm-10">
        <TextBox Id="Ad_Subtitle" CssClass="form-control" Width="200" Nullable="true" MaxLength="150" DataField="Ad_Subtitle" DataType="string"
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
        <TextArea Id="Ad_summary" MaxLength="250" CharacterCount="CountDown" CharacterCountLabel="remaining" CssClass="form-control" Nullable="true" DataField="Ad_Summary" DataType="string" />
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
        <CheckBox Id="SendApprovalEmail" DataField="SendApprovalEmail" DataType="boolean" />
        <strong>Send Approval Email</strong>
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
  <TextBox Id="Seller_Name" DataField="Seller_Name" DataType="String" visible="False" />
  <TextBox Id="Seller_Email" DataField="Seller_Email" DataType="String" visible="False" />
  <TextBox Id="UpdatedBy" DataField="UpdatedBy" DataType="int32" visible="False" />
  <TextBox Id="Updated_IP" Width="200" Nullable="True" MaxLength="50" DataField="Updated_IP" DataType="string" visible="False" />
	<TextBox Visible="False" Id="AdID" DataField="AdID" />
  
  <Email To='[[Seller_Email]]' SendIf='[[SendApprovalEmail]] = True' From="admin@acich.org" ReplyTo="admin@acich.org" Subject="Your ad has been approved." Format="HTML">
		<body style="margin:0; padding:0; background-color:#F2F2F2;">
      <center>
        <table width="640" cellpadding="0" cellspacing="0" border="0" class="wrapper" bgcolor="#FFFFFF">
          <tr>
            <td height="10" style="font-size:10px; line-height:10px;">&nbsp;</td>
          </tr>
          <tr>
            <td align="center" valign="top">

              <table width="600" cellpadding="0" cellspacing="0" border="0" class="container">
                <tr>
                  <td align="center" valign="top" style="font-family: Arial, sans-serif; font-size:14px; font-weight:bold;">
                    <p>Hello [[Seller_Name]]!</p>
                    <p>The following ad has been approved:</p>
                    <p>[[AdTitle]]</p>
                    <p>You can view your ad directly at the following link:</p>
                    <p>http://acich.org/Ads/Details/AdID/[[AdID]]</p>
                    <p>Thanks for your support!</p>
                    <p>~acich.org</p>

                  </td>
                </tr>
              </table>

            </td>
          </tr>
          <tr>
            <td height="10" style="font-size:10px; line-height:10px;">&nbsp;</td>
          </tr>
        </table>
      </center>
    </body>
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
