<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<!-- ${pageContext.request.contextPath} -->

<jsp:include page="../page/header.jsp" />
<link href="${pageContext.request.contextPath}/resources/rateit/scripts/rateit.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/rateit/scripts/jquery.rateit.min.js">
</script>
<meta charset="UTF-8">
<style type="text/css">
.qna_question {
	outline: 1px solid #eee;
	padding: 10px;
	margin: 30px 0 0 0;
}

.qna_answer {
	outline: 1px solid #eee;
	padding: 10px;
	background-color: #FAF4C0;
	margin: 0px 0px 30px 0px;
}

</style>
<script>
	$(document).ready(function() {
		var quantity = parseInt($("#quantity").val()); //구매할 티켓수
		var price; // 티켓 가격
		var total; // 티켓 총합
		var scheId; // 스케쥴 아이디
		var scehTime; // 스케쥴 타임
		
		$("#ticket_div").hide();
		
		// 티켓 수 출력
		$('#ticket').text(quantity);
		
		//스케쥴 선택
		$(".scheduleCho").click(function() {
			$("#ticket_div").show();
			price = parseInt($(this).attr("price"))
			total = parseInt($(this).attr("price"))	* parseInt($("#quantity").val());
			scheId = $(this).val();
			scehTime = $(this).attr("date");

			$("#scheText").text(scehTime);
			$("#schePrice").text($(this).attr("price") + " 원");
			$("#totalCost").text(total);

		});

		//매표 수 마이너스
		$('#minus').click(function() {
			//최저 매표 1
			if ($('#quantity').val() > 1) {
				quantity -= 1;
				total = price * quantity;
				$('#quantity').val(quantity);
				$('#ticket').text(quantity); // 티켓 수 출력
				$("#totalCost").text(total); // 총가격 출력
			} else {
				quantity = 1;
				$('#quantity').val(quantity);
			}

		})
			
		//매표 수 플러스
		$('#plus').click(function() {
			quantity += 1;
			total = price * quantity;
				$('#quantity').val(quantity);
				$('#ticket').text(quantity); // 티켓 수 출력
				$("#totalCost").text(total); // 총가격 출력
		})

		//장바구니
		$('#cart').click(function() {
			$("#frmId").val(scheId);
			$("#frmPrice").val(total);
			$("#frmQuantity").val(quantity);

			frm.action = "${pageContext.request.contextPath}/basket/insert";
			frm.submit();
		});

		//결제
		$('#charge').click(function() {
			$("#frmId").val(scheId);
			$("#frmPrice").val(total);
			$("#frmQuantity").val(quantity);

			frm.action = "payment";
			frm.submit();
		});
		
		
		//QnA keyup
		$("#q_content").keyup(function(){
			var length = $("#q_content").val().length;
			$("#q_content").next().text(length)
		})
		
		
		// Q & A 등록
		$("#qsubmit").click(function() {
			//유효성 검사
			if($("#q_content").val() == "" || $("#q_content").val() == null){
				alert("내용을 입력해주세요");
				return false;
			}
			if($("#q_content").val().length < 5){
				alert("5자 이상 입력해주세요");
				$("#q_content").focus();
				return false;
			}
			if($("#q_content").val().length > 100){
				alert("100자 이하로 입력해주세요");
				$("#q_content").focus();
				return false;
			}	
			
			qfrm.action = "../qna/insertQues";
			qfrm.submit();
		})

		// Q & A 삭제
		$(".deleteQna").click(function() {
			var m_code = $(this).attr("m_code");
			var q_id = $(this).attr("q_id");
		

			if (confirm("삭제하시겠습니까?")) {
				$("#delQnaId").val(q_id);
				$("#delQnaCode").val(m_code);
			

				frmQna.action = "../qna/delete";
				$("#frmQna").submit();
			}
		});
		
		
});
</script>

<title>Insert title here</title>

<form role="form" method="post">
	<input type="hidden" name="p_id" value="${playDTO.p_id }">
