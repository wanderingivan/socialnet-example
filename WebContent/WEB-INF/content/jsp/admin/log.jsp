<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>


	<div style="background-color:#fff;">
	  <s:iterator value="logContents">
		<p><s:property /></p>
      </s:iterator>
	</div>
