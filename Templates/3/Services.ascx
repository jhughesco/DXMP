<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.TemplateBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls" TagPrefix="xmod" %>
<xmod:masterview runat="server">
<xmod:ScriptBlock runat="server" ScriptId="ServiceCustomCSS" BlockType="HeadScript" RegisterOnce="True">
  <style type="text/css">

    .servicelist-wrapper {
      display: block;
      margin-right: auto;
      margin-left: auto;
    }

    .servicelist-wrapper h3 {
      margin-top: 0px;
    }

    ul.a {
      list-style-type: square;
    }
    ul.b {
      list-style-type: circle;
    }


  </style>
</xmod:ScriptBlock>


<div class="servicelist-wrapper">
  <h3 class="text-center">
    Services
  </h3>

  <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
    <div class="panel panel-default">
      <div class="panel-heading" role="tab" id="headingOne">
        <h4 class="panel-title">
          <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
            Customized DotNetNuke(DNN) Web Solutions
          </a>
        </h4>
      </div>
      <div id="collapseOne" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
        <div class="panel-body">
          <p>
            <a href="http://www.blueboltsolutions.com/what-is-dotnetnuke-dnn" target="_blank">
              DotNetNuke (DNN),
            </a>
             an advanced Content Management System (CMS), can be customized to your specific needs. After launch, a Content Management Systems allow the website owner to update most text and images without assistance from me, the designer. This can lead to lower day-to-day cost while keeping your website content fresh and engaging.
          </p>
          <p>
            If a more advanced solution is needed, I am be available to provide the services you require.In addition to the excellent modules included in DNN, I utilize 
            <a href="https://www.dnndev.com/" target="_blank">
              XMod Pro
            </a>
            to develop custom solutions that will impress and satisfy your special needs. Whether it’s a customized scheduling solution, event engagement, or special membership handling, I can deliver a solution for you.
          </p>

        </div>
      </div>
    </div>
    <div class="panel panel-default">
      <div class="panel-heading" role="tab" id="headingTwo">
        <h4 class="panel-title">
          <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
            System, Application, and SQL Administration
          </a>
        </h4>
      </div>
      <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
        <div class="panel-body">
          <p>
            Management of all aspects of the configuration and maintenance of computer systems:
          <ul class="a">
            <li>
              Provide technical support for both hardware and software issues users may encounter
            </li>
            <li>
              Manage the configuration and operation of client-based computer operating systems
            </li>
            <li>
              Monitor the system daily and respond immediately to security or usability concerns
            </li>
            <li>
              Create and verify backups of data
            </li>
            <li>
              Respond to and resolve help desk requests, provide general support to users
            </li>
            <li>
              Upgrade systems and processes as required for enhanced functionality and security issue resolution
            </li>
            <li>
              Administrate infrastructure, including firewalls, databases, malware protection software and other processes
            </li>
            <li>
              Review application logs
            </li>
            <li>
              Install and test computer-related equipment
            </li>
          </ul>
          </p>
        <p>
          Management of MS SQL Server systems:
        <ul class="b">
          <li>
            Install server software
          </li>
          <li>
            Configure database servers
          </li>
          <li>
            Monitor and maintain system health and security
          </li>
          <li>
            Design backup processes for server and associated data
          </li>
          <li>
            Create accounts for all users and assign security levels
          </li>
          <li>
            Establish a disaster recovery protocol
          </li>
          <li>
            Provide end-to-end technical support and problem resolution
          </li>
          <li>
            Schedule and perform regular server maintenance
          </li>
          <li>
            Create database management procedures
          </li>
          <li>
            Evaluate data analysis models and procedures
          </li>
          <li>
            Participate in company’s cross-training program
          </li>
        </ul>
        </p>

    </div>
  </div>
</div>
<div class="panel panel-default">
  <div class="panel-heading" role="tab" id="headingThree">
    <h4 class="panel-title">
      <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
        Project Management
      </a>
    </h4>
  </div>
  <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
    <div class="panel-body">
      Work directly with you and your stakeholders to establish scope, requirements, deliverables, and budget as needed to successfully deliver the services offered above.
    </div>
  </div>
</div>
</div>
</div></xmod:masterview>