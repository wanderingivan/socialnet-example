<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page trimDirectiveWhitespaces="true" %>
	<s:if test="wallPost != null">
            <div class="col-md-12">
              <s:div  id="wp%{wallPost.id}Comments" class="wall-post-container">

                <s:url action="deletePost" namespace="/message" var="deleteWp">
                  <s:param name="postId" value="%{wallPost.id}"/>
                </s:url>
                <s:subset source="wallPost.messages" count="5">
                <s:iterator status="mStat">
                  <s:set var="comment_count" value="messages.size()-1"/>
                  <s:url action="loadImage" namespace="/util" var="posterProfileImage">
                    <s:param name="path" value="poster.profilePic"/>
                  </s:url>
                  <s:url action="show" namespace="/user" var="showPoster">
					<s:param name="username" value="poster.username"/>
                  </s:url>
                  <s:set var="username">
                  	<s:property value="wallPost.owner.username"/>
                  </s:set>
                  <s:if test="#mStat.isFirst()">
                    <s:if test="imagePath != null">
                      <s:url action="loadImage" namespace="/util" var="postImage">
                        <s:param name="path" value="imagePath"/>
                      </s:url>
                      <div class="image-container">
                        <img class="post-image" src="<s:property value='#postImage'/>" alt="Post Image"/>
                        <s:a href="%{showPoster}"><img class="author-image" src="<s:property value='#posterProfileImage'/>" title="${poster.username}" alt="Poster Image"/></s:a>
                      </div>
                      <div class="image-post-title">
                          <s:if test="poster.username!=wallPost.owner.username">
                            <h4><s:text name="global.posted_on"/>:</h4>
					      </s:if>
                          <s:else>
                            <h4><s:text name="global.posted_on_his_wall"/>:</h4>
                          </s:else>
                          <span><s:date name="sent" nice="true"/></span>
                      </div>
                      <div class="item-post-author">
                         <sec:authorize access="isAuthenticated() and (hasRole('ROLE_ADMIN') or authentication.name=='${wallPost.owner.username}')">
                          <ul class="message-options list-unstyled">
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
                        	  <s:a href="%{showPoster}"><img class="poster-image" src="<s:property value='#posterProfileImage'/>"  title="${poster.username}" alt="Poster Image"/></s:a>
                            </div>
                            <div class="media-body">
						      <s:if test="poster.username!=wallPost.owner.username">
                                <h4><s:text name="global.posted_on"/>:</h4>
					          </s:if>
                              <s:else>
                                <h4><s:text name="global.posted_on_his_wall"/>:</h4>
                              </s:else>
                            </div>
                            <div class="media-right">
                         	  <sec:authorize access="isAuthenticated() and (hasRole('ROLE_ADMIN') or authentication.name=='${wallPost.owner.username}')">
                              <ul class="message-options">
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
          	                <span><s:text name="global.posted"/>  <s:date name="sent" nice="true"/></span>
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
                        <p><s:property value="poster.username"/>&nbsp;<s:property value="getText('global.said')"/>:<s:property value="message"/></p>
                        <span><s:date name="sent" nice="true"/></span>
                      </div>
                    </div> 
                  </s:else>
                </s:iterator>
                </s:subset>
                <div id="last" class="text-center">
	                 <img id="loadGif${wallPost.id}" src="${pageContext.request.contextPath}/images/loading.gif" alt="Loading..." style="display:none; height:25px;width:25px"/>
                </div>
                <s:if test="wallPost.messages.size() > 5">
                 <div class="text-center">
                   <s:form id="loadComments%{wallPost.id}" action="loadComments" namespace="/message" theme="simple">
                     <s:hidden name="postId" value="%{wallPost.id}"/>
                     <s:hidden name="index" value="5"/>
	         	     <s:hidden name="%{#attr._csrf.parameterName}" value="%{#attr._csrf.token}"/>
                     <sj:submit id="loadCommentsButton%{wallPost.id}"
                               dataType="json"
                               targets="t"
                               indicator="loadGif%{wallPost.id}"
                               onSuccessTopics="loadComments"
                               cssClass="load-link"
                               key="global.load_more"
                     />
                   </s:form>
                  </div>
                </s:if>
                <div class="message-form">
                  <sec:authorize access="isAuthenticated()">
                    <s:form id="commentForm%{wallPost.id}" action="post-reply" theme="simple" class="form-inline" namespace="/message">
                      <s:hidden name="postId" value="%{wallPost.id}"/>
	         	      <s:hidden name="%{#attr._csrf.parameterName}" value="%{#attr._csrf.token}"/>
                      <div class="form-group comments">
                        <s:fielderror fieldName="message" cssClass="alert alert-warning"/>
                        <s:textfield placeholder="%{getText('global.post_message')}" class="form-control comment-textfield" rows="1"  cols="50" name="message"/>
					    <sj:submit id="postaddMessage%{wallPost.id}" 
	  			  		       dataType="json"
                               targets="t"
                               indicator="loadGif%{wallPost.id}"
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
    </s:if>