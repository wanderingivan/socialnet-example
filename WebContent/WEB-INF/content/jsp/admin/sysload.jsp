<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>

<p>Load Average:&nbsp;</p>
<div class="row" style="background-color:#000;color:#fff;border-radius:4px;font-size:11px">
  <div class="col-md-8 col-sm-8 col-xs-8" style="letter-spacing:-1px">
  <s:iterator begin="0" end="loadAverage" step="5" status="stat">

    <s:if test="#stat.count >15">
      <span style="color:red">|</span>
    </s:if>
    <s:elseif test="#stat.count > 7">
      <span style="color:yellow">|</span>
    </s:elseif>
    <s:else>
      <span style="color:green">|</span>
    </s:else>
   </s:iterator> 
   </div>
   <div class="col-md-4 col-sm-4 col-xs-4">
   <s:number name="loadAverage"/>%
   </div>
</div>