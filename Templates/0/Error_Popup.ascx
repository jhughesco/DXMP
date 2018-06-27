<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.TemplateBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls" TagPrefix="xmod" %>
<xmod:masterview runat="server">
<xmod:ScriptBlock runat="server" ScriptId="CustomCSS" BlockType="HeadScript" RegisterOnce="True">
  <style type="text/css">
    
  </style>
 
  <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css?cdv=23" media="all" type="text/css" rel="stylesheet"/>
</xmod:ScriptBlock>

<xmod:Template runat="server">

  <ListDataSource CommandText="SELECT 1" />

  <ItemTemplate>
    
    <div class="form-group">
      <div id="join_message" class="alert alert-success text-center">
        <h2>There seems to be an account problem.</h2>
        <h3>Please <a href="/contact">Contact Us</a> to resolve this issue.</h3>
			</div>
    </div>
    
  </ItemTemplate>
  
</xmod:Template></xmod:masterview>