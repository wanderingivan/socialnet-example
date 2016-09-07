<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

	<div class="container">
	  <div class="col-md-offset-2 col-md-8 col-xs-12">
	   <div class="user-list">
	    <h3><i><s:property value="searchMessage"/></i></h3>
	    <s:iterator value="users">
	      <s:url action="show" namespace="/user" var="show">
	        <s:param name="username">
	          <s:property value="username"/>
	        </s:param>
	      </s:url>
	      <s:url action="loadImage" namespace="/util" var="image">
	        <s:param name="path">
	          <s:property value="profilePic"/>
	        </s:param>
	      </s:url>
	      <div class="media">
	        <div class="media-left">
	          <s:a href="%{show}"><img class="media-object" src="<s:property value='#image'/>"/></s:a>
	        </div>
	        <div class="media-body">
	          <s:a href="%{show}"><h4 class="media-heading"><s:property value="username"/></h4></s:a>
	          <p><s:property value="details.description"/></p>
	        </div>
	      </div>
	    </s:iterator>
	   </div>
	  </div>
	  <div class="col-md-offset-1 col-md-1 hidden-xs"></div>
	</div>