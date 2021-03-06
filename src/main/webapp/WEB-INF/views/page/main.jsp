<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<jsp:include page="header.jsp"></jsp:include>
<%@ page import="java.util.*, java.text.*"%>
<div id="wrapper">
	<!-- end header -->
	<section id="featured">
		<!-- start slider -->
		<!-- Slider -->
		<div id="nivo-slider">
			<div class="nivo-slider">
				<!-- Slide #1 image -->
				<img src="${pageContext.request.contextPath}/resources/img/slides/nivo/bg-1.jpg" alt="" title="#caption-1" />
				<!-- Slide #2 image -->
				<img src="${pageContext.request.contextPath}/resources/img/slides/nivo/bg-2.jpg" alt="" title="#caption-2" />
				<!-- Slide #3 image -->
				<img src="${pageContext.request.contextPath}/resources/img/slides/nivo/bg-3.jpg" alt="" title="#caption-3" />
			</div>
			<div class="container">
				<div class="row">
					<div class="span12">
						<!-- Slide #1 caption -->
						<div class="nivo-caption" id="caption-1">
							<div>
								<h2>
									여기에는<strong>뭘쓸까요!</strong>
								</h2>
								<p>써야하는 내용이 뭐가될지 궁금함!</p>
								<a href="${pageContext.request.contextPath}/play/mainlist" class="btn btn-theme">지금 알아보기!</a>
							</div>
						</div>
						<!-- Slide #2 caption -->
						<div class="nivo-caption" id="caption-2">
							<div>
								<h2>
									쌀쌀한 날씨에 맞는<strong>연극추천!</strong>
								</h2>
								<p>계절에 맞는 연극으로 따뜻한 감성 느끼시길 바랄게요!</p>
								<a href="${pageContext.request.contextPath}/play/mainlist" class="btn btn-theme">지금 알아보기!</a>
							</div>
						</div>
						<!-- Slide #3 caption -->
						<div class="nivo-caption" id="caption-3">
							<div>
								<h2>
									<strong>타임 특가</strong>프로모션!
								</h2>
								<p>타임 세일 최저가 티켓! 오직 연극어때에서만!</p>
								<a href="${pageContext.request.contextPath}/play/mainlist" class="btn btn-theme">지금 알아보기!</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- end slider -->
	</section>
	<section class="callaction">
		<div class="container">
			<div class="row">
				<div class="span12">
					<div class="big-cta">
						<div class="cta-text">
							<h3>
								<strong>오늘, 내일 티켓 예매</strong>로 보다 저렴하게!
							</h3>
						</div>
						<div class="cta floatright">
							<a class="btn btn-large btn-theme btn-rounded" href="${pageContext.request.contextPath}/play/mainlist">> 예매하러 가기 </a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<section id="content">
		<div class="container">
			<div class="row">
				<div class="span12">
					<div class="row">
						<%
							Date date = new Date();
							SimpleDateFormat simpleDate = new SimpleDateFormat("MM-dd");
							String strdate = simpleDate.format(date);
							Calendar cal = Calendar.getInstance();
						%>
						<div class="span6">
							<div class="box aligncenter">
								<div class="aligncenter icon">
									<i class="icon-briefcase icon-circled icon-64 active"></i>
								</div>
								<div class="text">
									<h3>
										<strong>오늘 티켓(<%=cal.get(Calendar.MONTH) + 1%>/<%=cal.get(Calendar.DATE)%>)
										</strong>
									</h3>
									<p>
										오늘 당장 저렴하게 이용할 수 있는<br>
									</p>
									<p>마감 임박 할인 오늘 티켓</p>
									<a href="${pageContext.request.contextPath}/play/todaylist">예매하러 가기</a>
								</div>
							</div>
						</div>
						<div class="span6">
							<div class="box aligncenter">
								<div class="aligncenter icon">
									<i class="icon-desktop icon-circled icon-64 active"></i>
								</div>
								<div class="text">
									<h3>
										<strong>내일 티켓(<%=cal.get(Calendar.MONTH) + 1%>/<%=cal.get(Calendar.DATE) + 1%>)
										</strong>
									</h3>
									<p>
										한정된 기간, 한정된 수량으로 판매되는<br>
									</p>
									<p>우주 최저가 타임 세일 티켓</p>
									<a href="${pageContext.request.contextPath}/play/tomorrowlist">예매하러 가기</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- divider -->
			<div class="row">
				<div class="span12">
					<div class="solidline"></div>
				</div>
			</div>
			<!-- end divider -->
			<div class="row">
				<div class="span12">
					<h4>예매 순위 Best 10</h4>
					<section id="projects">
						<ul id="thumbs" class="portfolio">
							<c:forEach items="${list}" var="li" varStatus="status">
								<li style="width: 200px; " class="item-thumbs span3 design" data-id="id-0" data-type="graphic"><a class="hover-wrap fancybox" data-fancybox-group="gallery" href="${pageContext.request.contextPath}/play/playdetail?p_id=${li.p_id }">
										<span class="overlay-img"></span> <span class="overlay-img-thumb font-icon-plus"></span>
									</a> <img src="${pageContext.request.contextPath}/resources/img/play/thumb_${li.p_image0 }">
									<div>
										<p>

											<a href="playdetail?p_id=${li.p_id }">${li.p_name }</a>
										</p>
										<p style="float: left; font-style: italic;">최저 가격</p>
										<p align="right">
											<span style="font-size: 20px; color: #FF5E00">${li.lowest_price}</span> 원 ~
										</p>
									</div></li>
							</c:forEach>
						</ul>
					</section>
				</div>
			</div>
		</div>
</div>
<jsp:include page="footer.jsp"></jsp:include>