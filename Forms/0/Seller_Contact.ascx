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
  
  <SelectCommand CommandText="SELECT Seller_Email FROM XMP_Classified_Seller WHERE SellerID = @SellerID">
    <Parameter Name="SellerID" Value='<%#UrlData("SellerID")%>' DataType="Int32" />
  </SelectCommand>
  
  <div class="form">
    <h3>
      About You
    </h3>
      
    <div class="form-group">
      <TextBox Id="Name" Value='<%#UserData("DisplayName")%>' MaxLength="128" DataField="Name" CssClass="form-control" autocomplete="off" Placeholder="Your Name" DataType="String" />
      <Validate Type="required" CssClass="validate-error" Target="Name" Text="Required" Message="Name is required." />
    </div>
      
    <div class="form-group">
      <TextBox Id="Email" Value='<%#UserData("Email")%>' MaxLength="256" DataField="Email" CssClass="form-control" Placeholder="Enter your email address" autocomplete="off" DataType="String" />
      <Validate Type="required" CssClass="validate-error"  Target="Email" Text="Required" Message="Email address is required." />
      <Validate Type="email" CssClass="validate-error"  Target="Email" Text="Invalid" Message="Check your email address format." />
    </div>
      
    <h3>
      Your Message
    </h3>      
          
    <div class="form-group">
      <TextArea Id="Message" MaxLength="500" DataField="Message" CssClass="form-control" Rows="5" autocomplete="off" DataType="String" />
      <Validate Type="required" CssClass="validate-error" Target="Message" Text="Required" Message="Enter a message please." />          
    </div>
      
    <AddButton class="btn btn-lg btn-primary btn-block" Text="Send Message" />
    
  </div>
  
  <Email To="[[Seller_Email]]" From="[[Email]]" ReplyTo="[[Email]]" Format="text" Subject="[[Name]] has sent you a message.">
    You received a message from [[Name]] directly from your seller's profile page.

    Name: [[Name]]
    Email: [[Email]]
    Message: 
    
    [[Message]]

    Thank you!
  </Email>
  
  <TextBox Id="Seller_Email" DataField="Seller_Email" DataType="String" Visible="False" />
  
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
</xmod:AddSuccess></AddSuccessTemplate>


<EditItemTemplate><xmod:EditForm runat="server">
  <SelectCommand CommandText="" />
  <Submitcommand CommandText="" />

  <Label For="txtFieldOne" Text="Field One:" /> 
  <TextBox Id="txtFieldOne" DataField="FieldOne" DataType="string" /> <br />

  <UpdateButton Text="Update" /> &nbsp;<CancelButton Text="Cancel"/>
  <Textbox Id="txtKey" DataField="KeyFieldName" DataType="int32" Visible="False" />
</xmod:EditForm></EditItemTemplate>

</xmod:FormView>
