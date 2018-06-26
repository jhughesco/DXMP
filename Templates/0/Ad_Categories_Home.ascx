<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.TemplateBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls" TagPrefix="xmod" %>
<xmod:masterview runat="server">
<xmod:ScriptBlock runat="server" ScriptId="CategoriesHome" BlockType="HeadScript" RegisterOnce="True">
  <style type="text/css">
    ul.ad-categories {
      overflow: auto;
      column-count: 3;
      column-gap: 10px;
      -moz-column-count: 3;
      -moz-column-gap: 10px;
      -webkit-column-count: 3;
      -webkit-column-gap : 10px;
    }
    ul.ad-categories li.parent {
      font-size: 16px;
      font-weight: bold;
    }
    ul.ad-categories li.child {
      font-size: 14px;
      margin-left: 10px;
      list-style: none;
    }
    
  </style>
</xmod:ScriptBlock>

<xmod:template runat="server" usepaging="False" ajax="True">

  <ListDataSource CommandText= "SELECT *
                                FROM (
                                SELECT p.CategoryID
                                ,p.Category_Name
                                ,p.Sort_Order + ' - ' + p.CategoryID AS First_Level
                                ,NULL AS Second_Level
                                ,p.Active
                                ,'parent' AS [Class]
                                ,@Location AS LocId
                                ,(
                                SELECT COUNT(*)
                                FROM XMP_Classified_Ad a
                                INNER JOIN XMP_Classified_AdCategory ac ON a.AdID = ac.AdID
                                INNER JOIN XMP_Classified_Seller s ON a.SellerID = s.SellerID
                                INNER JOIN Users u ON s.UserID = u.UserID
                                INNER JOIN UserPortals up ON s.UserID = up.UserID
                                WHERE a.Approved = 1
                                AND a.Active = 1
                                AND a.Ad_Expires > getdate()
                                AND s.Banned = 0
                                AND s.IsDeleted = 0
                                AND up.IsDeleted = 0
                                AND up.Authorised = 1
                                AND ac.CategoryID = p.CategoryID
                                AND a.LocationID = CASE 
                                WHEN (@Location = - 1)
                                THEN a.LocationID
                                ELSE @Location
                                END
                                ) AS AdCount
                                FROM XMP_Classified_Category p
                                WHERE p.ParentID IS NULL

                                UNION ALL

                                SELECT c.CategoryID
                                ,' - ' + c.Category_Name AS Category_Name
                                ,d.Sort_Order + ' - ' + d.CategoryID AS First_Level
                                ,c.Sort_Order AS Second_Level
                                ,c.Active
                                ,'child' AS [Class]
                                ,@Location AS LocId
                                ,(
                                SELECT COUNT(*)
                                FROM XMP_Classified_Ad a
                                INNER JOIN XMP_Classified_AdCategory ac ON a.AdID = ac.AdID
                                INNER JOIN XMP_Classified_Seller s ON a.SellerID = s.SellerID
                                INNER JOIN Users u ON s.UserID = u.UserID
                                INNER JOIN UserPortals up ON s.UserID = up.UserID
                                WHERE a.Approved = 1
                                AND a.Active = 1
                                AND a.Ad_Expires > getdate()
                                AND s.Banned = 0
                                AND s.IsDeleted = 0
                                AND up.IsDeleted = 0
                                AND up.Authorised = 1
                                AND ac.CategoryID = c.CategoryID
                                AND a.LocationID = CASE 
                                WHEN (@Location = - 1)
                                THEN a.LocationID
                                ELSE @Location
                                END
                                ) AS AdCount
                                FROM XMP_Classified_Category c
                                INNER JOIN XMP_Classified_Category d ON c.ParentID = d.CategoryID
                                WHERE c.ParentID IS NOT NULL
                                ) AS Categories
                                ORDER BY Categories.First_Level
                                ,Categories.Second_Level">

    <Parameter Name="Location" Value='<%#UrlData("LocId")%>' DefaultValue="-1" DataType="Int32" />

  </ListDataSource>

  <HeaderTemplate>

    <div class="category_content">
			<div class="row head" style="height: 56px;">
      	<div class="col-md">
          <select class="form-control" id="Ad_Locations"></select>
              <xmod:LoadFeed runat="server" FeedName="Ads_GetLocations" Target="#Ad_Locations" />
        </div>
      </div>
      
      <div class="row body">
      	<div class="col-md">
          <div class="text-center">
            <a style="color: white" id="view_all_ads" class="btn btn-warning" href="/Ads">View All Ads</a>
            <hr/>
          </div>
        </div>
          <ul class="ad-categories">
          
