<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page trimDirectiveWhitespaces="true" %>

     <s:url id="localeEN" includeParams="get">
	   <s:param name="request_locale">en</s:param>
     </s:url>
     <s:url id="localeBG" includeParams="get">
	   <s:param name="request_locale">bg</s:param>
     </s:url>
     <nav class="navbar navbar-inverse"  style="margin-bottom:0px;" role="navigation">  
        <div class="container-fluid">
            <div class="navbar-header">
                <button  class="navbar-toggle collapsed btn-toggle" data-target="#mainNav" data-toggle="collapse" type="button" aria-expanded="false">
                  <span class="sr-only"><s:property value="getText('global.navigation')"/></span>
                  <span class="icon-bar"></span>
                  <span class="icon-bar"></span>
                  <span class="icon-bar"></span>
                </button>
                <s:a cssClass="navbar-brand" action="index" namespace="/" >Social Net</s:a>
            </div>
            <div id="mainNav" class="collapse navbar-collapse" aria-expanded="false" class="btn btn-search">
              <ul class="nav navbar-nav navbar-left">
                <sec:authorize access="isAuthenticated()">
                 <li>
                   <div class="dropdown">
                     <button class="btn btn-nav dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                       <i class="fa fa-user">&nbsp;</i><s:text name="global.profile"/>
                     </button>
                     <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
                       <li><s:a action="show" namespace="/user"><i class="fa fa-home"></i>&nbsp;<s:text name="global.homepage"/></s:a></li>
                       <li><s:a action="user-messages" namespace="/user"><i class="fa fa-envelope">&nbsp;</i>&nbsp;<s:text name="global.messages"/></s:a></li>
                       <li><s:a action="gallery" namespace="/user"><i class="fa fa-picture-o">&nbsp;</i>&nbsp;<s:text name="global.gallery"/></s:a></li>
                       <li><s:a action="friends" namespace="/user"><i class="fa fa-users">&nbsp;</i>&nbsp;<s:text name="global.friends"/></s:a></li>
					   <li class="divider"/>
                       <li><s:a action="editPage" namespace="/user"><i class="fa fa-pencil-square-o">&nbsp;</i><s:property value="getText('global.editPage')"/></s:a></li>
                       <sec:authorize access="hasRole('ROLE_ADMIN')">
					     <li class="divider"/>
                         <li><s:a action="welcome" namespace="/admin"><i class="fa fa-wrench">&nbsp;</i>Admin Homepage</s:a></li>
                       </sec:authorize>
                     </ul>
                   </div>
                 </li>               
                 <li>
                 <div class="dropdown">
                     <button id="dropdownMenuFriendRequests" class="btn btn-nav dropdown-toggle" type="button"  data-toggle="dropdown" aria-haspopup="true" aria-expanded="true" style="margin-bottom:8px;">
                        <s:url action="friendrequest-count" namespace="/user" var="frCount"/>
						<sj:div id="friendRequests" href="%{frCount}" onSuccessTopics="addFriendRequestCount"></sj:div>
                     </button>
                     <ul id="friendRequestsDropdown" class="dropdown-menu" aria-labelledby="dropdownMenuFriendRequests">
                     
                     </ul>
                   </div>
                 </li>
                 <li>
                 <div class="dropdown">
                     <button id="dropdownMenuMessage" class="btn btn-nav dropdown-toggle" type="button"  data-toggle="dropdown" aria-haspopup="true" aria-expanded="true" style="margin-bottom:8px;">
                        <s:url action="unread-count" namespace="/message" var="unreadCount"/>
						<sj:div id="userMessages" href="%{unreadCount}" onSuccessTopics="addUnreadMessages"></sj:div>
                     </button>
                     <ul id="userMessagesDropdown" class="dropdown-menu" aria-labelledby="dropdownMenuMessage">
                     
                     </ul>
                   </div>
                 </li>
                </sec:authorize>
                <li>
                    <s:form action="search" class="form-inline" theme="simple" namespace="/user">
			          <div class="form-group">
                        <s:textfield placeholder="%{getText('global.user_search')}" class="form-control" name="username" value="" type="text" minLength="5" maxLength="25" required="true"/>
                        <button class="btn btn-search" type="submit" value=""><i class="fa fa-search"></i></button>
			       	    <s:hidden name="%{#attr._csrf.parameterName}" value="%{#attr._csrf.token}"/>
                      </div>   
                    </s:form>
                </li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                <sec:authorize access="isAnonymous()">
                <li>		    	
                  <form id="loginForm" action="/SocialNet/login" method="POST" class="form-inline" name="f">
			  	    <div class="form-group">

					  <s:textfield name="username" class="form-control" value="" placeholder="%{getText('global.username')}" minLength="5" maxLength="25" required="true"/>
					  <s:password name="password" class="form-control" placeholder="%{getText('global.password')}" minLength="5" maxLength="25" required="true"/>
	                  <s:hidden name="%{#attr._csrf.parameterName}" value="%{#attr._csrf.token}"/>
					  <button type="submit" class="btn btn-nav"><s:text name="global.log_in"/></button>
			  	    </div>							
		    	  </form>
		    	</li>
		    	<li>
			    	<s:a action="index" namespace="/" class="btn btn-nav-alt"><s:property value="getText('global.create')"/></s:a>
		    	</li>
                </sec:authorize>

                <sec:authorize access="isAuthenticated()">
			      <li>
		            <form action="/SocialNet/logout" method="POST">
  				      <input id="logoutSubmit" class="btn btn-nav-alt" type="submit" value="Logout"/>
    			      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			        </form>
			      </li>
                </sec:authorize>
			    <li>
	              <s:a href="%{localeEN}" class="localle"><img  src="../images/uk-flag-icon.png" title="English"/></s:a>
			    </li>
			    <li>
	              <s:a href="%{localeBG}" class="localle"><img  src="../images/bg-flag-icon.png" title="Български"/></s:a>
			    </li>
              </ul>
            </div>
        </div>
      </nav>
	  <script type="text/javascript" src="${pageContext.request.contextPath}/js/nav.js"></script>