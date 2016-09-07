<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page trimDirectiveWhitespaces="true" %>

     <div class="main_content">
	   <div class="container-fluid">
         <div class="row">
           <div class="col-md-offset-4 col-md-6 col-sm-12 col-xs-12">
             <div class="panel panel-default">
               <div class="panel-heading title">
                 <h4><i class="fa fa-group"></i>
                     <s:text name="global.user_friends"/></h4>
               </div>
               <div class="panel-body">
                  <div class="row">
                  <s:iterator value="user.friends" status="stat">
                    <div class="col-lg-4 col-md-6 col-sm-12  col-xs-12 text-center">
                    <s:url action="loadImage" namespace="/util" var="loadImage">
                      <s:param name="path" value="profilePic"/>
                    </s:url>
                    <s:url action="loadUser" namespace="/user" var="showUser">
                      <s:param name="username" value="username"/>
                    </s:url>
                    <s:a href="%{showUser}" tooltip="Visit Profile">
                      <img alt="user image" style="height:150px; width:150px;" src="<s:property value='#loadImage'/>"/>
                      <p><s:property value="username"/></p>
                    </s:a>
                    </div>
                  </s:iterator>
                  </div>
               </div>
             </div>
           </div>
         </div>
       </div>
     </div>
