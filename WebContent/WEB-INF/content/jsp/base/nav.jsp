<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page trimDirectiveWhitespaces="true" %>

     <s:url id="localeEN" includeParams="get">
	   <s:param name="request_locale">en</s:param>
     </s:url>
     <s:url id="localeBG" includeParams="get">
	   <s:param name="request_locale">bg</s:param>
     </s:url>
     <nav class="navbar navbar-inverse"  style="margin-bottom:0px;" role="navigation">  
        <div class="container-fluid">
            <div class="navbar-header">
                <button  class="navbar-toggle collapsed btn-toggle" data-target="#mainNav" data-toggle="collapse" type="button" aria-expanded="false">
                  <span class="sr-only"><s:property value="getText('global.navigation')"/></span>
                  <span class="icon-bar"></span>
                  <span class="icon-bar"></span>
                  <span class="icon-bar"></span>
                </button>
                <s:a cssClass="navbar-brand" action="/index" >Social Net</s:a>
            </div>
            <div id="mainNav" class="collapse navbar-collapse" aria-expanded="false" class="btn btn-search">
              <ul class="nav navbar-nav navbar-left">
                <li>
                    <s:form action="search" class="form-inline" theme="simple" namespace="/user">
			          <div class="form-group">
                        <s:textfield placeholder="%{getText('global.user_search')}" class="form-control" name="username" value="" type="text" minLength="5" maxLength="25" required="true"/>
                        <button class="btn btn-search" type="submit" value=""><i class="fa fa-search"></i></button>
			       	    <s:hidden name="%{#attr._csrf.parameterName}" value="%{#attr._csrf.token}"/>
                      </div>   
                    </s:form>
                </li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
			    <li>
	              <s:a href="%{localeEN}" class="localle"><img  src="${pageContext.request.contextPath}/images/uk-flag-icon.png" title="English"/></s:a>
			    </li>
			    <li>
	              <s:a href="%{localeBG}" class="localle"><img  src="${pageContext.request.contextPath}/images/bg-flag-icon.png" title="Български"/></s:a>
			    </li>
              </ul>
            </div>
        </div>
      </nav>
	  <script type="text/javascript" src="${pageContext.request.contextPath}/js/nav.js"></script>
	  <script type="text/javascript" src="https://cdn.rawgit.com/nnattawat/flip/v1.0.19/dist/jquery.flip.min.js"></script>
  	  <script type="text/javascript" src="${pageContext.request.contextPath}/js/logincard.js"></script>