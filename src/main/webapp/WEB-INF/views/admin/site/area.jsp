<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<meta charset="UTF-8">
<jsp:include page="../../page/header.jsp" />

<script>
	function addArea() {
		console.log($("#addArea").serialize());
		$.ajax({
			url: "${pageContext.request.contextPath}/admin/site/area/add",
			type: "post",
			async: false,
			data: $("#addArea").serialize(),
			success: function(data) {
				alert("성공적으로 추가되었습니다.");
			},
			error: function(data) {
				alert("error : " + data);
			}
		})
		window.location.reload();
		return false;
	}
	
	function updateArea(a_id) {
		var newName = prompt("지역의 새 이름을 입력하세요.");
		if (newName === null)
			return;
		$.ajax({
			url: "${pageContext.request.contextPath}/admin/site/area/edit",
			type: "post",
			async: false,
			data: {"a_id" : a_id, "a_name" : newName},
			success: function(data) {
				alert("성공적으로 수정되었습니다.");
			},
			error: function(data) {
				alert("error : " + data);
			}
		})
		window.location.reload();
	}
</script>

<div class="container">
	<div class="row">
		<div class="row">
			<div class="span8">

				<jsp:include page="integratedheader.jsp" />
				<h2>지역 관리</h2>

				<table class="table table-striped" border="1">
					<thead>
						<tr>
							<th>id</th>
							<th>이름</th>
							<th>수정</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="area" items="${areaList}">
							<tr>
								<td>${area.a_id}</td>
								<td>${area.a_name}</td>
								<td><button class="btn btn-primary btn-small" onclick="updateArea(${area.a_id})">수정</button></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<p>새 지역</p>

				<form id="addArea" onsubmit="return addArea();">
					<input type="text" name="a_name"> <input class="btn btn-primary btn-small" type="submit">
				</form>
			</div>
		</div>
	</div>
</div>

