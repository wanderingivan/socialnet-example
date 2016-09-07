<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags" %>
<%@ page trimDirectiveWhitespaces="true" %>




             <s:form action="reply-message"  class="form-inline" namespace="/message" method="POST" theme="simple">
               <div class="form-group" style="width:100%; margin-bottom:20px;">
                 <button type="submit" class="btn btn-primary">
                   <i class="fa fa-envelope"></i>
                   <s:property value="getText('global.send')"/>
                 </button>
                 <s:textarea class="form-control share-text" placeholder="%{getText('global.send_message')}" name="message" required="true" maxLength="180"/>
                 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                 <s:hidden name="chatId" value="%{chat.id}"/>
               </div>
             </s:form>


             <s:set var="listEnd" >
               <s:if test="full == true">
                 <s:property value="chat.messages.size()"/>
               </s:if>
               <s:else>
                 6
               </s:else>
             </s:set>
             <s:subset source="chat.messages" count="%{#listEnd}">
             <s:iterator status="stat">
               <s:url action="loadImage" namespace="/util" var="loadUserImage">
                 <s:param name="path">
                   <s:property value="sender.profilePic"/>
                 </s:param>
               </s:url>
               <s:url action="show" namespace="/user" var="show">
                 <s:param name="username">
                   <s:property value="sender.username"/>
                 </s:param>
               </s:url>
               <div class="media">
                 <s:if test="sender.username == username">
                 <div class="media-left">
                   <s:a href="%{show}">
                     <img style="width:50px;height:50px;"class="media-object" src="<s:property value="#loadUserImage"/>"/>
                   </s:a>
                 </div>
                 </s:if>
                 <div class="media-body">
		           <div class="panel panel-default">
		             <div class="panel-heading title">
                       <div class="row">
                         <div class="col-md-5 col-sm-5 col-xs-6">
		                   <s:a href="%{show}"><s:property value="sender.username"/></s:a>
					     </div>
                         <div class="col-md-4 col-sm-4 hidden-xs"></div>
                         <div class="col-md-3 col-sm-3 col-xs-6">
		                   <i class="fa fa-calendar-o"></i>
		                   <s:date name="sent" format="MMMM dd yyyy"/>
                         </div>
                       </div>
		             </div>
		             <div class="panel-body">
		               <p><s:property value="message"/></p>
		             </div>
		           </div>
		         </div>
		         <s:else>
                   <div class="media-right">
                     <s:a href="%{show}">
                       <img style="width:50px;height:50px;"class="media-object" src="<s:property value="#loadUserImage"/>"/>
                     </s:a>
                   </div>
		         </s:else>
               </div>
             </s:iterator>
             </s:subset>
             <div class="text-center">
	           <img id="loadGif" src="${pageContext.request.contextPath}/images/loading.gif" alt="Loading..." style="display:none"/>
               <s:if test="full != true && chat.messages.size() > 5">
               <s:form id="loadfull%{chat.id}" action="chat" namespace="/message" theme="simple">
                    <s:hidden name="chatId" value="%{chat.id}"/>
                    <s:hidden name="full" value="true"/>
	         	    <s:hidden name="%{#attr._csrf.parameterName}" value="%{#attr._csrf.token}"/>
                    <sj:submit id="full%{chat.id}"
                       targets="load"
                       indicator="loadGif"        
				       key="global.load_all"
                    />
               </s:form>
               </s:if>
             </div>