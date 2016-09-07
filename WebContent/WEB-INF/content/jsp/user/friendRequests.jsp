<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags" %>
 
<s:iterator value="friendRequests" status="stat">
  <li>
    <s:url action="acceptFriendRequest" namespace="/user" var="addFriend">
      <s:param name="friendRequestId" value="%{id}"/>
    </s:url>
    <s:url action="denyFriendRequest" namespace="/user" var="denyFriend">
      <s:param name="friendRequestId" value="%{id}"/>
    </s:url>
    <s:url action="show" namespace="/user" var="showUser">
      <s:param name="username" value="sender.username"/>
    </s:url>
    <s:url action="loadImage" namespace="/util" var="loadImage">
    	<s:param name="path" value="sender.profilePic"/>
    </s:url>
    <div class="media">
      <div class="media-left">
        <s:a href="%{showUser}"><img src="<s:property value='#loadImage'/>" class="poster-image"/></s:a>                          
      </div>
      <div class="media-body">
        <h5 class="media-heading" style="color:#b3de1d;"><s:a href="%{showUser}" style="color:#b3de1d;"><s:property value="sender.username"/></s:a><br/><s:text name="global.sent_friend_request"/></h5>
        <s:div id="frButtons%{id}">
          <sj:a key="global.deny" 
                targets="t" 
                onSuccessTopics="clearButtons" 
                cssClass="btn btn-deny pull-right" 
                href="%{denyFriend}" 
                style="width:25%"
                >
                <s:text name="global.deny"/>
          </sj:a>
          <sj:a key="global.accept" 
                targets="t" 
                onSuccessTopics="clearButtons" 
                cssClass="btn btn-accept pull-right" 
                href="%{addFriend}" 
                style="width:25%"
                >
                <s:text name="global.accept"/>
          </sj:a>
        </s:div>
      </div>
    </div>
  </li>
  <li class="divider"/>
</s:iterator>  
<s:if test="friendRequests.size() == 0">
  <li><p class="empty"><s:text name="global.no_friend_requests"/></p></li>
  <li class="divider"/>
</s:if>