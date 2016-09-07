<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

    <div class="container">
      <div class="row">
    	<div class="col-md-6 col-sm-3 hidden-xs"></div>
    	<div class="col-md-5 col-sm-8 col-xs-12">
    	  <div id="card" class="">
    	    <div class="front">
    	     <div class="panel panel-default">
    	      <div class="panel-heading title">
    	        <div class="row">
    	          <div class="col-md-7 col-sm-7 col-xs-8">
    	            <h4><s:property value="getText('global.log_in')"/>&nbsp;&nbsp;<i class="fa fa-sign-in"></i></h4>
    	          </div>
    	          <div class="col-md-offset-3 col-md-2 col-sm-offset-3 col-sm-2 col-xs-offset-1 col-xs-3">
    	            <button id="formToggleLogin" class="btn btn-toggle" title="<s:text name='global.create'/>"><i class="fa fa-user-plus"></i></button>
    	          </div>
    	        </div>
    	      </div>
    	      <div class="panel-body">
             <div class="row">
              <div class="col-md-offset-1 col-md-10 col-md-offset-1 col-sm-offset-1 col-sm-10 col-sm-offset-1 col-xs-offset-1 col-xs-10 col-xs-offset-1">
    	          <form class="form-horizontal" action="/SocialNet/login" method="post" name="login">
    	            <div class="form-group">
    			  	  <div class="icon"><i class="fa fa-user"></i></div><s:textfield name="username" class="form-control" value="" placeholder="%{getText('global.username')}" minLength="5" maxLength="25" required="true"/>
   			        </div>
   				    <div class="form-group">
    				  <div class="icon"><i class="fa fa-key"></i></div><s:password name="password" class="form-control" placeholder="%{getText('global.password')}" minLength="5" maxLength="25" required="true"/>
   				    </div>
                    <input type="hidden" name="${_csrf.parameterName}"   value="${_csrf.token}"/>
                    <div class="form-group">
	                  <button class="btn btn-primary" type="submit"><s:property value="getText('global.log_in')"/></button>
    	            </div>
    	          </form>
               </div>
              </div>
    	      </div>
    	     </div> 
    	    </div>
    	    <div class="back">
    	     <div class="panel panel-default">
    	      <div class="panel-heading title">
    	        <div class="row">
    	          <div class="col-md-7 col-sm-7 col-xs-8">
    	            <h4><s:property value="getText('global.create')"/>&nbsp;&nbsp;<i class="fa fa-user-plus"></i></h4>
    	          </div>
    	          <div class="col-md-offset-3 col-md-2 col-sm-offset-3 col-sm-2 col-xs-offset-1 col-xs-3">
    	            <button id="formToggleCreate" class="btn btn-toggle" title="<s:text name='global.log_in'/>"><i class="fa fa-sign-in"></i></button>
    	          </div>
    	        </div>
    	      </div>
    	      <div class="panel-body">
             <div class="row">
              <div class="col-md-offset-1 col-md-10 col-md-offset-1 col-sm-offset-1 col-sm-10 col-sm-offset-1 col-xs-offset-1 col-xs-10 col-xs-offset-1">
				<s:form action="create" namespace="/user" method="post" theme="simple" cssClass="form-horizonthal">
				  <div class="form-group">
		            <div class="icon"><i class="fa fa-user"></i></div><s:textfield placeholder="%{getText('global.username')}" name="user.username" minLength="5" maxLength="25" required="true"/>
				  </div>
				  <div class="form-group">
		            <div class="icon"><i class="fa fa-envelope"></i></div><s:textfield placeholder="%{getText('global.email')}" type="email" required="true" name="user.email"/>
				  </div>
				  <div class="form-group">
		            <div class="icon"><i class="fa fa-key"></i></div><s:password name="user.password" placeholder="******" minLength="5" maxLength="25" required="true"/>
				  </div>
				  <div class="form-group">
	                <button class="btn btn-primary" type="submit"><s:property value="getText('global.create')"/></button>
				  </div>
				  <input type="hidden" name="${_csrf.parameterName}"   value="${_csrf.token}"/>
				</s:form>
              </div>
             </div>
    	      </div>
    	     </div>
    	    </div>
           </div>
    	  </div>
		 </div>
    	</div>  
  
