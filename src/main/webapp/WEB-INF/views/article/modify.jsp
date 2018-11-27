<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<jsp:include page="../page/header.jsp" />
<section id="inner-headline">
	<div class="container">
		<div class="row">
			<div class="span4">
				<div class="inner-heading">
					<h2>고객센터</h2>
				</div>
			</div>
			<div class="span8">
				<ul class="breadcrumb">
					<li><a href="#"><i class="icon-home"></i></a><i
						class="icon-angle-right"></i></li>
					<li><a href="customergongi">고객센터</a><i
						class="icon-angle-right"></i></li>
					<li class="active">1:1문의</li>
				</ul>
			</div>
		</div>
	</div>
</section>
<section id="content">
	<div class="container">
		<jsp:include page="leftside.jsp" />
		<!-- Default table -->
		<div class="row">
			<div class="span8">
				<h4></h4>
				<form action="${pageContext.request.contextPath}/article/notice/modifyReg">
					<table class="table table-bordered">
						<thead>
							<tr>
								<td>제목<input type="text" name="a_title" style="width: 95%"
									value=${data.a_title }> <input type="hidden"
									name="a_id" style="width: 95%" value="${data.a_id }"></td>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td colspan="4"><input type="text" name="a_content"
									style="width: 98%; height: 300px" value="${data.a_content }"></td>
							</tr>
							<tr>
								<td colspan="4"><input type="submit"
									class="btn btn-square btn-theme" style="width: 100%" value="수정" /></td>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
		</div>
	</div>
	</div>
</section>
<jsp:include page="../page/footer.jsp" />