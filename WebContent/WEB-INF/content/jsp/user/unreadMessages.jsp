<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
  <s:iterator value="messages">
	<s:url action="loadUser" namespace="/user" var="loadUser">
	  <s:param name="username" value="%{sender.username}"/>
	</s:url>
	<s:url action="loadImage" namespace="/util" var="loadPic">
  	  <s:param name="path" value="sender.profilePic"/>	      
	</s:url>
	<li>
	  <div class="media">
		<div class="media-left">
		  <img class="" style="width:55px;height:55px;border-radius:4px" src="<s:property value='#loadPic'/>" alt="User Profile Image"/> 
	    </div>
	    <div class="media-body">
		  <h5 class="media-heading" style="color:#b3de1d;"><s:text name="global.sent_by"/>&nbsp;<s:a href="%{loadUser}" style="color:#b3de1d;">${sender.username}</s:a></h5>
		  <p style="color:#b3de1d;"><s:property value="message"/></p>
		  <p style="color:#b3de1d;"><s:date name="sent" nice="true"/></p>
		</div>
	  </div>
	</li>
    <li class="divider"/>
  </s:iterator>
  <s:if test="messages.size() == 0">
  <li><p class="empty"><s:text name="global.no_unread"/></p></li>
  <li class="divider"/>
  </s:if>
  <li><s:a action="user-messages" namespace="/user"><i class="fa fa-envelope">&nbsp;</i>&nbsp;<s:text name="global.messages"/></s:a></li>