<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page trimDirectiveWhitespaces="true" %>


      <div class="row">
        <sec:authorize access="isAuthenticated()">
        <div class="col-md-offset-7 col-md-5 col-sm-6 col-xs-12">
            <div class="timeline-block">
              <div id="WallPostForm" class="panel panel-default">
                <div class="panel-heading title">
                  <h4><s:property value="getText('global.wall')"/></h4>
                </div>
                <s:form action="create" namespace="/message" enctype="multipart/form-data" theme="simple" class="form">
	         	  <s:hidden name="%{#attr._csrf.parameterName}" value="%{#attr._csrf.token}"/>
                  <s:hidden name="owner" value="%{user.username}"/>
                  <s:textarea rows="5" class="form-controll" placeholder="%{getText('global.post_message')}" cols="38" name="message" required="true" maxLength="350"></s:textarea>
                  <button type="submit"><i class="fa fa-pencil"></i></button>
                  <s:file name="postImage" class="btn btn-primary"  accept="image/jpg"/>
                </s:form>
              </div>
            </div>
        <div class="col-md-6"></div>
        </div>
        </sec:authorize>
        <div id="wall" class="col-md-12">
          <s:set var="size">
            <s:if test="user.wallPosts.size() == 0">
            	0
            </s:if>
          	<s:elseif test="user.wallPosts.size() < 6">
          		${user.wallPosts.size()}
          	</s:elseif>
          	<s:else>
          		6
          	</s:else>
          </s:set>
         
          <s:if test="#size != 0">
          <div id="left" class="col-md-6 col-sm-12 col-xs-12">
          <s:iterator value="user.wallPosts" begin="0" end="%{#size-1}" step="2">
            <div class="col-md-12">
              <s:div  id="wp%{id}Comments" class="wall-post-container">
               <s:url action="deletePost" namespace="/message" var="deleteWp">
                 <s:param name="postId" value="%{id}"/>
               </s:url>
               <s:subset source="messages" count="5">
                <s:iterator status="mStat">
                  <s:set var="comment_count" value="messages.size()-1"/>
                  <s:url action="loadImage" namespace="/util" var="posterProfileImage">
                    <s:param name="path" value="%{poster.profilePic}"/>
                  </s:url>
                  <s:url action="show" namespace="/user" var="showPoster">
					<s:param name="username" value="%{poster.username}"/>
                  </s:url>
                  <s:if test="#mStat.isFirst()">
                    <s:if test="imagePath != null">
                      <s:url action="loadImage" namespace="/util" var="postImage">
                        <s:param name="path" value="%{imagePath}"/>
                      </s:url>
                      <div class="image-container">
                        <img class="post-image" src="<s:property value='#postImage'/>"  alt="Post Image"/>
                        <s:a href="%{showPoster}"><img class="author-image" src="<s:property value='#posterProfileImage'/>" title="${poster.username}" alt="Poster Image"/></s:a>
                      </div>
                      <div class="image-post-title">
                          <s:if test="poster.username!=user.username">
                            <h4><s:text name="global.posted_on"/>:</h4>
					      </s:if>
                          <s:else>
                            <h4><s:text name="global.posted_on_his_wall"/>:</h4>
                          </s:else>
                          <span><s:date name="sent" nice="true"/></span>
                      </div>
                      <div class="item-post-author">
                         <sec:authorize access="isAuthenticated() and (hasRole('ROLE_ADMIN') or authentication.name=='${user.username}')">
                          <ul class="message-options">
                            <li>
                              <s:a href="%{deleteWp}"><s:text name="global.delete"/></s:a>
                            </li>
                          </ul>                          
                        </sec:authorize>
                      </div>
                      <div class="item-post-content">
                        <p><s:property value="message"/></p>
                      </div> 
                    </s:if>
                    <s:else>
                      <div class="text-post">
                        <div class="text-post-author">
                          <div class="media">
                            <div class="media-left">
                        	  <s:a href="%{showPoster}"><img class="poster-image" src="<s:property value='#posterProfileImage'/>" title="${poster.username}" alt="Poster Image"/></s:a>
                            </div>
                            <div class="media-body">                              
						      <s:if test="poster.username!=user.username">
                                <h4><s:text name="global.posted_on"/>&nbsp;:</h4>
					          </s:if>
                              <s:else>
                                <h4><s:text name="global.posted_on_his_wall"/>&nbsp;:</h4>
                              </s:else>
                            </div>
                            <div class="media-right">
                         	  <sec:authorize access="isAuthenticated() and (hasRole('ROLE_ADMIN') or authentication.name=='${user.username}')">
                              <ul class="message-options list-unstyled">
                                <li>
                              	  <s:a href="%{deleteWp}"><s:text name="global.delete"/></s:a>
                                </li>
                              </ul>                          
                              </sec:authorize>
                            </div>
                          </div>
                          <div class="line"></div>
                          <div class="text-post-content">
                            <p><s:property value="message"/></p>
          	                <span class="text-muted"><s:text name="global.posted"/>&nbsp;<s:date name="sent" nice="true"/></span>
                          </div>
                        </div>
                      </div>
                    </s:else>
                  </s:if>
                  <s:else>
                    <div class="media comments well well-sm">
                      <div class="media-left">
                        <s:a href="%{showPoster}"><img class="poster-image" src="<s:property value='#posterProfileImage'/>" title="${poster.username}" alt="Poster Image"/></s:a>
                      </div>
                      <div class="media-body">
                        <h5 class="media-heading"><s:property value="poster.username"/>&nbsp;<s:text name="global.said"/>:</h5>
                        <p><s:property value="message"/></p>
                      </div>
                      <span class="text-muted"><s:date name="sent" nice="true"/></span>
                    </div> 
                  </s:else>
                </s:iterator>
                </s:subset>
                <div id="last" class="text-center">
	              <img id="loadGif${id}" src="${pageContext.request.contextPath}/images/loading.gif" alt="Loading..." style="display:none; height:25px;width:25px"/>
                </div>
                <s:if test="messages.size() > 5">
                 <div class="text-center">

                   <s:form id="loadComments%{id}" action="loadComments" namespace="/message" theme="simple">
                     <s:hidden name="postId" value="%{id}"/>
                     <s:hidden name="index" value="5" autocomplete="off"/>
	         	     <s:hidden name="%{#attr._csrf.parameterName}" value="%{#attr._csrf.token}"/>
                     <sj:submit id="loadCommentsButton%{id}"
                               dataType="json"
                               targets="t"
                               indicator="loadGif%{id}"
                               onSuccessTopics="loadComments"
                               cssClass="load-link"
                               key="global.load_more"
                     />
                   </s:form>
                  </div>
                </s:if>
                <div class="message-form">
                  <sec:authorize access="isAuthenticated()">
                    <s:form id="commentForm%{id}" action="post-reply" theme="simple" class="form-inline" namespace="/message">
                      <s:hidden name="postId" value="%{id}"/>
	         	      <s:hidden name="%{#attr._csrf.parameterName}" value="%{#attr._csrf.token}"/>
                      <div class="form-group comments">
                        <s:fielderror fieldName="message" cssClass="alert alert-warning"/>
                        <s:textfield placeholder="%{getText('global.post_message')}" class="form-control comment-textfield" rows="1"  cols="50" name="message" required="true" maxLength="350"/>
					    <sj:submit id="postaddMessage%{id}" 
	  			  		       dataType="json"
                               targets="t"
                               indicator="loadGif%{id}"
					           onSuccessTopics="addComment"
					           cssClass="form-control comment-submit"
					           key="global.send"
					    />
                      </div>
                    </s:form>
                  </sec:authorize>
                </div>
              </s:div>
            </div>
          </s:iterator>
          </div>
          <div id="right" class="col-md-6 col-sm-12 col-xs-12">
          <s:iterator value="user.wallPosts" begin="1" end="%{#size-1}" step="2">
            <div class="col-md-12">
              <s:div  id="wp%{id}Comments" class="wall-post-container">
               <s:url action="deletePost" namespace="/message" var="deleteWp">
                 <s:param name="postId" value="%{id}"/>
               </s:url>
               <s:subset source="messages" count="5">
                <s:iterator status="mStat">
                  <s:set var="comment_count" value="messages.size()-1"/>
                  <s:url action="loadImage" namespace="/util" var="posterProfileImage">
                    <s:param name="path" value="%{poster.profilePic}"/>
                  </s:url>
                  <s:url action="show" namespace="/user" var="showPoster">
					<s:param name="username" value="%{poster.username}"/>
                  </s:url>
                  <s:if test="#mStat.isFirst()">
                    <s:if test="imagePath != null">
                      <s:url action="loadImage" namespace="/util" var="postImage">
                        <s:param name="path" value="%{imagePath}"/>
                      </s:url>
                      <div class="image-container">
                        <img class="post-image" src="<s:property value='#postImage'/>"  alt="Post Image"/>
                        <s:a href="%{showPoster}"><img class="author-image" src="<s:property value='#posterProfileImage'/>" title="${poster.username}" alt="Poster Image"/></s:a>
                      </div>
                      <div class="image-post-title">
                          <s:if test="poster.username!=user.username">
                            <h4><s:text name="global.posted_on"/>:</h4>
					      </s:if>
                          <s:else>
                            <h4><s:text name="global.posted_on_his_wall"/>:</h4>
                          </s:else>
                          <span><s:date name="sent" nice="true"/></span>
                      </div>
                      <div class="item-post-author">
                        <sec:authorize access="isAuthenticated() and (hasRole('ROLE_ADMIN') or authentication.name=='${user.username}')">
                          <ul class="message-options list-unstiled">
                            <li>
                              <s:a href="%{deleteWp}"><s:text name="global.delete"/></s:a>
                            </li>
                          </ul>                          
                        </sec:authorize>
                      </div>
                      <div class="item-post-content">
                        <p><s:property value="message"/></p>
                      </div> 
                    </s:if>
                    <s:else>
                      <div class="text-post">
                        <div class="text-post-author">
                          <div class="media">
                            <div class="media-left">
                        	  <s:a href="%{showPoster}"><img class="poster-image" src="<s:property value='#posterProfileImage'/>" title="${poster.username}" alt="Poster Image"/></s:a>
                            </div>
                            <div class="media-body">                              
						      <s:if test="poster.username!=user.username">
                                <h4><s:text name="global.posted_on"/>&nbsp;:</h4>
					          </s:if>
                              <s:else>
                                <h4><s:text name="global.posted_on_his_wall"/>&nbsp;:</h4>
                              </s:else>
                            </div>
                            <div class="media-right">
                        	  <sec:authorize access="isAuthenticated() and (hasRole('ROLE_ADMIN') or authentication.name=='${user.username}')">
                              <ul class="message-options list-unstyled">
                                <li>
                              	  <s:a href="%{deleteWp}"><s:text name="global.delete"/></s:a>
                                </li>
                              </ul>                          
                              </sec:authorize>
                            </div>
                          </div>
                          <div class="line"></div>
                          <div class="text-post-content">
                            <p><s:property value="message"/></p>
          	                <span class="text-muted"><s:text name="global.posted"/>&nbsp;<s:date name="sent" nice="true"/></span>
                          </div>
                        </div>
                      </div>
                    </s:else>
                  </s:if>
                  <s:else>
                    <div class="media comments well well-sm">
                      <div class="media-left">
                        <s:a href="%{showPoster}"><img class="poster-image" src="<s:property value='#posterProfileImage'/>" title="${poster.username}" alt="Poster Image"/></s:a>
                      </div>
                      <div class="media-body">
                        <h5 class="media-heading"><s:property value="poster.username"/>&nbsp;<s:text name="global.said"/>:</h5>
                        <p><s:property value="message"/></p>
                      </div>
                      <span class="text-muted"><s:date name="sent" nice="true"/></span>
                    </div> 
                  </s:else>
                </s:iterator>
                </s:subset>
                <div id="last" class="text-center">
	              <img id="loadGif${id}" src="${pageContext.request.contextPath}/images/loading.gif" alt="Loading..." style="display:none; height:25px;width:25px"/>
                </div>
                <s:if test="messages.size() > 5">
                 <div class="text-center">

                   <s:form id="loadComments%{id}" action="loadComments" namespace="/message" theme="simple">
                     <s:hidden name="postId" value="%{id}"/>
                     <s:hidden name="index" value="5" autocomplete="off"/>
	         	     <s:hidden name="%{#attr._csrf.parameterName}" value="%{#attr._csrf.token}"/>
                     <sj:submit id="loadCommentsButton%{id}"
                               dataType="json"
                               targets="t"
                               indicator="loadGif%{id}"
                               onCompleteTopics="loadComments"
                               cssClass="load-link"
                               key="global.load_more"
                     />
                   </s:form>
                  </div>
                </s:if>
                <div class="message-form">
                  <sec:authorize access="isAuthenticated()">
                    <s:form id="commentForm%{id}" action="post-reply" theme="simple" class="form-inline" namespace="/message">
                      <s:hidden name="postId" value="%{id}"/>
	         	      <s:hidden name="%{#attr._csrf.parameterName}" value="%{#attr._csrf.token}"/>
                      <div class="form-group comments">
                        <s:fielderror fieldName="message" cssClass="alert alert-warning"/>
                        <s:textfield placeholder="%{getText('global.post_message')}" class="form-control comment-textfield" rows="1"  cols="50" name="message" required="true" maxLength="350"/>
					    <sj:submit id="postaddMessage%{id}" 
	  			  		       dataType="json"
                               targets="t"
                               indicator="loadGif%{id}"
					           onSuccessTopics="addComment"
					           cssClass="form-control comment-submit"
					           key="global.send"
					    />
                      </div>
                    </s:form>
                  </sec:authorize>
                </div>
              </s:div>
            </div>
          </s:iterator>
          </div>
          </s:if>
          <s:else>
          	<div class="well well-sm">
          		<h3><s:text name="global.empty_wall"/></h3>
          	</div>
          </s:else>
        </div>
        <s:if test="#size != 0">
          <div id="load" class="col-md-offset-4 col-md-4 col-sm-12 col-xs-12">
           <div class="text-center">
	         <img id="loadGif" src="${pageContext.request.contextPath}/images/loading.gif" alt="Loading..." style="display:none; height:55px;width:55px"/> 
           <s:form id="loadPostForm" action="loadPost" namespace="/message" theme="simple">
           	 <s:hidden name="userId" value="%{user.id}"/>
           	 <s:hidden name="index" value="6" autocomplete="off"/>
	         <s:hidden name="%{#attr._csrf.parameterName}" value="%{#attr._csrf.token}"/>
             <sj:submit id="loadPostButton%{user.id}"
                        dataType="json"
                        targets="t"
                        onCompleteTopics="loadPost"
                        cssClass="load-link body"
                        indicator="loadGif"
                        key="global.load_more"
                     />
           </s:form>

           </div>
          </div>
          <div class="col-md-4"></div>
        </s:if>
      </div>
	<div id="vpsize" class="visible-md visible-lg"></div>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/wall.js"></script>