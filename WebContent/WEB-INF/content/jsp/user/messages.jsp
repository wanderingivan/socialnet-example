<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags" %>
<%@ page trimDirectiveWhitespaces="true" %>


     <div class="main_content">
	   <div class="container-fluid">
 		 <div class="media chat-list">
		   <div class="media-left chats">
             <div class="panel panel-default">
               <ul class="list-group">
                <s:subset source="user.chats" count="10">
                <s:iterator status="stat">
                  <s:url action="loadImage" namespace="/util" var="loadImage">
                    <s:param name="path">
                      <s:property value="getOther(username).getProfilePic()"/>
                    </s:param>
                  </s:url>
                   <s:url action="chat" namespace="/message" var="showChat">
                    <s:param name="chatId" value="%{id}"/>
                  </s:url>
				  <s:set var="username">
                    <s:property value="getOther(username).getUsername()"/>									
				  </s:set>                 
 		  	     <li class="list-group-item">		  	     
                     <div class="media">
                       <div class="media-left">
                         <sj:a id="chat%{id}"
                        	  href="%{showChat}"
                        	  button="true"
                        	  targets="load"
			                  indicator="loadGif"
			                  
						      effect="highlight"
                              effectOptions="{color:'#b3de1d'}"
						      effectDuration="1000"
                        	  >
                           <img style="width:75px;height:75px;" class="" src="<s:property value='#loadImage'/>" title="${username}" alt="${username}"/>
                         </sj:a>
                       </div>
                       <div class="media-body">
                         <p>
                           <s:if test="messages[0].message.length() > 50">
                             <s:property value="messages[0].message.substring(0,50)"/>
                           </s:if>
                           <s:else>
                             <s:property value="messages[0].message"/>
                           </s:else>
                         </p>
                         <span class="text-muted"><s:date name="lastUpdate" nice="true"/></span>
                       </div>
                     </div>           
                 </li>
                 <s:if test="#stat.isFirst()">
                   <s:set var="first">
                     <s:param name="value">
                       <s:property />
                     </s:param>
                   </s:set>
                 </s:if>
                </s:iterator>
                </s:subset>
               </ul>
             </div>
           </div> 
         </div>
         <div id="load" class="media-body messages">
           <s:if test="user.chats.size() > 1">
             <s:form action="reply-message"  class="form-inline" namespace="/message" method="POST" theme="simple">
               <div class="form-group" style="width:100%; margin-bottom:20px;">
                 <button type="submit" class="btn btn-primary">
                   <i class="fa fa-envelope"></i>
                   <s:property value="getText('global.send')"/>
                 </button>
                 <s:textarea class="form-control share-text" placeholder="%{getText('global.send_message')}" name="message" required="true" maxLength="180"/>
			     <s:hidden name="%{#attr._csrf.parameterName}" value="%{#attr._csrf.token}"/>
                 <s:hidden name="chatId" value="%{#first.id}"/>
               </div>
             </s:form>
             <s:subset source="#first.messages" count="5">
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
		               <div class="pull-right">
		                 <i class="fa fa-calendar-o"></i>
		                 <s:date name="sent" format="MMMM dd yyyy"/>
		               </div>
		               <s:a href="%{show}"><s:property value="sender.username"/></s:a>
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
               <s:form id="loadfull%{#first.id}" action="chat" namespace="/message" theme="simple">
                    <s:hidden name="chatId" value="%{#first.id}"/>
                    <s:hidden name="full" value="true"/>
	         	        <s:hidden name="%{#attr._csrf.parameterName}" value="%{#attr._csrf.token}"/>
                    <sj:submit id="full%{#first.id}"
                       targets="load"
                       indicator="loadGif"        
				               key="global.load_all"
                    />
              </s:form>
             </div>
           </s:if>
	       <s:else>
             <div class="col-md-12">
               <h3><s:property value="getText('global.nothing_here')"/></h3>
             </div>
           </s:else>
         </div>
	   </div>
	 </div>
 