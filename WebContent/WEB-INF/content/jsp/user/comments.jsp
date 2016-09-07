<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>    

<s:iterator value="comments">
  <s:url action="show" namespace="user" var="showPoster">
    <s:param name="username" value="%{poster.username}"/>
  </s:url>
  <div class="media comments well well-sm">
    <div class="media-left">
      <s:a href="%{showPoster}"><img class="poster-image" src="<s:property value='#posterProfileImage'/>" title="${poster.username}" alt="Poster Image"/></s:a>
    </div>
    <div class="media-body">
      <p><s:property value="poster.username"/>&nbsp;<s:property value="getText('global.said')"/>:</p>
      <p><s:property value="message"/></p>
      <span><s:date name="sent" nice="true"/></span>
    </div>
  </div>
</s:iterator> 