<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="../page/header.jsp" />
<style>
	.table {border-top: 2px solid #ddd; border-bottom:1px solid #ddd;}
	.table th {text-align:center;}
	.table td {text-align:center; vertical-align: middle; line-height: 170px; padding: 4px 10px;}
	.table td.site {text-align:left;}
	.table .img-polaroid {width:120px; height:150px; margin: 0;}
</style>
<section id="inner-headline">
	<div class="container">
		<div class="row">
			<div class="span4">
				<div class="inner-heading">
					<h2>찜한 배우</h2>
				</div>
			</div>
			<div class="span8">
				<ul class="breadcrumb">
					<li><i class="icon-home"></i><i class="icon-angle-right"></i></li>
					<li>마이페이지<i class="icon-angle-right"></i></li>
					<li>찜한 배우</li>
				</ul>
			</div>
		</div>
	</div>
</section>

<section id="content">
	<div class="container">
		<div class="row">
			<jsp:include page="../member/viewLeftside.jsp" />
			<div class="row">
				<div class="span8">
					<c:choose>
						<c:when test="${fn:length(list) == 0 }">
							<span>찜한 배우가 없습니다.</span>
						</c:when>
						<c:otherwise>
							<form id="preferListForm" name="preferListForm" action="post">
								<table class="table table-striped table-hover">
									<thead>
										<tr>
											<th>사진</th>
											<th>성명</th>
											<th>생년월일</th>
											<th>사이트</th>
											<th>삭제</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="result" items="${list }" varStatus="status">
											<tr>
												<td><img src="<c:url value="/"/>resources/img/actor/${result.a_picture }" class="img-polaroid" /></td>
												<td><a
													href="${pageContext.request.contextPath}/actor/detail?a_id=${result.a_id}">${result.a_name }</a></td>
												<td><fmt:formatDate value="${result.a_birth }"
														pattern="yyyy-MM-dd" /></td>
												<td class="site"><a href="${result.a_homepage }">${result.a_homepage }</a></td>
												<td><a
													href="${pageContext.request.contextPath}/prefer/delete?a_id=${result.a_id}"
													class="btn btn-danger" title="찜한 배우 삭제">삭제</a></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</form>
							<div class="pagination pagination-large pagination-centered">
				  				<ul class="pagination">
						    		<c:if test="${paging.pdto.page != 1}">
						    			<li><a href="list?page=${paging.prevPage}&perPage=${paging.pdto.perPage}">&laquo;</a></li>
							    	</c:if>
									<c:forEach var="pageNum" begin="${paging.startPage}" end="${paging.endPage}">
										<c:choose>
											<c:when test="${pageNum == paging.pdto.page}">
												<li class="disabled"><a href="list?page=${pageNum}&perPage=${paging.pdto.perPage}">${pageNum}
													<span class="sr-only">(current)</span></a></li>
											</c:when>
											<c:otherwise>
												<li><a href="list?page=${pageNum}&perPage=${paging.pdto.perPage}">${pageNum}</a></li>
											</c:otherwise>
										</c:choose>
									</c:forEach>
									<c:if test="${paging.pdto.page != paging.pageCnt}">
										<li><a href="list?page=${paging.nextPage}&perPage=${paging.pdto.perPage}">&raquo;</a></li>
									</c:if>
								</ul>
							</div><!-- /.pagination -->
						</c:otherwise>
					</c:choose>
				</div><!-- /.span12 -->
			</div><!-- /.row -->
		</div><!-- /.row -->
	</div><!-- /.container -->
</section>

<jsp:include page="../page/footer.jsp" />