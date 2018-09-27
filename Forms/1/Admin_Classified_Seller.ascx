<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.FormBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls.Form" TagPrefix="xmod" %>
<xmod:FormView runat="server"><AddItemTemplate><xmod:AddForm runat="server">
  
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

    </style>
  </ScriptBlock>


  <SubmitCommand CommandText="INSERT INTO [XMP_Classified_Seller] ([UserID], [UpdatedBy], [Seller_Name], [Seller_Address], [Seller_Location], [Seller_Phone], [Seller_Email], [Show_Address_By_Default], [Show_Phone_By_Default], [Seller_Image], [Seller_Level], [Agree], [Banned]) VALUES(@UserID, @UpdatedBy, @Seller_Name, @Seller_Address, @Seller_Location, @Seller_Phone, @Seller_Email, @Show_Address_By_Default, @Show_Phone_By_Default, @Seller_Image, @Seller_Level, @Agree, @Banned) " />
  <ControlDataSource Id="cds_Users" CommandText="SELECT [UserID], [Username] FROM [Users] ORDER BY [Username] ASC" />
  <ControlDataSource Id="cds_Locations" CommandText="SELECT [LocationID], [City], [State] FROM [XMP_Classified_Location] ORDER BY [City] ASC" />
  <ControlDataSource Id="cds_Levels" CommandText="SELECT [LevelID], [Level_Name] FROM [XMP_Classified_Level] ORDER BY [LevelID] ASC" />
  
  <div class="form-horizontal">
    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="UserID">Select User</Label>
      <div class="col-sm-10">
        <DropDownList Id="UserID" CssClass="form-control required-field" DataField="UserID" DataSourceId="cds_Users" DataTextField="Username" DataValueField="UserID" AppendDataBoundItems="true" DataType="int32">
          <ListItem Value="">- Please Select -</ListItem>
        </DropDownList>
        <Validate Target="UserID" CssClass="validate-error" Type="required" Text="*" Message="User is required." />
      </div>
    </div>
    
    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="UpdatedBy">Updated By</Label>
      <div class="col-sm-10">
        <TextBox Id="UpdatedBy" CssClass="form-control" Nullable="True" DataField="UpdatedBy" DataType="int32" />
      </div>
    </div>
    
    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Seller_Name">Seller Name</Label>
      <div class="col-sm-10">
				<TextBox Id="Seller_Name" CssClass="form-control required-field" MaxLength="150" DataField="Seller_Name" DataType="string" />
      	<Validate Target="Seller_Name" CssClass="validate-error" Type="required" Text="*" Message="Name is required." />
      </div>
    </div>
    
    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Seller_Address">Seller Address</Label>
      <div class="col-sm-10">
        <TextBox Id="Seller_Address" CssClass="form-control required-field" MaxLength="150" DataField="Seller_Address" DataType="string" />
        <Validate Target="Seller_Address" CssClass="validate-error" Type="required" Text="*" Message="Address is required." />
      </div>
    </div>
    
    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Seller_Location">Location</Label>
      <div class="col-sm-10">
				<DropDownList Id="Seller_Location" CssClass="form-control" Nullable="true" DataField="Seller_Location" DataSourceId="cds_Locations" DataTextField="City" DataValueField="LocationID" AppendDataBoundItems="true" DataType="int32">
          <ListItem Value="">- Please Select -</ListItem>
        </DropDownList>
      </div>
    </div>
    
    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Seller_Phone">Seller Phone</Label>
      <div class="col-sm-10">
        <TextBox Id="Seller_Phone" CssClass="form-control required-field" MaxLength="50" DataField="Seller_Phone" DataType="string" />
        <Validate Target="Seller_Phone" CssClass="validate-error" Type="required" Text="*" Message="Phone is required" />
      </div>
    </div>
    
    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Seller_Email">Seller Email</Label>
      <div class="col-sm-10">
				<TextBox Id="Seller_Email" CssClass="form-control required-field" MaxLength="100" DataField="Seller_Email" DataType="string" />
        <Validate Target="Seller_Email" CssClass="validate-error" Type="required" Text="*" Message="Email is required." />
        <Validate Target="Seller_Email" CssClass="validate-error" Type="email" Text="*" Message="Email is invalid." />
      </div>
    </div>
    
    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Show_Address_By_Default">&nbsp;</Label>
      <div class="col-sm-10">
      	<CheckBox Id="Show_Address_By_Default" DataField="Show_Address_By_Default" DataType="boolean" /> Show Address by Default
			</div>
    </div>
    
    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Show_Phone_By_Default">&nbsp;</Label>
      <div class="col-sm-10">
				<CheckBox Id="Show_Phone_By_Default" DataField="Show_Phone_By_Default" DataType="boolean" /> Show Phone by Default
      </div>
    </div>
    
    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Seller_Image">Seller Image</Label>
      <div class="col-sm-10">
				<TextBox Id="Seller_Image" CssClass="col-sm-2 control-label" Nullable="True" MaxLength="150" DataField="Seller_Image" DataType="string" />
      </div>
    </div>
    
    <div class="form-group">
      <Label For="Seller_Level" CssClass="col-sm-2 control-label">Level</Label>
      <div class="col-sm-10">
        <DropDownList Id="Seller_Level" CssClass="form-control required-field" DataField="Seller_Level" DataSourceId="cds_Levels" DataTextField="Level_Name" DataValueField="LevelID" AppendDataBoundItems="true" Rows="4" SelectionMode="Single" DataType="int32">
          <ListItem Value="">- Please Select -</ListItem>
        </DropDownList>
        <Validate Target="Seller_Level" CssClass="validate-error" Type="required" Text="*" Message="Level is required." />
      </div>
    </div>
    
    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Agree">&nbsp;</Label>
      <div class="col-sm-10">
			  <CheckBox Id="Agree" DataField="Agree" DataType="boolean" /> I Agree to the Terms and Conditions
      </div>
    </div>
    
    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Banned">&nbsp;</Label>
      <div class="col-sm-10">
				<CheckBox Id="Banned" DataField="Banned" DataType="boolean" /> Banned
      </div>
    </div>
    
    <ValidationSummary CssClass="col-sm-offset-2 col-sm-10 alert alert-info" Id="vsXMP_Classified_Seller" />
    
    <div class="form-group">
      <div class="col-sm-offset-2 col-sm-10">
				<AddButton CssClass="btn btn-primary" Text="Create Seller" />
      	<CancelButton Text="Cancel"CssClass="btn btn-default" Visible="true" />
      </div>
    </div>
    
  </div>
