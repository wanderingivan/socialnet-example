<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page trimDirectiveWhitespaces="true" %>

     <div class="main_content">
         <div class="row">
           <div class="col-sm-12 col-md-4">
             <div class="panel panel-default">
               <div class="panel-heading title">
                <div class="row">
                 <div class="col-md-4 col-sm-4 col-xs-6">
                   <h4><i class="fa fa-picture-o"></i>
                   <s:text name="global.gallery"/></h4>
                 </div>
                 <div class="col-md-offset-5 col-md-3 col-sm-offset-5 col-sm-3 col-xs-6">
                   <s:url action="gallery" namespace="/user" var="gallery">
                     <s:param name="username" value="user.username"/>
                   </s:url>
                   <h5><s:a href="%{gallery}" class="btn-sidebar"><s:property value="getText('global.view_all')"/></s:a></h5>                  
                 </div>
                </div>
               </div>
               <div class="panel-body">
                <s:if test="user.gallery.size() > 0">
                 <div class="image-list">
                  <s:subset source="user.gallery" count="8">
                  <s:iterator status="stat">
                    <s:url action="loadImage" namespace="/util" var="loadImage">
                      <s:param name="path" value="imagePath"/>
                    </s:url>
                    <div class="col-md-3 col-sm-4 col-xs-6">
                     <img alt="image" src="<s:property value='#loadImage'/>"/>
                    </div>
                  </s:iterator> 
                  </s:subset>
                 </div>
                 </s:if>
                <s:else>
                  <h3><s:property value="getText('global.nothing_here')"/></h3>
                </s:else>
               </div>
             </div>
           </div>
           <div class="col-xs-12 col-sm-12 col-md-4">
             <div class="panel panel-default">
               <div class="panel-heading title">
                 <h4><i class="fa fa-fw fa-info-circle"></i>
                 <s:text name="global.about"/></h4>
               </div>
               <div class="panel-body">
                <ul class="list-items" style="list-style:none">
                  <li>
					<div class="row">
                      <div class="col-xs-6 col-sm-6 col-md-4">
                        <span class="text-muted"><s:text name="global.description"/></span>
                      </div>
                      <div class="col-xs-6 col-sm-6 col-md-8">
                         <s:property value="user.details.description"/>
                      </div>
                    </div>
				  </li>
                  <li>
					<div class="row">
                      <div class="col-xs-6 col-sm-6 col-md-4">
                        <span class="text-muted"><s:property value="getText('global.occupation')"/></span>
                      </div>
                      <div class="col-xs-6 col-sm-6 col-md-8">
                         <s:property value="user.details.occupation"/>
                      </div>
                    </div>
				  </li>
                  <li>
					<div class="row">
                      <div class="col-xs-6 col-sm-6 col-md-4">
                        <span class="text-muted"><s:property value="getText('global.address')"/></span>
                      </div>
                      <div class="col-xs-6 col-sm-6 col-md-8">
                         <s:property value="user.details.address"/>
                      </div>
                    </div>
				  </li>
                </ul>
             </div>             
           </div>
          </div>
         <div class="col-xs-12 col-sm-12 col-md-4">
             <div class="panel panel-default">
               <div class="panel-heading title">
                <div class="row">
                 <div class="col-md-4 col-sm-4 col-xs-6">
                   <h4><i class="fa fa-group"></i>
                   <s:text name="global.friends"/></h4>
                 </div>
                   <s:url action="friends" namespace="/user" var="friends">
                     <s:param name="username" value="user.username"/>
                   </s:url>
                 <div class="col-md-offset-5 col-md-3 col-sm-offset-5 col-sm-3 col-xs-6">
                   <h5><s:a href="%{friends}" class="btn-sidebar"><s:text name="global.view_all"/></s:a></h5>                  
                 </div>
                </div>
               </div>
               <div class="panel-body">
                 <div class="image-list">
                 <s:subset source="user.friends" count="8">
                  <s:iterator value="user.friends" status="stat">
                    <s:url action="loadImage" namespace="/util" var="loadImage">
                      <s:param name="path">
                        <s:property value="profilePic"/>
                      </s:param>
                    </s:url>
                    <s:url action="loadUser" namespace="/user" var="showUser">
                      <s:param name="username">
                        <s:property value="username"/>
                      </s:param>
                    </s:url>
                    <div class="col-md-3 col-sm-4 col-xs-6">
                      <s:a href="%{showUser}">
                        <img alt="user image" src="<s:property value='#loadImage'/>"/>
                      </s:a>
                    </div>
                  </s:iterator>
                  </s:subset>
                 </div>
                 <s:url action="friends" namespace="/user" var="friends">
                   <s:param name="username">
                     <s:property value="user.username"/>
                   </s:param>
                 </s:url>
               </div>
             </div>
         </div>
       </div>
    </div>