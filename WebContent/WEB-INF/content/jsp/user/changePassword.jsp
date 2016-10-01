<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<div class="main_content">
 <div class="row">
   <div class="col-md-offset-1 col-md-11 col-sm-12 col-xs-12">
   <div id="card" class="col-md-offset-3 col-md-5 col-md-offset-3">
     <div class="panel panel-default">
       <div class="panel-heading title">
    	 <div class="row">
    	   <div class="col-md-5 col-sm-6 col-xs-8">
    	     <h4><i class="fa fa-user"></i>&nbsp;<s:text name="global.edit"/></h4>
    	   </div>
    	   <div class="col-md-offset-5 col-md-2 col-sm-offset-4 col-sm-2 col-xs-offset-1 col-xs-3">
    	   </div>
    	 </div>
       </div>
       <div class="panel-body">
         <div class="row">
           <div class="col-md-offset-1 col-md-10 col-md-offset-1 col-sm-offset-1 col-sm-10 col-sm-offset-1 col-xs-offset-1 col-xs-10 col-xs-offset-1">
             <s:form action="changePassword" namespace="/user" method="POST" cssClass="form-horizonthal" theme="simple">
	           <s:hidden name="%{#attr._csrf.parameterName}" value="%{#attr._csrf.token}"/>
               <div class="form-group">
                   <s:fielderror fieldName="oldPassword" cssClass="alert alert-danger"/>
                   <s:label for="oldPassword" key="global.old_password"/>
	               <s:password name="oldPassword" placeholder="******" minLength="5" maxLength="25" required="true"/>
	           </div>
	           <div class="form-group">
                   <s:fielderror fieldName="newPassword" cssClass="alert alert-danger"/>
                   <s:label for="newPassword" key="global.new_password"/>
	               <s:password name="newPassword" placeholder="******" minLength="5" maxLength="25" required="true"/>
 	           </div>

	           <div class="form-group">
	              <button class="btn btn-primary" type="submit"><s:property value="getText('global.change_password')"/></button>
	           </div>
             </s:form>
            </div>
           </div>
         </div>
       </div>
     </div>
   </div>
   <div class="col-md-offset-1 col-md-11 col-sm-12 col-xs-12">
   </div>
  </div>
</div>