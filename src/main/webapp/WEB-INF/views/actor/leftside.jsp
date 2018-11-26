<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="http://localhost:8080/playChoice/article/" var="uuu" />

<div class="span2">
	<aside class="left-sidebar">
		<div class="widget">
			<h5 class="widgetheading">고객센터</h5>
			<ul class="cat">
				<li><i class="icon-angle-right"></i> <a href="${uuu }notice/list">공지사항</a></li>
				<li><i class="icon-angle-right"></i> <a href="${uuu }faq/list">FAQ</a></li>
				<c:if test="${!empty login}">
					<li><i class="icon-angle-right"></i> <a href="${uuu }contact/list?m_code=${login.m_code }">1:1문의</a></li>
				
				</c:if>
			</ul>
		</div>
	</aside>
</div>