</form>
<div class="container">
	<div class="row">
		<!-- 좌측 정보 -->
		<div class="col-md-5" style="float: left; position: relative; margin-right: 15px; background: #fff;">
			<!-- 이미지 -->
			<img src="${pageContext.request.contextPath}/resources/img/play/${playDTO.p_image1 }" style="width: 480px; padding: 10px 10px 7px 10px; outline: 1px solid #eee;">
			<!--  이미지 끝 -->

			<!-- 연극 제목 및 가격정보 -->
			<div>
				<!-- 제목 -->
				<div style="text-align: center; padding: 15px 10px; border-bottom:1px solid #eee">
					<span style="margin-left: 2px; font-size: 20px; font-weight: 500; color: #000;">${playDTO.p_name }</span>
				</div>
				<!-- 제목 끝 -->
			</div>
			<div id="ticket_div">
				<!-- 정가 가격  -->
				<div style="margin: 0 10px; padding: 15px 0 0px 0; font-size: 12px; font-weight: 300; color: #8b8b8b;"></div>
				<!-- 할인 가격 -->
				<div class="row" style="margin: 0 10px; font-size: 18px; color: #ed1c24; font-weight: 400;">
					<div style="float: left;">
						<span id="scheText"></span>
					</div>
					<div style="float: right;">
						<span id="schePrice"></span>
					</div>
				</div>

				<!-- 매수 선택 -->
				<div class="row" style="margin: 0 10px; padding: 10px 0px;">
					<div style="float: left">
						<button id="minus">
							<i class=" icon-minus"></i>
						</button>
						<input type="text" id="quantity" name="quantity" value="1" style="width: 30px;" min="1" />매
						<button id="plus">
							<i class=" icon-plus"></i>
						</button>
					</div>
					<div style="float: right;">
						<p>
							총 <span id="ticket"></span>매
						</p>
					</div>
				</div>
				<!-- 총 가격 -->
				<div style="margin: 0 10px; padding: 15px 0px; text-align: right; border-top: 1px solid #eee; font-size: 24px; color: #ed1c24;">
					<span id="totalCost"> </span><span> 원</span>

				</div>
				<!-- 총 가격 끝 -->
			</div>
			<!-- 연극 제목 및 가격 정보 끝 -->
		</div>
		<!--  좌측정보 끝 -->

		<!-- 우측 상단 정보영역 시작 / 일정 -->
		<div class="col-md-7" style="margin: 0px 10px; float: left; ">
			<!-- 달력 -->
			<jsp:include page="playcal.jsp" />
			
			<!-- 일정리스트 -->
			<c:if test="${login ne null}">
			<div id="schedule_div">
				<c:forEach items="${schedule }" var="list" varStatus="status">
					<c:set var="date"> 
						<fmt:formatDate value="${list.s_time }" pattern="yyyy/MM/dd a hh:mm"/> 
					</c:set>
					${date} - ${list.s_price } 원
					<button class="scheduleCho" date="${date}" value="${list.s_id }" price="${list.s_price }">선택</button>
					<br>
				</c:forEach>
			</div>
			</c:if>
		</div>
		<!-- 일정 끝 -->
	</div>
	<!-------- 우측 정보영역 끝 -------->
	<!-- divider -->
	<div class="row">
		<div class="solidline"></div>
	</div>
	<!-- end divider -->

	<!-- 중앙 정보 시작 -->
	<!-- 장바구니/결제 버튼 -->
	<div class="row" align="right">
		<div style="float: rigth;">
			<form name="frm" method="post">
				<input type="hidden" id="frmId" name="s_id" value="" />
				<input type="hidden" id="frmPid" name="p_id" value="${playDTO.p_id }" /> 
				<input type="hidden" id="sessionMcode"name="m_code" value="${login.m_code }" /> 
				<input type="hidden" id="frmPrice" name="p_price" value="" /> 
				<input type="hidden" id="frmQuantity" name="p_quantity" value="" />

				<button id="cart" type="submit" class="btn btn-success btn-lg">찜하기</button>
				<button id="charge" class="btn btn-primary btn-lg">구매하기</button>
			</form>
		</div>
	</div>
	<!-- 버튼 끝 -->

	<!-- 최근 리뷰 정보 시작 -->
	<div class="row">
		<div>
			<p style="font-size: 1.5em;">예매자 평점 ${reviewScore.avgscore } / 5.0 (${reviewScore.cnt }명)</p>
		</div>
		<div style="background-color: #FAF4C0; outline: 1px solid #eee;">
			<c:forEach items="${reviewList }" var="reviewList" begin="0" end="1">
				<div style="padding: 10px 10px; margin: 15px 25px; border-bottom: 1px solid #BDBDBD;">
					<p>
						<b>${reviewList.m_id }</b>(${reviewList.sdfTime })
					</p>
					<p>${reviewList.r_content }</p>
				</div>
			</c:forEach>
		</div>
	</div>
	<!-- 최근 리뷰 정보 끝 -->

	<!-- 탭정보 출력 -->
	<div class="row" style="align-content: center;">
		<ul class="nav nav-tabs">
			<li class="active"><a href="#one" data-toggle="tab" style="padding-left: 100px; padding-right: 100px;">
					<span style="font-size: 2em">안 내</span>
				</a></li>
			<li><a href="#two" id="review" data-toggle="tab" style="padding-left: 100px; padding-right: 100px;">후 기( ${reviewScore.cnt } 명)</a></li>
			<li><a href="#three" data-toggle="tab" style="padding-left: 100px; padding-right: 100px;">Q & A( ${qnacnt } 건)</a></li>
			<li><a href="#four" data-toggle="tab" style="padding-left: 100px; padding-right: 100px;">환불규정</a></li>
		</ul>
		<div class="tab-content">
			<div class="tab-pane active" id="one">
				<p>${playDTO.p_info }</p>
				<div style="text-align: center;">
				<c:if test="${playDTO.p_image2 ne null }">
					<img src="${pageContext.request.contextPath}/resources/img/play/${playDTO.p_image2 }" align="top" >
				</c:if>
				<c:if test="${playDTO.p_image3 ne null }">
					<img src="${pageContext.request.contextPath}/resources/img/play/${playDTO.p_image3 }" align="top" >
				</c:if>
				<c:if test="${playDTO.p_image4 ne null }">
					<img src="${pageContext.request.contextPath}/resources/img/play/${playDTO.p_image4 }" align="top" >
				</c:if>
				</div>
			</div>
			<!-- 리뷰 탭 -->
			<div class="tab-pane" id="two">
				<div align="center" style="padding: 20px; margin: 10px 30px; outline: 1px solid #eee; align-content: center;">
					<p>
						평균 <span style="font-size: 1.5em">${reviewScore.avgscore }</span> 점
					</p>
					
					<div class="rateit" style="margin-top: 10px;"
						data-rateit-value="${reviewScore.avgscore}" data-rateit-readonly="true" ></div>
					<p>실제 관람객들 후기입니다.</p>
				</div>
				<div id="reviews" style="margin: 10px 30px;">
					<c:forEach items="${reviewList}" var="list" varStatus="status">
						<div id="review_${status.index }" style="border-bottom: 1px solid #eee;">
							<div id="score_${status.index }" class="rateit" style="margin-top: 10px;"
							 data-rateit-value="${list.r_play_score}" data-rateit-readonly="true" ></div>
						
							<p id="content_${status.index }">${list.r_content }</p>
							<p>
								<span id="id_${status.index }">${list.m_id }</span> |  <span id="time_${status.index }" style="font-size: 0.5ex">(${list.sdfTime })</span>
							</p>
						</div>
					</c:forEach>
				</div>
				<script>
				// 리뷰 페이징 아작스
				function callPaging(page){
					
					var p_id = $(page).attr('p_id');
					var perPage = $(page).attr('perPage');
					var page = $(page).attr('page');
	
					$.ajax({
						type : 'post',
						dataType : 'json',
						url : 'reviewPage',
						data :{
							'p_id' : p_id,
							'page' : page ,
							'perPage' : perPage
						},
						success : function(data){
							var reviews = new Array();
							reviews = data;
							
							var cnt = data.length-1;
							//리뷰 바꿔넣기
							for(var i=0 ; i<=4 ; i++){
								$("#review_"+i).show();
								if(i-cnt > 0){
									$("#review_"+i).hide();	
								}
							}
								
							for(var i in reviews){
	
								var width=16*reviews[i].r_play_score;
							
								 $("#score_"+i).find(".rateit-selected").css("width",width+"px");
								//$("#review_"+i).prepend(score);
								$("#content_"+i).html(reviews[i].r_content);
								$("#id_"+i).html(reviews[i].m_id);
								$("#time_"+i).html(reviews[i].sdfTime);
								
							}
							
						}
					})
					
				}
				//Qna 페이징
				function callPaging2(page){ 
					
					var p_id = $(page).attr('p_id');
					var perPage = $(page).attr('perPage');
					var page = $(page).attr('page');
	
					$.ajax({
						type : 'post',
						dataType : 'json',
						url : 'qnaPage',
						data :{
							'p_id' : p_id,
							'page' : page ,
							'perPage' : perPage
						},
						success : function(data){
							var qlist = new Array();
							var alist = new Array();
							qlist = data.qlist;
							alist = data.alist;
							
							var qcnt = qlist.length-1;
							
							//값 숨기기
							for(var i=0 ; i<=4 ; i++){
								$("#q_div_"+i).show();
								if(i-qcnt > 0){
									$("#q_div_"+i).hide();	
								}
							}
							$(".qna_answer").remove();
							//값 변경하기
							for(var i in qlist){
								
								$("#q_id_"+i).html(qlist[i].m_id);
								$("#q_time_"+i).html(qlist[i].sdfTime);
								$("#q_del_"+i).attr("q_id",qlist[i].q_id);
								$("#q_del_"+i).attr("m_code",qlist[i].m_code);;
								$("#q_con_"+i).html(qlist[i].q_content);
								
								for(var j in alist){
									if(qlist[i].q_id == alist[j].q_target_id){
										var a_div = "<div class='qna_answer'><p style='font-weight: bold;'> "+alist[j].m_id + " | "+alist[j].sdfTime+"<a class='deleteQna' q_id='"+alist[j].q_id + "'m_code='"+ alist[j].m_code+"'> <i class='icon-remove-circle'></i></a></p><p>"+ alist[j].q_content+"</p></div>";
										
										$("#q_div_"+i).after(a_div);
									}
								}
							} 
						}
					})
				}
				</script>
				<div class="pagination pagination-large pagination-centered">
				  	<ul class="pagination">
						<c:forEach var="pageNum" begin="${paging.startPage}" end="${paging.endPage}">
							<li><a href="javascript:void(0);" onclick="callPaging(this)" p_id="${playDTO.p_id }" page="${pageNum}" perPage="${paging.pdto.perPage}"><span>${pageNum}</span></a></li>
						</c:forEach>
					</ul>
				</div><!-- /.pagination -->
			</div>
			<!-- 리뷰 탭 종료 -->
			<!-- Q & A 탭 -->
			<div class="tab-pane" id="three">
				<div style="margin: 20px;">
					<!-- 질문 작성 -->
					<p>연극에 대한 궁금증을 남겨주세요!</p>
					<div style="background-color: #FAF4C0;">
						<form id="qfrm" method="post">
							<textarea id="q_content" name="q_content" style="margin: 10px 30px 10px 10px; height: 100px; width: 80%;" required="required" placeholder="내용을 입력해주세요(5 ~ 100자)"></textarea>
							<span>0</span>/100
							<input type="hidden" name="p_id" value="${playDTO.p_id }" />
							<input type="hidden" name="m_code" value="${login.m_code }" />
							<button type="button" id="qsubmit">등 록</button>
						</form>
					</div>
					

								
					<!-- 다른 질문 보기 -->
					<div style="margin: 70px 0 0 0;">
						<c:forEach items="${qnalist.qlist}" var="list" varStatus="status">
							<div id="q_div_${status.index }" class="qna_question">
								<p style="font-weight: bold;"><span id="q_id_${status.index }"> ${list.m_id }</span> | <span id="q_time_${status.index }"> ${list.sdfTime} </span>
									<a class="deleteQna" id="q_del_${status.index }" q_id="${list.q_id }" m_code="${list.m_code}">
										<i class="icon-remove-circle"></i>
									</a>
								</p>
								<p id="q_con_${status.index }">${list.q_content }</p>
							</div>
							<c:forEach items="${qnalist.alist}" var="list2">
								<c:if test="${list.q_id eq list2.q_target_id}">
									<div class="qna_answer">
										<p style="font-weight: bold;">${list2.m_id } | ${list2.sdfTime}
											<a class="deleteQna" q_id="${list2.q_id }" m_code="${list2.m_code}">
												<i class="icon-remove-circle"></i>
											</a>
										</p>
										<p>${list2.q_content }</p>
									</div>
								</c:if>
							</c:forEach>
						</c:forEach>
						<div class="pagination pagination-large pagination-centered">
						  	<ul class="pagination">
								<c:forEach var="pageNum" begin="${paging2.startPage}" end="${paging2.endPage}">
									<li><a href="javascript:void(0);" onclick="callPaging2(this)" p_id="${playDTO.p_id }" page="${pageNum}" perPage="${paging2.pdto.perPage}"><span>${pageNum}</span></a></li>
								</c:forEach>
							</ul>
						</div><!-- /.pagination -->
						<!-- 데이터 넘기기위한 폼 -->
						<form id="frmQna">
							<input type="hidden" id="delQnaId" name="q_id" value="" /> 
							<input type="hidden" id="delQnaCode" name="m_code" value="" /> 
							<input type="hidden" id="delQnaPid" name="p_id" value="${playDTO.p_id }" />
						</form>
					</div>
				</div>
			</div>
			<!-- Q & A 탭 종료 -->
			<!--  환불정책 탭 -->
			<div class="tab-pane" id="four">
				<p>${playDTO.p_refund_policy }</p>
			</div>
			<!--  환불정책 종료 -->
		</div>
		<!-- 탭 종료 -->
	</div>
	<!-- 중앙정보 종료 -->
</div>
<!-- 끝 -->

<jsp:include page="../page/footer.jsp" />