</xmod:AddForm></AddItemTemplate><EditItemTemplate><xmod:EditForm runat="server">
  <ScriptBlock BlockType="HeadScript" RegisterOnce="True" ScriptId="KBXM_Theme_none_Admin_Classified_Seller">
    <link rel="stylesheet" type="text/css" href="/DesktopModules/XModPro/styles/none" />
  </ScriptBlock>

  <ScriptBlock BlockType="HeadScript" RegisterOnce="True" ScriptId="KBXM_Style_Admin_Classified_Seller">
    <style type="text/css">
      .xmp-Admin_Classified_Seller { padding: 10px 5px 5px 5px; }
      .xmp-Admin_Classified_Seller .xmp-form-row { margin: 3px; padding: 3px; clear:left;}
      .xmp-Admin_Classified_Seller label.xmp-form-label, .xmp-Admin_Classified_Seller span.xmp-form-label{ display:block; float:left; width: 120px;text-align: left; margin-right: 5px; }
      .xmp-Admin_Classified_Seller .xmp-button { margin-right: 5px; }
    </style>
  </ScriptBlock>


  <SelectCommand CommandText="SELECT [UserID], [UpdatedBy], [Seller_Name], [Seller_Address], [Seller_Location], [Seller_Phone], [Seller_Email], [Show_Address_By_Default], [Show_Phone_By_Default], [Seller_Image], [Seller_Level], [Agree], [Banned], [SellerID] FROM XMP_Classified_Seller WHERE [SellerID]=@SellerID" />  <SubmitCommand CommandText="UPDATE [XMP_Classified_Seller] SET [UserID]=@UserID, [UpdatedBy]=@UpdatedBy, [Seller_Name]=@Seller_Name, [Seller_Address]=@Seller_Address, [Seller_Location]=@Seller_Location, [Seller_Phone]=@Seller_Phone, [Seller_Email]=@Seller_Email, [Show_Address_By_Default]=@Show_Address_By_Default, [Show_Phone_By_Default]=@Show_Phone_By_Default, [Seller_Image]=@Seller_Image, [Seller_Level]=@Seller_Level, [Agree]=@Agree, [Banned]=@Banned WHERE [SellerID]=@SellerID" /><ControlDataSource Id="cds_users" CommandText="SELECT [UserID], [Username] FROM [Users] ORDER BY [Username] ASC"></ControlDataSource><ControlDataSource Id="cds_Locations" CommandText="SELECT [LocationID], [City], [State] FROM [XMP_Classified_Location] ORDER BY [City] ASC"></ControlDataSource><ControlDataSource Id="cds_Levels" CommandText="SELECT [LevelID], [Level_Name] FROM [XMP_Classified_Level] ORDER BY [LevelID] ASC"></ControlDataSource><div class="xmp-form xmp-Admin_Classified_Seller">
    <div class="xmp-form-row"><Label CssClass="xmp-form-label" For="UserID">Select User</Label><DropDownList Id="UserID" DataField="UserID" DataSourceId="cds_users" DataTextField="Username" DataValueField="UserID" AppendDataBoundItems="true" DataType="int32"><ListItem Value="">- Please Select -</ListItem></DropDownList><Validate Target="UserID" CssClass="xmp-validation" Type="required" Text="*" Message="User is required."></Validate></div>
    <div class="xmp-form-row"><Label CssClass="xmp-form-label" For="UpdatedBy">Updated By</Label><TextBox Id="UpdatedBy" Nullable="True" DataField="UpdatedBy" DataType="int32"></TextBox></div>
    <div class="xmp-form-row"><Label CssClass="xmp-form-label" For="Seller_Name">Seller Name</Label><TextBox Id="Seller_Name" Width="250" MaxLength="150" DataField="Seller_Name" DataType="string"></TextBox><Validate Target="Seller_Name" CssClass="xmp-validation" Type="required" Text="*" Message="Name is required."></Validate></div>
    <div class="xmp-form-row"><Label CssClass="xmp-form-label" For="Seller_Address">Seller Address</Label><TextBox Id="Seller_Address" MaxLength="150" DataField="Seller_Address" DataType="string"></TextBox><Validate Target="Seller_Address" CssClass="xmp-validation" Type="required" Text="*" Message="Address is required."></Validate></div>
    <div class="xmp-form-row"><Label CssClass="xmp-form-label" For="Seller_Location">Location</Label><DropDownList Id="Seller_Location" Nullable="true" DataField="Seller_Location" DataSourceId="cds_Locations" DataTextField="City" DataValueField="LocationID" AppendDataBoundItems="true" DataType="int32"><ListItem Value="">- Please Select -</ListItem></DropDownList></div>
    <div class="xmp-form-row"><Label CssClass="xmp-form-label" For="Seller_Phone">Seller Phone</Label><TextBox Id="Seller_Phone" MaxLength="50" DataField="Seller_Phone" DataType="string"></TextBox><Validate Target="Seller_Phone" CssClass="xmp-validation" Type="required" Text="*" Message="Phone is required"></Validate></div>
    <div class="xmp-form-row"><Label CssClass="xmp-form-label" For="Seller_Email">Seller Email</Label><TextBox Id="Seller_Email" MaxLength="100" DataField="Seller_Email" DataType="string"></TextBox><Validate Target="Seller_Email" CssClass="xmp-validation" Type="required" Text="*" Message="Email is required"></Validate><Validate Target="Seller_Email" CssClass="xmp-validation" Type="email" Text="*" Message="Email is invalid."></Validate></div>
    <div class="xmp-form-row"><Label CssClass="xmp-form-label" For="Show_Address_By_Default">Show Address By Default</Label><CheckBox Id="Show_Address_By_Default" DataField="Show_Address_By_Default" DataType="boolean"></CheckBox></div>
    <div class="xmp-form-row"><Label CssClass="xmp-form-label" For="Show_Phone_By_Default">Show Phone By Default</Label><CheckBox Id="Show_Phone_By_Default" DataField="Show_Phone_By_Default" DataType="boolean"></CheckBox></div>
    <div class="xmp-form-row"><Label CssClass="xmp-form-label" For="Seller_Image">Seller Image</Label><TextBox Id="Seller_Image" Width="250" Nullable="True" MaxLength="150" DataField="Seller_Image" DataType="string"></TextBox></div>
    <div class="xmp-form-row"><Label For="Seller_Level" CssClass="xmp-form-label">Level</Label><ListBox Id="Seller_Level" Width="140" DataField="Seller_Level" DataSourceId="cds_Levels" DataTextField="Level_Name" DataValueField="LevelID" AppendDataBoundItems="true" Rows="4" SelectionMode="Single" DataType="int32"><ListItem Value="">- Please Select -</ListItem></ListBox><Validate Target="Seller_Level" CssClass="xmp-validation" Type="required" Text="*" Message="Level is required"></Validate></div>
    <div class="xmp-form-row"><Label CssClass="xmp-form-label" For="Agree">Agree</Label><CheckBox Id="Agree" DataField="Agree" DataType="boolean"></CheckBox></div>
    <div class="xmp-form-row"><Label CssClass="xmp-form-label" For="Banned">Banned</Label><CheckBox Id="Banned" DataField="Banned" DataType="boolean"></CheckBox></div><ValidationSummary CssClass="xmp-validation" Id="vsXMP_Classified_Seller"></ValidationSummary><div class="xmp-form-row"><Label class="xmp-form-label">&nbsp;</Label><UpdateButton Text="Update"></UpdateButton><CancelButton Text="Cancel" style="margin-left: 12px;" Visible="true"></CancelButton></div>
  </div><TextBox Visible="False" Id="SellerID" DataField="SellerID"></TextBox></xmod:EditForm></EditItemTemplate>

</xmod:FormView>
