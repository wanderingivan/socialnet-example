<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page trimDirectiveWhitespaces="true" %>
  <s:url action="loadImage" namespace="/util" var="loadUserProfileImage">
     <s:param name="path" value="user.profilePic"/>
  </s:url>
  <s:url action="loadImage" namespace="/util" var="loadUserCoverImage">
     <s:param name="path" value="user.coverImage"/>
  </s:url>
  <s:url action="show" namespace="/user" var="showUser">
  	<s:param name="username" value="%{user.username}"/>
  </s:url>
 <div class="cover" style="background-image:url('<s:property value="#loadUserCoverImage"/>')"></div>
 <div class="container">

  <div class="row">
    <div class="col-md-12 col-sm-12 hidden-xs" style="top:-215px;">
      <h2 id="userTitle" class="profile-username">${user.username}</h2>
    </div>
  </div> 
  <div class="row"> 
    <div class="col-md-12 col-sm-12 col-xs-12">
      <div class="profile">
        <div class="col-md-3 col-sm-3 col-xs-4">
          <s:a href="%{showUser}" title="%{user.username}"><img class="profile-image" src="<s:property value='#loadUserProfileImage'/>" alt="<s:property value='user.username'/>'s profile picture"/></s:a> 
        </div>

        <div class="col-md-offset-5 col-md-3 col-sm-offset-4 col-sm-5 col-xs-8">
      	    <sec:authorize access="isAuthenticated() and (authentication.name!='${user.username}')">
            <s:set var="auth" value="%{#session.SPRING_SECURITY_CONTEXT.authentication.principal.username}"/>
              <s:if test="user.isFriends(#auth)">
                 <s:url action="removeFriend" namespace="/user" var="removeFriend">
                   <s:param name="receiver" value="user.username"/>
                 </s:url>
                 <sj:a  id="removeFriendshipButton"
                        targets="t"
                 		href="%{removeFriend}" 
                 		cssClass="btn btn-nav" 
                		onSuccessTopics="relationSuccess"
                 		style="padding-left:6px;margin-top:7px;"><i class="fa fa-minus-circle"></i>&nbsp;<s:property value="getText('global.remove_friend')"/></sj:a>
              </s:if>
              <s:else>
                <s:url action="friendRequest" namespace="/user" var="friendRequest">
                 <s:param name="receiver" value="user.username"/>
                </s:url>
                <sj:a 	id="friendRequestButton"	
                		targets="t"
                		href="%{friendRequest}" 
                		cssClass="btn btn-nav" 
                		onSuccessTopics="relationSuccess"
                		style="padding-left:6px;margin-top:7px;"
                		>
                		<i class="fa fa-plus-circle"></i>&nbsp;<s:text name="global.send_friend_request"/>
                </sj:a>
              </s:else>
              <!-- Modal -->
              <div class="modal fade" id="relationModal" role="dialog">
                <div class="modal-dialog modal-sm">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h4 class="modal-title"><s:text name="global.success"/></h4>
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-deny" data-dismiss="modal"><s:text name="global.close"/></button>
                    </div>
                  </div>
                </div>
              </div>
            </sec:authorize>
        </div>
        <div class="col-md-offset-6 col-md-2 col-sm-offset-5 col-sm-4 col-xs-8">
      	    <sec:authorize access="isAuthenticated() and hasRole('ROLE_ADMIN')">
      	      <s:url action="editPage" namespace="/user" var="editProfile">
      	      	<s:param name="username" value="%{user.username}"/>
      	      </s:url> 
      	      <s:url action="delete" namespace="/user" var="deleteProfile">
      	      	<s:param name="username" value="%{user.username}"/>
      	      </s:url> 
      	      <ul class="list-group list-unstyled">
                <li><s:a href="%{#editProfile}" class="btn btn-nav-alt"><s:property value="getText('global.edit_profile')"/></s:a></li>     
                <li><s:a href="%{#deleteProfile}" class="btn btn-nav-alt"><s:property value="getText('global.delete')"/></s:a></li>     
              </ul>
            </sec:authorize>
        </div>
      </div>
    </div>
  </div>
 </div>