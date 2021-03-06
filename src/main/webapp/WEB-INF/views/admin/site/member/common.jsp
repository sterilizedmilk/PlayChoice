<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="http://localhost:8080/playChoice/admin/site/member/" var="member" />
<!DOCTYPE html >
<jsp:include page="../../../page/header.jsp" />
<jsp:include page="../integratedheader.jsp" />

<div class="container">
	<div class="row">
		<!-- Default table -->
		<div class="row">
			<div class="span8">
				<h4>회원 관리</h4>

				<table class="table table-striped" border="">
					<thead>
						<tr>
							<th>번호</th>
							<th>아이디</th>
							<th>이름</th>
							<th>레벨</th>
							<th>이메일</th>
							<th>전화번호</th>
							<th>상태</th>
							<th>상세보기</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${memberlist}" var="dd" varStatus="no">
								<tr>
									<td>${dd.m_code}</td>
									<td>${dd.m_id}</td>
									<td>${dd.m_name}</td>
									<td>${dd.m_level}</td>
									<td>${dd.m_mail}</td>
									<td>${dd.m_phone}</td>
									<td>${dd.m_status}</td>
									<td>
									<button class="btn btn-primary btn-small" title="상세보기"
									onclick="location.href='${pageContext.request.contextPath}/admin/site/member/detail?m_code=${dd.m_code}'">상세
									</button></td>
								</tr>
						</c:forEach>
					</tbody>
				</table>
				<button class="btn btn-primary btn-small"
						onclick="location.href='${pageContext.request.contextPath}/admin/site/member/search'">
						상세 검색</button><br>
				
			</div>
		</div>
	</div>
</div>