</HeaderTemplate>

  <ItemTemplate>
            <li id="cat-<%#Eval("Values")("CategoryID")%>" class="<%#Eval("Values")("Class")%>">
              <a href="/Ads?Id=<%#Eval("Values")("CategoryID")%>&LocId=<%#Eval("Values")("LocId")%>"><%#Eval("Values")("Category_Name")%>&nbsp;&nbsp;
                <span class="text text-muted">(</span><%#Eval("Values")("AdCount")%><span class="text text-muted">)</span>
              </a>
            </li>
  </ItemTemplate>

  <FooterTemplate>
            </ul>
      </div>
    
      <div class="row footer" style="height: 65px">
        <div class="col-md">
          <div class="text-center">
            <hr/>
          	<a href="/Contact" class="btn btn-default">Suggest a Category</a>        
          </div>
        </div>
      </div>          
    </div>
  </FooterTemplate>

</xmod:template>

<script>
	// I'm caching the <select id="Ad_Locations"> with a variable called $location_select.
  // I'm also caching the value from the URL query string parameter called LocId. If it doesn't exist, then loc_url equals nothing.
  // I'm also caching the "Vew All Ads" link
  var $location_select = $('#Ad_Locations'),
      loc_url = "<%#UrlData("LocId")%>",
      
      // I've added another variable called cat_url.
      // You'll see how we use this below to construct our breadcrumb and placeholder if it exists.
      cat_url = "<%#UrlData("Id")%>",
      $viewall = $('#view_all_ads');
    
  // This function is called when a user changes the location in the select list. You'll see where we listen for this change further down.
  // This is the ajax function that calls the feed "Ads_GetCounts" and replaces the existing <li> elements with the data returned.
  function reloadlinks() {
    $.ajax({
      // The url to the feed
      url: "/DesktopModules/XmodPro/Feed.aspx",
      
      // The data type that we're using
      dataType: "HTML",
      
      // Can be get or post, but we're posting data to the feed
      type: "POST",
      
      // This is the form data being passed to the feed
      data: {
        "xfd" : "Ads_GetCounts",
        "pid" : <%#PortalData("ID")%>,
        "loc" : parseInt($location_select.val())
      },
      success: function(data) {
        // Upon success, we replace the existing <li> elements for category links with the data from our feed's <ItemTemplate>
        $('ul.ad-categories').html(data);
        
        // Next, we call another function so change the "View All Ads" link to be more intuitive
        alterlinks();
      }          
    });
  }
  
  // This function is used to alter the "View All Ads" link
  function alterlinks() {
    
    // We've already cached the $('#Ad_Locations') with the variable called $location_select
    // Now we get it's value by using jQuery val() method
    var locId = $location_select.val(),
        
        // In the same way, we can get the text of the location
        locText = $('option:selected', $location_select).text(),
        
        // I'm creating another variable for the new link
        link;
      
    // All locations is equal to -1, so if locId is greater than -1, then we need to do a few extra things:
    if (locId > 0) {
      
      // First, we'll append the LocationID to the query string parameter
      link = "/Ads?LocId=" + locId;
      
      // Then, we replace the current link with our new link
      $viewall.attr("href", link);          
      
      // And, we'll replace the text to include the actual city and state
      $viewall.text("View all ads in " + locText);
    
    // If LocId is not greater than -1, then it's all locations
    } else {
      
      // We'll just reset the link, just like visiting the page for the first time
      link = "/Ads";
      
      // We'll also change the text
      $viewall.text("View All Ads");
    }      
  }
    
  // This function has to be manually called, which you can see it being called directly beneath it
  // Our location options are loaded via a feed, and this happens after the page loads
  // It happens really fast, but we still need to wait for it.
  // The reason for this function is to alter our View All Ads link and text depending on if a location is passed in the URL
  function checkfeed() {
    
    // First, we check if we have child options in our select list.
    // If we do not, it means our feed hasn't loaded yet.
    if (!$location_select.children('option').length) {
      
      // If our feed hasn't loaded yet, we'll give it 300 milliseconds and try again, and keep doing so until it's ready
      return setTimeout(checkfeed, 1000);
    }      
      
    // If the "return" isnt' called above, it falls into the function below
    // If loc_url is something, let's dynamically select the appropriate options in our select list
    if (loc_url) {
      $location_select.val(parseInt(loc_url));
      
      // We use jQuery to select the value on behalf of the user
      alterlinks();
    }
    
    // After our feed has loaded the locations into our select list,
    // We call our new breadcrumb() function.
    breadcrumb();
		  
  }
  

  
  // We only need this because we're using AJAX on our template.
  // We used this exact same technique on our seller's profile page.
  // When an ajax event completion has been detected, 
  // this function is triggered.
  function pageLoad(){
    
    // Because our template reloads content within it's update panel,
    // we need to run our breadcrumb() function again to reconstruct the 
    // breadcrumb and placeholder text.
    // If we do not, our breadcrumb will revert to its original state, which 
    // just had the <li>All Ads</li> within it.
    breadcrumb();
  }
  
  function breadcrumb() {
    
    // We start our crumb with the All Ads. 
    var crumb = '<li><a href="/Ads">All Ads</a></li>';
    
    // We start our placeholder with "Search "
    var placeholder = "Search ";

    // If we're passing a category in the URL, we construct the breadcrumb and placeholder accordingly.
    if (cat_url) {

      // This is why we added the unique ID to the <li> within our <ItemTemplate>.
      // We're basically finding the category in our list based on the ID passed in the URL.
      var catLink = $('#cat-' + cat_url),
          
          // In the event that this is a child category,
          // we reserve a variable to associate its parent to.
          parent,
          
          // Similar to a previous chapter on the category tree,
          // this is a ternary operator that determines if 
          // the element has the class of parent, and if it does, 
          // then isParent = true. If it does not, then isParent = false.
          isParent = catLink.hasClass('parent') ? true : false;

      // So, if this is a parent category that was passed in the URL
      if (isParent) {
    
        // We add to our existing crumb, based on the link and text. We're basically
        // duplicating what's in our current category link.
        crumb += '<li class="active"><a href="' + catLink.find("a").attr("href") + '">' + catLink.find("a").text() + '</a></li>';
      
        // We add to the placeholder as well...
        placeholder += catLink.find('a').text() + " in ";
      
      } else {
    
        // If it's not a parent, we need to find the parent.
        // We use prevAll with the :first condition to grab the closest sibling that is a parent.
        parent = catLink.prevAll('.parent:first');
      
        // We now add to the crumb based on that parent, and then the child.
        crumb += '<li><a href="' + parent.find("a").attr("href") + '">' + parent.find("a").text() + '</a></li>' +
                 '<li class="active"><a href="' + catLink.find("a").attr("href") + '">' + catLink.find("a").text() + '</a></li>';

        // Once again, we add to our placeholder, closely mirroring our breadcrumb.
        placeholder += parent.find('a').text() + " / " + catLink.find('a').text() + " in ";
      }
    
    } else {
      // If the above conditions fail, we're searching in all categories.
      placeholder += "all categories in ";      
    }
    
    // We now finalize our crumb.
    crumb += '<li class="pull-right">' + $('option:selected', $location_select).text() + '</li>';
	
    // We now finalize our placeholder text.
    placeholder += $('option:selected', $location_select).text(); 
  
    // Finally, we use jQuery's attr() to change the placeholder of the search.
    $('.ad-search').find('input[type="text"]').attr('placeholder', placeholder);
    
    // Now that our breadcrumb is constructed, we replace our temporary <li>All Ads</li> with the proper data.
    $('#Ads_Breadcrumb').html(crumb);

  }
  

  // As soon as the page is loaded
  $(document).ready(function() {
    
    // This is called almost immediately after the page is loaded.
    // checkfeed() is the functioned described above that's waiting on the locations to populate in our select list
    checkfeed();
    
    // This is our listener for the change event. When a user changes the location in the categories modal,
    // we call our reloadlinks() function.
    $location_select.change(function() {
      reloadlinks();      
    });
     
  });
</script></xmod:masterview>