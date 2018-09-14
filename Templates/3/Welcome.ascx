<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.TemplateBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls" TagPrefix="xmod" %>
<xmod:masterview runat="server">
<xmod:ScriptBlock runat="server" ScriptId="AboutCustomCSS" BlockType="HeadScript" RegisterOnce="True">
  <style type="text/css">

    .services-wrapper {
      max-width: 80%;
      display: block;
      margin-right: auto;
      margin-left: auto;
    }

    .services-wrapper .title-wrapper {
    }

    .services-wrapper .title-wrapper h1 {
      margin: 10px;
      color: #333;
    }

    .services-wrapper .title-wrapper p.bullet{
      color: #363636;
      font-size: 110%;
    }    
    
    .services-wrapper .about-wrapper {
    }

    .services-wrapper .about-wrapper h4 {
      margin-top: 20px;
      color: #333;
    }

    .services-wrapper .about-wrapper .about{
     	max-width: 95%;
      color: #363636;
      margin-bottom: 50px;
      display: block;
      margin-right: auto;
      margin-left: auto;
      font-style: italic;
    }

    
    .services-wrapper .image-wrapper {
      text-align: center;
      margin-top: 20px;
    }
    
    .services-wrapper .image-wrapper img {
      max-width: 100%;
    }

  </style>
</xmod:ScriptBlock>

<div class="services-wrapper">
  <div class="text-center title-wrapper">

    <h1>
      Jeff Hughes
    </h1>
    <p class="bullet">
      Customized DotNetNuke Web Development&nbsp;&nbsp;&#9679;&nbsp;&nbsp;System, Application, and SQL Administration&nbsp;&nbsp;&#9679;&nbsp;&nbsp;Project Management
    </p>

  </div>

  <div class="image-wrapper">
    <img class="img-responsive center-block" src="/portals/hughesco/Images/Logo_768x448_72dpi.png" title="HughesCo Consulting" alt="HughesCo Consulting" />
  </div>

  <div class="about-wrapper">
    <h4 class="text-center">
      Specializing in Information System Analysis and Support
    </h4>
    <div class="about">
      <p>
        I’m an independent Information Systems consultant located in beautiful Central Oregon. I help small companies and non-profits build focused, specialized IT solutions. Previously a Critical Care Registered Nurse in Northern California, I now partner with organizations to bring the same level of concern and care for their technology needs. Check out services below to see how I can best serve you.
      </p>
    </div>

  </div>

</div></xmod:masterview>