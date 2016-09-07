<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sj" uri="/struts-jquery-tags" %>
<%@ page trimDirectiveWhitespaces="true" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <meta name="_csrf" content="${_csrf.token}" />
    <!-- default header name is X-CSRF-TOKEN -->
    <meta name="_csrf_header" content="${_csrf.headerName}" />
    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css"/>
	<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin.css"/>
	<sj:head loadFromGoogle="true"/>	
	<title>Prototype Admin Page</title>
  <style>img { width : 55px;height:55px}</style>
  </head>
  <body>
  <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/socialnet.js"></script>
  <script>
  $.ajaxPrefilter(function(options, originalOptions, jqXHR) {
		var token;
		if (!options.crossDomain) {
			token = $('meta[name="_csrf"]').attr('content');
			if (token) {
				return jqXHR.setRequestHeader('X-CSRF-Token', token);
			}
		}
    });
  </script>
  <nav class="navbar navbar-default">
  	<div class="container-fluid">
      <div class="navbar-header">
      	<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#subnav" aria-expanded="false">
          <span class="sr-only">toggle navigation</span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="#">SocialNet</a>
      </div>
      <div id ="subnav" class="collapse navbar-collapse">
        <ul id="left" class="nav navbar-nav pull-right">
          <li></li>
		  <li>
      		<s:form id="nav-form" class="navbar-form navbar-left" 
      		    	role="search" action="search" namespace="/" theme="simple">
        	  <div class="form-group">
                <s:radio name="type" list="#{'user': 'Users', 'articles': 'Articles'}" value="'articles'" />
          		<s:textfield name="query" type="text" class="form-control" placeholder="Search"/>
			    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        	  </div>
        	  <s:submit class="btn btn-subnav" value="Search"/>
      		</s:form>
		  </li>
		  <li class="dropdown">
			<a href="#" class="btn-cart dropdown-toggle" type="button" 
			   id="dropdownMenuMessages" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
 		      <s:url action="unread-count" namespace="/message" var="countUnread"/>
		      <sj:div id="unread" href="%{countUnread}" onSuccessTopics="addUnreadCount"/>  
			</a>
			<ul id="messagesDropdown" class="dropdown-menu" aria-labelledby="dropdownMenu1">
			  <img src="../images/indicator.gif"></img>
			</ul>
		  </li>
		  <li class="dropdown">
			<a href="#" class="btn-cart dropdown-toggle" type="button" 
			   id="dropdownMenuTasks" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
 		      <s:url action="countTasks" namespace="/admin" var="countTasks"/>
		      <sj:div id="tasks" href="%{countTasks}" onSuccessTopics="addTasksCount"/>  
			</a>
			<ul id="dropdownTasks" class="dropdown-menu" aria-labelledby="dropdownMenuTasks">
			  <img src="../images/indicator.gif"></img>
			</ul>
		  </li>		
		  <li class="dropdown">
			<a href="#" class="btn-cart dropdown-toggle" type="button" 
			   id="dropdownMenuTasks" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
 		      <s:url action="countTasks" namespace="/admin" var="countTasks"/>
		      <sj:div id="tasks" href="%{countTasks}" onSuccessTopics="addTasksCount"/>  
			</a>
			<ul id="dropdownTasks" class="dropdown-menu" aria-labelledby="dropdownMenuTasks">
			  <img src="../images/indicator.gif"></img>
			</ul>
		  </li>
		  <li>
		    <form action="/NewsSite/logout" class="navbar-form" method="POST">
  		      <input class="btn btn-subnav" type="submit" value="Log out" />
    	      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			</form>
	      </li>	
        </ul>
      </div>
    </div>
  </nav>
  <div class="wrapper">
    <div class="sidebar">
    	<div style="height:50px;"></div>
    	<div class="sidebar-block">
  		<ul class="nav nav-pills">
  			<li class="active"><a data-toggle="tab" href="#feed">Feed</a></li>
  			<li class=""><a data-toggle="tab" href="#sysinfo">Sysinfo</a></li>
  			<li class=""><a data-toggle="tab" href="#chat">Chats</a></li>
  			<li class=""><a data-toggle="tab" href="#tasksPane">Tasks</a></li>    
  		</ul>
  		</div>
    </div>
    <div class="main">
     <div class="container">
      <div class="tab-content">
      <div id="sysinfo" class="tab-pane fade" style="min-height:950px;">
        <div class="row">
   	      <div class="col-md-10 col-sm-9 col-xs-12">
 	        <s:form id="logForm" action="logAction" theme="simple" namespace="/admin">
 	          <s:hidden name="%{#attr._csrf.parameterName}" value="%{#attr._csrf.token}"/>
  		      <sj:submit id="logSubmit" onCompleteTopics="loadLog" targets="t" dataType="json" key="Load"/>
               <s:select name="logFile" list="#{'action':'action','error':'error','dao':'dao','security':'security'}"/> 
            </s:form>
   	        <div id="log" class="well well-lg" style="height:300px;overflow-y:scroll;"></div>
   	      </div>
   	      <div class="col-md-2 col-sm-3 col-xs-12">
 		    <s:url action="sysload" namespace="/admin" var="sysload"/>
 		    <s:url action="uptime" namespace="/admin" var="uptime"/>
            <sj:div href="sysload" updateFreq="20000"></sj:div>
            <sj:div href="uptime" updateFreq="60000"></sj:div>
   	      </div>
   	    </div>
  	  </div>
      <div id="chat" class="tab-pane fade" style="min-height:950px;">
    <div class="mainContent">
      <div class="row">
       <div class="col-md-4 col-sm-6 col-xs-12">
		<div class="user-messages">
		  <s:iterator value="userChats" status="stat">
            <s:url action="loadUser" namespace="/user" var="loadUser">
              <s:param name="username" value="getOther(username).getUsername()"/>
            </s:url>
            <s:url action="loadImage" namespace="/util" var="loadImage">
              <s:param name="path" value="getOther(username).getImagePath()"/>
			</s:url>
            <s:url action="loadChat" namespace="/message" var="loadChat">
              <s:param name="chatId" value="%{id}"/>
            </s:url>
            <div class="media">
              <div class="media-left">
 		  	    <sj:a id="chat%{id}" 
				  href="%{loadChat}" 
				  targets="results" 
				  indicator="indicator"  
			    >
		  	      <img class="img-responsive" style="width:100px;height:100px;border-radius:4px" src="<s:property value='#loadImage'/>" alt="User Profile Image"/>
			    </sj:a>
              </div>
              <div class="media-body">
		  	    <h4><s:text name="global.chat_with"/>&nbsp;<s:a href="%{loadUser}"><s:property value="getOther(username).getUsername()"/></s:a></h4>
                <p>${messages.first().getMessage()}</p>
                <p><s:date name="messages.first().getSent()" nice="true"/></p>
              </div>
            </div>
			<s:a href="%{loadChat}">Test it</s:a>
            <s:if test="#stat.isFirst()">
              <s:set var="first">
                 <s:param name="value">
                   <s:property />
                 </s:param>
              </s:set>
			</s:if>
	      </s:iterator>
		</div>
        </div>
        <div class="col-md-offset-1 col-md-6 col-sm-6 col-xs-12">

		  <div id="results">
		    <img id="indicator" class="img-responsive" style="display:none;width:100px;height:100px;border-radius:4px" src="${pageContext.request.contextPath}/images/indicator.gif" />
			<div class="chatList">
			  <s:form id="chat%{#first.id}addMessage" action="addMessage" namespace="/message" theme="simple" cssClass="form-inline">
                <div class="form-group" style="width:100%; margin-bottom:20px;">
                  <button type="submit" class="btn btn-primary">
                    <i class="fa fa-envelope"></i>
                    <s:property value="getText('global.send')"/>
                  </button>
                  <s:textarea class="form-control share-text" placeholder="%{getText('global.send_message')}" name="message" required="true" maxLength="180"/>
                </div>
			      <s:hidden name="chatId" value="%{#first.id}"/>
			      <s:hidden name="%{#attr._csrf.parameterName}" value="%{#attr._csrf.token}"/>
			  </s:form>
			  <s:iterator value="#first.messages">
			    <s:url action="loadUser" namespace="/user" var="loadUser">
			      <s:param name="username" value="%{poster.username}"/>
			    </s:url>
			    <s:url action="loadImage" namespace="/util" var="loadPic">
  					<s:param name="path" value="poster.imagePath"/>	      
			    </s:url>
			    <div class="media well well-sm">
			      <div class="media-left">
			        <img class="img-responsive" style="width:55px;height:55px;border-radius:4px" src="<s:property value='#loadPic'/>" alt="User Profile Image"/> 
			      </div>
			      <div class="media-body">
			        <h5 class="media-heading"><s:text name="global.sentBy"/>&nbsp;<s:a href="%{loadUser}">${poster.username}</s:a></h5>
			        <p><s:property value="message"/></p>
			        <p><s:date name="sent" nice="true"/></p>
			      </div>
			    </div>
			  </s:iterator>

			</div>	
		  </div>
        </div>
       </div>
      </div>	  
	  </div>
      <div id="tasksPane" class="tab-pane fade" style="min-height:950px;">
  	    <div class="row">
   	      <div class="col-md-6">
   	      	<s:url action="latestTasks" namespace="/admin" var="allTasks"/>
   	      	<s:url action="pendingTasks" namespace="/admin" var="userTasks"/>
   	      	<sj:a button="true" href="%{allTasks}" targets="taskList" cssClass="btn-alt">Load Latest Tasks</sj:a>
   	      	<sj:a button="true" href="%{userTasks}" targets="taskList" cssClass="btn-alt">Load Your Pending Tasks</sj:a>
   	      </div>
   	      <div class="col-md-6">
   	      	<div id="taskList"></div>
   	      </div>
   	    </div>		
	  </div>
  	  <div id="feed" class="tab-pane fade in active" style="min-height:950px;">
  	  <div class="row">
  	    <div class="col-md-6 col-sm-6 col-xs-12">
  	      <div class="col-md-12">
  		    <div class="panel panel-default users">
 		      <div class="panel-heading">Latest Users <i class="fa fa-minus-square pull-right"></i></div>
  		      <div class="panel-body">
  			  <s:iterator value="newestUsers">
  			    <s:url action="show" namespace="/user" var="loadUser">
  			   	  <s:param name="username" value="%{username}"/>
  			    </s:url>
  			    <s:url action="loadImage" namespace="/util" var="userImage">
  			   	  <s:param name="path" value="%{profilePic}"/>
  			    </s:url>
  			    <div class="media">
  				  <div class="media-body">
  				    <div class="media-left">
  				      <div class="image-container">
  				        <s:a href="%{loadUser}"><img src="<s:property value='#userImage'/>"/></s:a>
  				      </div>
  				    </div>
  				    <div class="media-right">
  				      <h4 class="media-heading"><s:a href="%{loadUser}"><s:property value="username"/></s:a></h4>
  				      <p class="text-muted">Joined:&nbsp;<s:date name="createdOn" format="dd/MM/yyyy"/></p>
  				    </div>
  				  </div>
  			    </div>
  			  </s:iterator>
  		      </div>
  		    </div>
  	      </div>
  	      <div class="col-md-12">

  	      </div>
  	    </div>
  	    <div class="col-md-6 col-sm-6 col-xs-12">
  	    </div>
      </div>
      </div>
     </div>
     </div>
   </div>
  </div>
  <script>$(document).ready(setUpDropdowns);</script>
  </body>
</html>