<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
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

	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css"/>
	<sj:head loadFromGoogle="true" />
	
	<title><tiles:insertAttribute name="title"/></title>
  <script>

  </script>
  </head>

  <body>    
    <tiles:insertAttribute name="nav"/>
    <tiles:insertAttribute name="user-info"/>
    <div class="container-fluid">
      <div class="row">
        <div class=" col-md-push-2 col-md-9 col-sm-12 col-xs-12">
          <tiles:insertAttribute name="wall"/>
        </div>
        <div class="col-md-pull-9 col-md-2 col-sm-12 col-xs-12">
          <tiles:insertAttribute name="sidebar"/>
        </div>
      </div>
    </div>
    <tiles:insertAttribute name="footer"/>
    <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/prefilter.js"></script>
  </body>                                                                    
</html>
