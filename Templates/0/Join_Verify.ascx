<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.TemplateBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls" TagPrefix="xmod" %>
<xmod:masterview runat="server">
<xmod:ScriptBlock runat="server" ScriptId="CustomCSS" BlockType="HeadScript" RegisterOnce="True">
	<style type="text/css">
    .dnnFormMessage.dnnFormWarning { display: none; }
    .alert.verification { margin-top: 20px }
    .seller_SignUp { color: #990000; font-size: 110%; }
    .SignUp { text-decoration: underline; }
  </style>
</xmod:ScriptBlock>

<div class="alert alert-info text-center verification">
  <h1>
    Welcome, <%#UserData("DisplayName")%>!
  </h1>
  <h2>
    Please verify your account by clicking the verification link we sent you by email.
  </h2>
  <h3>
    Be sure to check your junk mail folder if necessary. If you do not receive this email within 5 minutes, please <a href="/contact">contact us</a>.
  </h3>
  <p class="seller_SignUp">
    After verification you will be redirected to the <span class="SignUp">Seller Sign-Up</span> page.
  </p>
</div></xmod:masterview>