<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page trimDirectiveWhitespaces="true" %>

      <sec:authorize access="isAuthenticated() AND authentication.name != '${user.username}'">
       <div class="" >
        <div id="msgButton" class="btn btn-nav"><s:text name="global.send_message"/></div>
      	<s:form cssClass="form-horizonthal" theme="simple" action="send-message" namespace="/message" method="POST">
	        <s:hidden name="%{#attr._csrf.parameterName}" value="%{#attr._csrf.token}"/>
      	    <s:hidden name="receiver" value="%{user.username}"/>
      	    <div id="msgForm" class="form-group" style="display:none;">
      		  <s:textarea name="message" cssClass="form-control" placeholder="%{getText('global.post_message')}" style="background-color:#f1f1f1;"/>
      		  <s:submit key="global.send_message" cssClass="btn btn-nav-alt"/>
      		</div>
      	</s:form>
       </div>
      </sec:authorize>
      
	  <sec:authorize access="isAuthenticated() and (hasRole('ROLE_ADMIN') and authentication.name != '${username}')">
      <div class="">
      	<s:if test="user.isEnabled()">
      	  <s:url action="disableUser" namespace="/admin" var="lockUser">
      	  	<s:param name="username" value="%{user.username}"/>
      	  </s:url>
      	  <s:a href="%{lockUser}" cssClass="btn btn-nav-alt"><s:text name="global.lock_user"/></s:a>
      	</s:if>
      	<s:else>
      	  <s:url action="enableUser" namespace="/admin" var="unlockUser">
      	  	<s:param name="username" value="%{user.username}"/>
      	  </s:url>
      	  <s:a href="%{unlockUser}" cssClass="btn btn-nav-alt"><s:text name="global.unlock_user"/></s:a>
      	</s:else>
      </div>
      </sec:authorize>
      <div class="sidebar-block">
         <s:url namespace="/user" action="friends" var="friends">
           <s:param name="username" value="username"/>
         </s:url>
         <s:a href="%{friends}"><h3><s:text name="global.friends"/> <span></span></h3></s:a>
         <div class="row">
          <s:subset source="user.friends" count="6">
           <s:iterator status="stat">
             <s:url namespace="/user" action="show" var="showFriend">
               <s:param name="username" value="username"/>
             </s:url>
             <s:url namespace="/util" action="loadImage" var="#friendImage">
               <s:param name="path" value="profilePic"/>
             </s:url>
             <div class="col-xs-3 col-sm-1 col-md-4 sidebar-list-item">
               <s:a href="%{showFriend}"><img src="<s:property value='#friendImage'/>" alt="${username}'s profile picture" title="${username}"/></s:a>
             </div>
           </s:iterator>
          </s:subset>
         </div>
      </div>
      <div class="sidebar-block">
        <s:url namespace="/user" action="gallery" var="gallery">
          <s:param name="username" value="username"/>
        </s:url>
         <s:a href="%{gallery}"><h3><s:text name="global.gallery"/> <span></span></h3></s:a>
        <div class="row">
         <s:subset source="user.gallery" count="6">
          <s:iterator status="stat">
            <s:url namespace="/user" action="gallery" var="userGallery">
              <s:param name="username" value="user.username"/>
            </s:url>             
            <s:set var="altText">
              ${user.username}'s gallery picture
            </s:set>
            <s:url action="loadImage" namespace="/util" var="galleryImage">
              <s:param name="path" value="imagePath"/>
            </s:url>
            <div class="col-xs-3 col-sm-1 col-md-4 sidebar-list-item">
              <s:a href="%{userGallery}"><img  src="<s:property value='#galleryImage'/>" alt="<s:property value='#altText'/>" /></s:a>
            </div>
          </s:iterator>
         </s:subset>
        </div>
      </div>
      <div class="sidebar-block">
      	<s:url namespace="/user" action="details" var="details">
          <s:param name="username" value="username"/>
        </s:url>
        <s:a href="%{details}"><h3><s:text name="global.details"/> <span></span></h3></s:a>
        <ul class="list-unstyled">
        <li><h6><span style="color:#337ab7;"><s:text name="global.description"/></span><br/><s:property value="user.details.description"/></h6></li>
        <li><h6><span style="color:#337ab7;"><s:text name="global.occupation"/>:</span><br/><s:property value="user.details.occupation"/></h6></li>
        </ul>
      </div>
        <script>$(document).ready(function(){
        			$('#msgButton').click(function(){
        				$("#msgForm").toggle(750);
        			});
        		});
        </script>