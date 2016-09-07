<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<s:iterator value="tasks">

<div style="border-bottom:1px solid :#000">
	<s:property value="name"/>
	<s:property value="description"/>
	<s:property value="assigner"/>
	<s:property value="assignee"/>
	<s:property value="created"/>
	<s:if test="complete">
		<s:property value="completed"/>
		<s:property value="comment"/>
	</s:if>
</div>
</s:iterator>