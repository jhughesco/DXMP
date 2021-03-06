<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.FormBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls.Form" TagPrefix="xmod" %>
<xmod:FormView runat="server"><AddItemTemplate><xmod:AddForm runat="server">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <ScriptBlock ScriptId="CustomCSS" BlockType="HeadScript" RegisterOnce="true">
    <style type="text/css">
      .validate-error {
        position: absolute;
        top: 0;
        left: 0;
        color: red;
      }
      .validate-error-compare {
        top: 30px;
      }
      .required-field {
        border-left: 1px solid red;
      }
    </style>
  </ScriptBlock>

  <SelectCommand CommandText="SELECT 1 AS Active, 0 AS Sort_Order"></SelectCommand>
  
  <SubmitCommand CommandText="INSERT INTO [XMP_Classified_Category] ([Category_Name], [ParentID], [Sort_Order], [Active]) VALUES(@Category_Name, @ParentID, @Sort_Order, @Active) " />

  <ControlDataSource Id="cds_ParentCategories" CommandText="SELECT [CategoryID], [Category_Name] FROM [XMP_Classified_Category] WHERE ParentID IS NULL ORDER BY [Category_Name] ASC" />

  <div class="form-horizontal">
    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Category_Name">
        Category Name
      </Label>
      <div class="col-sm-10">
        <TextBox Id="Category_Name" CssClass="form-control required-field" Width="300" MaxLength="50" DataField="Category_Name" DataType="string" />
        <Validate Target="Category_Name" CssClass="validate-error validate-error-compare" Type="required" Message="Please enter a Category Name" />
      </div>
    </div>

    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="ParentID">
        Parent Category
      </Label>
      <div class="col-sm-10">
        <DropDownList Id="ParentID" CssClass="form-control" Width="300" Nullable="true" DataField="ParentID" DataSourceId="cds_ParentCategories" DataTextField="Category_Name" DataValueField="CategoryID" AppendDataBoundItems="true" DataType="int32">
          <ListItem Value="">
            -Select Parent-
          </ListItem>
        </DropDownList>
      </div>
    </div>

    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Sort_Order">
        Sort Order
      </Label>
      <div class="col-sm-10">
        <TextBox Id="Sort_Order" CssClass="form-control required-field" Width="60" DataField="Sort_Order" DataType="int32" />
        <Validate Target="Sort_Order" CssClass="validate-error validate-error-compare" Type="required" Message="Sort Order is Required." />
        <Validate Type="compare" Target="Sort_Order" CssClass="validate-error" Text="*" Message="Sort Order must be an Integer" DataType="integer" Operator="DataTypeCheck" />
      </div>
    </div>

    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Active">&nbsp;</Label>
      <div class="col-sm-10">
				<CheckBox Id="Active" DataField="Active" DataType="boolean" /> Active
      </div>
    </div>

    <ValidationSummary CssClass="col-sm-offset-2 col-sm-10 alert alert-info" Id="vsXMP_Classified_Category" />

    <div class="form-group">
      <div class="col-sm-offset-2 col-sm-10">
        <AddButton type="submit" CssClass="btn btn-primary" Text="Add Category" />
        <CancelButton Text="Cancel" CssClass="btn btn-default" style="margin-left: 12px;" Visible="true" />
      </div>
    </div>
    
  </div>
</xmod:AddForm></AddItemTemplate>

<EditItemTemplate><xmod:EditForm runat="server">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <ScriptBlock ScriptId="CustomCSS" BlockType="HeadScript" RegisterOnce="true">
    <style type="text/css">
      .validate-error {
        position: absolute;
        top: 0;
        left: 0;
        color: red;
      }
      .validate-error-compare {
        top: 30px;
      }
      .required-field {
        border-left: 1px solid red;
      }
    </style>
  </ScriptBlock>


  <SelectCommand CommandText="SELECT [Category_Name], [ParentID], [Sort_Order], [Active], [CategoryID] FROM XMP_Classified_Category WHERE [CategoryID]=@CategoryID" />

  <SubmitCommand CommandText="UPDATE [XMP_Classified_Category] SET [Category_Name]=@Category_Name, [ParentID]=@ParentID, [Sort_Order]=@Sort_Order, [Active]=@Active, [Date_Updated]=getdate() WHERE [CategoryID]=@CategoryID" />

  <ControlDataSource Id="cds_ParentCategories" CommandText="SELECT [CategoryID], [Category_Name] FROM [XMP_Classified_Category] WHERE ParentID IS NULL ORDER BY [Category_Name] ASC" />

  <div class="form-horizontal">
    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Category_Name">
        Category Name
      </Label>
      <div class="col-sm-10">
        <TextBox Id="Category_Name" CssClass="form-control required-field" Width="300" MaxLength="50" DataField="Category_Name" DataType="string" />
        <Validate Target="Category_Name" CssClass="validate-error validate-error-compare" Type="required" Message="Please enter a Category Name" />
      </div>
    </div>

    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="ParentID">
        Parent Category
      </Label>
      <div class="col-sm-10">
        <DropDownList Id="ParentID" CssClass="form-control" Width="300" Nullable="true" DataField="ParentID" DataSourceId="cds_ParentCategories" DataTextField="Category_Name" DataValueField="CategoryID" AppendDataBoundItems="true" DataType="int32">
          <ListItem Value="">
            -Select Parent-
          </ListItem>
        </DropDownList>
      </div>
    </div>

    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Sort_Order">
        Sort Order
      </Label>
      <div class="col-sm-10">
        <TextBox Id="Sort_Order" CssClass="form-control required-field" Width="60" DataField="Sort_Order" DataType="int32" />
        <Validate Target="Sort_Order" CssClass="validate-error validate-error-compare" Type="required" Message="Sort Order is Required." />
        <Validate Type="compare" Target="Sort_Order" CssClass="validate-error" Text="*" Message="Sort Order must be an Integer" DataType="integer" Operator="DataTypeCheck" />
      </div>
    </div>

    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Active">
        &nbsp;
      </Label>
      <div class="col-sm-10">
        <CheckBox Id="Active" DataField="Active" DataType="boolean" />
        Active
      </div>
    </div>

    <ValidationSummary CssClass="col-sm-offset-2 col-sm-10 alert alert-info" Id="vsXMP_Classified_Category" />

    <div class="form-group">
      <div class="col-sm-offset-2 col-sm-10">
        <UpdateButton type="submit" CssClass="btn btn-primary" Text="Save Changes" />
        <CancelButton Text="Cancel" CssClass="btn btn-default" style="margin-left: 12px;" Visible="true" />
      </div>
    </div>

  </div>
  <TextBox Visible="False" Id="CategoryID" DataField="CategoryID" />
</xmod:EditForm></EditItemTemplate>

</xmod:FormView>
