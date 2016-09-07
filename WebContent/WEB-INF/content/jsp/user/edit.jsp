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
             <s:form action="edit" namespace="/user" method="POST" cssClass="form-horizonthal" theme="simple">
               <s:hidden name="id" value="%{user.id}"/>
	           <s:hidden name="%{#attr._csrf.parameterName}" value="%{#attr._csrf.token}"/>
               <div class="form-group">
                  
                   <s:fielderror fieldName="user.username" cssClass="alert alert-danger"/>
                   <s:label for="user.username" key="global.username"/>
	               <s:textfield name="user.username" value="user.username" minLength="5" maxLength="25" required="true"/>
	           </div>
	           <div class="form-group">
                  <s:fielderror fieldName="user.email" cssClass="alert alert-danger"/>
                   <s:label for="user.email" key="global.email"/>
 	               <s:textfield name="user.email" value="user.email" key="global.email" type="email" required="true"/>
 	           </div>
 	           <div class="form-group">
                   <s:fielderror fieldName="user.password" cssClass="alert alert-danger"/>
                   <s:label for="user.password" key="global.password"/>
	               <s:password name="user.password" key="global.password" placeholder="*****" minLength="5" maxLength="25" required="true"/>
	           </div>
	           <div class="form-group">
	              <button class="btn btn-primary" type="submit"><s:property value="getText('global.edit')"/></button>
	           </div>
             </s:form>
            </div>
           </div>
         </div>
       </div>
     </div>
   </div>
   <div class="col-md-offset-1 col-md-11 col-sm-12 col-xs-12">
   <div id="card"  class="col-md-offset-3 col-md-5 col-md-offset-3">
     <div class="panel panel-default">
       <div class="panel-heading title">
    	 <div class="row">
    	   <div class="col-md-5 col-sm-6 col-xs-8">
    	     <h4><i class="fa fa-fw fa-info-circle"></i>&nbsp;<s:text name="global.add_details"/></h4>
    	   </div>
    	   <div class="col-md-offset-5 col-md-2 col-sm-offset-4 col-sm-2 col-xs-offset-1 col-xs-3">
    	   </div>
    	 </div>
       </div>
       <div class="panel-body">
         <div class="row">
           <div class="col-md-offset-1 col-md-10 col-md-offset-1 col-sm-offset-1 col-sm-10 col-sm-offset-1 col-xs-offset-1 col-xs-10 col-xs-offset-1">
			 <s:form action="addDetails" namespace="/user" method="POST" theme="simple" cssClass="form-horizonthal">
   			   <s:hidden name="userId" value="%{user.id}"/>
	           <s:hidden name="%{#attr._csrf.parameterName}" value="%{#attr._csrf.token}"/>
   			   <div class="form-group">
             <s:fielderror fieldName="details.description" cssClass="alert alert-danger"/>
                   <s:label for="details.description" key="global.description"/>
	    		   <s:textarea name="details.description" value="%{user.details.description}" maxLength="250" key="global.description"/>
   			   </div>
   			   <div class="form-group">
             <s:fielderror fieldName="details.occupation" cssClass="alert alert-danger"/>
                   <s:label for="details.occupation" key="global.occupation"/>
			       <s:textfield name="details.occupation" value="%{user.details.occupation}" maxLength="50" key="global.occupation"/>
   			   </div>
   			   <div class="form-group">
             <s:fielderror fieldName="details.address" cssClass="alert alert-danger"/>
                   <s:label for="details.address" key="global.address"/>
			       <s:textfield name="details.address" value="%{user.details.address}" maxLength="50" key="global.address"/>
   			   </div>
   			   <div class="form-group">
	             <button class="btn btn-primary" type="submit"><s:property value="getText('global.add_details')"/></button>
   			   </div>
             </s:form> 
           </div>
         </div>
       </div>
     </div>
   </div>
   </div>
  </div>
</div>