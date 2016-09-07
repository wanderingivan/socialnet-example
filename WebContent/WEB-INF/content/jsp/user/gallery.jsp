<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page trimDirectiveWhitespaces="true" %>

         <div class="row">
          <div class="main_content">
           <div class="col-md-12 col-sm-12 col-xs-12">
             <div class="panel panel-default">
               <div class="panel-heading title">
                 <h4><i class="fa fa-picture-o"></i>&nbsp;<s:text name="global.gallery"/></h4>
               </div>
               <div class="panel-body">
                <s:if test="user.gallery.size() > 0">
                 <div id="carousel-custom" class="carousel slide" data-interval="99999" data-ride="carousel">
                   <div class="carousel-outer">
                     <div class="carousel-inner">
                       <s:iterator value="user.gallery" status="stat">
                         <s:url action="loadImage" namespace="/util" var="loadImage">
                           <s:param name="path">
                             <s:property value="imagePath"/>
                           </s:param>
                         </s:url>
                         <s:url action="changeCover" namespace="/user" var="changeCover">
                           <s:param name="imageId">
                             <s:property value="id"/>
                           </s:param>
                         </s:url>
                         <s:url action="changeProfileImage" namespace="/user" var="changeProfileImage">
                           <s:param name="imageId">
                             <s:property value="id"/>
                           </s:param>
                         </s:url>
                         <s:url action="removeImage" namespace="/user" var="removeFromGallery">
                           <s:param name="imageId">
                             <s:property value="id"/>
                           </s:param>
                         </s:url>
                         <s:if test="#stat.isFirst()">
                           <div class="item active">
                             <img alt="image" src="<s:property value='#loadImage'/>"/>
                             <div class="row">
                              <div class="col-md-4">
                               <p><s:text name="global.description"/><br/><s:property value="description"/></p>
                               <p class="text-muted"><s:text name="global.uploaded"/>&nbsp;<s:date name="uploaded"/></p>
                              </div>
                              <div class="col-md-offset-4 col-md-4">
   	  	                        <sec:authorize access="isAuthenticated() and authentication.name =='${user.username}'">
                                  <ul style="list-style:none;">
                                    <li><s:a href="%{changeCover}"><s:text name="global.cover_change"/></s:a>&nbsp;</li>
                                    <li><s:a href="%{changeProfileImage}"><s:text name="global.profile_pic_change"/></s:a>&nbsp;</li>
                                    <li><s:a href="%{removeFromGallery}"><s:text name="global.remove_from_gallery"/></s:a></li>
                                  </ul>
                                </sec:authorize>
                              </div>
                             </div>
                           </div>
                         </s:if>
                         <s:else>
                           <div class="item">
                             <img alt="image" src="<s:property value='#loadImage'/>"/>
                             <div class="row">
                              <div class="col-md-4">
                               <p><s:text name="global.description"/><br/><s:property value="description"/></p>
                               <p class="text-muted"><s:text name="global.uploaded"/>&nbsp;<s:date name="uploaded"/></p>
                              </div>
                              <div class="col-md-offset-4 col-md-4">
   	  	                        <sec:authorize access="isAuthenticated() and authentication.name =='${user.username}'">
                                  <ul style="list-style:none;">
                                    <li><s:a href="%{changeCover}"><s:text name="global.cover_change"/></s:a>&nbsp;</li>
                                    <li><s:a href="%{changeProfileImage}"><s:text name="global.profile_pic_change"/></s:a>&nbsp;</li>
                                    <li><s:a href="%{removeFromGallery}"><s:text name="global.remove_from_gallery"/></s:a></li>
                                  </ul>
                                </sec:authorize>
                              </div>
                             </div>
                           </div>
                         </s:else>
                       </s:iterator>
                     </div> 
        		     <ol class="carousel-indicators">
        		       <s:iterator value="user.gallery" status="stat">
        		         <s:url action="loadImage" namespace="/util" var="loadThumbnailImage">
                           <s:param name="path">
                             <s:property value="imagePath"/>
                           </s:param>
                         </s:url>
        		         <li data-target="#carousel-custom" data-slide-to="<s:property value='#stat.index'/>"><img src="<s:property value='#loadThumbnailImage'/>" style="height:50px;width:50px;"></li>
        		       </s:iterator>
        		     </ol>
                   </div>
                 </div>
                </s:if>
                <s:else>
                  <h3><s:property value="getText('global.nothing_here')"/></h3>
                </s:else>
               </div>
             </div>
            </div>
           </div>
           <div class="col-md-1 hidden-xs"></div>
         </div>
   	  	 <sec:authorize access="isAuthenticated() and authentication.name =='${user.username}'">
         <div class="row">
           <div class="col-md-4 col-xs-12">
           <s:form cssClass="form-horizonthal" theme="simple" namespace="/user" action="addImage" enctype="multipart/form-data">
			 <s:hidden name="%{#attr._csrf.parameterName}" value="%{#attr._csrf.token}"/>
			 <div class="form-group">
               <s:file  name="image" accept="image/jpg,image/png" cssClass="btn btn-nav"/>
			   <s:textarea name="description" key="global.description" cssClass="form-control" placeholder="%{getText('global.description')}"/>
               <s:submit key="global.upload_image" cssClass="btn btn-nav"/>
             </div> 
           </s:form>
           </div>
           <div class="col-md-8 hidden-xs"></div>
         </div>
         </sec:authorize>
	    <script src="${pageContext.request.contextPath}/js/jquery.bcSwipe.min.js"></script>
		<script>
	    $('.carousel').bcSwipe({ threshold: 10 });
	    $(document).bind('keyup', function(e) {
	        if(e.which == 39){
	            $('.carousel').carousel('next');
	        }
	        else if(e.which == 37){
	            $('.carousel').carousel('prev');
	        }
	    });
		</script>