<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.FormBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls.Form" TagPrefix="xmod" %>
<xmod:FormView runat="server"><AddItemTemplate><xmod:AddForm runat="server">
  
  <ScriptBlock ScriptId="SellerContact" BlockType="HeadScript" RegisterOnce="True">
    <style type="text/css">
      .validate-error {
        color: red;
        display: block;
      }
    </style>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css?cdv=23" media="all" type="text/css" rel="stylesheet"/>
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css?cdv=23" media="all" type="text/css" rel="stylesheet"/>
  </ScriptBlock>
  
  <SelectCommand CommandText="SELECT
                              	 a.[AdID]
                              	,a.[Ad_Title]
                              	,s.[UserID] AS SellerUserID
                              	,s.[Seller_Email] AS [To]
                              	,@UserID AS [Author]
                              	,@UserIP AS [AuthorIP]
                              	,@Username AS [From]
                              
                              FROM [XMP_Classified_Ad] a
                              INNER JOIN [XMP_Classified_Seller] s ON a.[SellerID] = s.[SellerID]
                              WHERE a.[AdID] = @AdID">
    
    <Parameter Name="UserID" Value='<%#UserData("ID")%>' DataType="Int32" />
    <Parameter Name="UserIP" Value='<%#RequestData("HostAddress")%>' DataType="String" />
    <Parameter Name="Username" Value='<%#UserData("Username")%>' DataType="String" />
    <Parameter Name="AdID" Value='<%#UrlData("AdID")%>' DataType="Int32" />  	
  </SelectCommand>
  
  <SubmitCommand CommandText="XMP_Classified_Reply" CommandType="StoredProcedure">
    <Parameter Name="Author" />
    <Parameter Name="AuthorIP" />
    <Parameter Name="AdID" />
    <Parameter Name="Message" />
    <Parameter Name="SellerUserID" />
  </SubmitCommand>
  
  <div class="form">
    <div class="form-group">
      <TextArea Id="Message" MaxLength="500" DataField="Message" CssClass="form-control" Placeholder="Type your reply here..." Rows="7" autocomplete="off" DataType="String" />
      <Validate Type="required" CssClass="validate-error" Target="Message" Text="Required" Message="Enter a message please." />          
    </div>      
    <AddButton class="btn btn-lg btn-primary btn-block" Text="Send Message" />    
  </div>
  
  <Email To="[[To]]" From="noreply@aza-z.com" Format="text" Subject="Re: [[Ad_Title]]">
    You've received a response regarding: [[Ad_Title]]

    From: [[From]]
    
    Message: 
    
    [[Message]]

    ----------------------------
    Unless the inquirer has provided their email address or other contact information within this message, 
    you can reply directly from your seller's dashboard: http://aza-z.com/Dashboard
    
    Messages within your dashboard will automatically be removed after the associated ad is deleted.
  </Email>
  
  <TextBox Id="AdID" MaxLength="200" DataField="AdID" DataType="Int32" Visible="False" />
  <TextBox Id="Ad_Title" MaxLength="200" DataField="Ad_Title" DataType="String" Visible="False" />
  <TextBox Id="To" DataField="To" DataType="String" Visible="False" />
  <TextBox Id="From" DataField="From" DataType="String" Visible="False" />
  <TextBox Id="Author" DataField="Author" DataType="Int32" Visible="False" />
  <TextBox Id="AuthorIP" DataField="AuthorIP" DataType="String" Visible="False" Nullable="True" />
  <TextBox Id="SellerUserID" DataField="SellerUserID" DataType="Int32" Visible="False" />
  
  
</xmod:AddForm></AddItemTemplate>

<AddSuccessTemplate><xmod:AddSuccess runat="server">
  <ItemTemplate>
    <xmod:ScriptBlock runat="server" ScriptId="ContactSuccess" BlockType="HeadScript" RegisterOnce="True">
      <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css?cdv=23" media="all" type="text/css" rel="stylesheet"/>
    </xmod:ScriptBlock>
    
    <div class="alert alert-success success-message">
      Thank you <%#UserData("Username")%>! We've delivered your message to this seller.
    </div>
  </ItemTemplate>
</xmod:AddSuccess></AddSuccessTemplate><EditItemTemplate><xmod:EditForm runat="server">
  <SelectCommand CommandText="" />
  <Submitcommand CommandText="" />

  <Label For="txtFieldOne" Text="Field One:" /> 
  <TextBox Id="txtFieldOne" DataField="FieldOne" DataType="string" /> <br />

  <UpdateButton Text="Update" /> &nbsp;<CancelButton Text="Cancel"/>
  <Textbox Id="txtKey" DataField="KeyFieldName" DataType="int32" Visible="False" />
</xmod:EditForm></EditItemTemplate>

</xmod:FormView>
