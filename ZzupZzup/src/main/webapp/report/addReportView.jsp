<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>

</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	
</script>


<!-- Modal -->
<div class="modal fade" id="reportModal" tabindex="-1" role="dialog"
	aria-labelledby="reportModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h3 class="modal-title" id="reportModalLabel">신고하기</h3>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="col-sm-12 review-modal-top">
					<span id="reviewRegDate"></span>
					<c:if test="${member.memberRole == 'admin'}">
						<i class="fa fa-exclamation-triangle" id="reportCount" aria-hidden="true">
						</i>
					</c:if>
				</div>
				<!-- <img class="mb-4" src="../assets/brand/bootstrap-solid.svg" alt="" width="72" height="72"> -->
				<h5 class="h6 mb-12 font-weight-normal">
					<span id="memberRank"></span> <span id="nickname"></span> 
				</h5>
				
				<br/>
				
				<div class="bd-example">
					<div id="carouselExampleIndicators" class="carousel slide carousel-fade" data-ride="carousel">
						
						 <div class="carousel-inner" id="reviewImage">
							<!-- 이미지 보여지는 곳 -->
						</div> 
						<a class="carousel-control-prev" data-target="#carouselExampleIndicators" data-slide="prev">
							<span class="carousel-control-prev-icon" aria-hidden="true"></span>
							<span class="sr-only">Previous</span>
						</a> 
						<a class="carousel-control-next" data-target="#carouselExampleIndicators" data-slide="next">
							<span class="carousel-control-next-icon" aria-hidden="true"></span>
							<span class="sr-only">Next</span>
						</a>
					</div>
				</div>  
					
				<br/>
					
				<div class="row starBox">
					<div class="col-md-4">
						<label for="scopeClean" class="label star_label">청결해요</label>
						<p id="scopeClean" class="star_p"></p>
					</div>
					<div class="col-md-4">
						<label for="scopeTaste" class="label star_label">맛있어요</label>
						<p id="scopeTaste" class="star_p"></p>
					</div>
					<div class="col-md-4">
						<label for="scopeKind" class="label star_label">친절해요</label> 
						<p id="scopeKind" class="star_p"></p>
					</div>
				</div>
				
				<br/>
				
				<label for="reviewDetail">어떤 점이 좋았나요?</label>
				<p id="reviewDetail"></p>
				
				<br/>
				
				<label for="hashTag">해시태그</label>
				<div class="box" id="hashtagBox" >
				</div>
				
				<div class="bottom-like">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" id="reviewLike" class="bi bi-heart-fill reviewLike" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/></svg>
					<span class="reviewCount" id="reviewCount"></span>
					<input type="hidden" name="reviewNo" value="">
				</div>
				
			</div>
			<div class="footerBox">
			</div>
			<%-- <c:if test="${!empty member}">
				<div class="modal-footer">
			        <input type="button" class="normal" id="reviewDelete" value="삭제"></input>
			        <input type="button" class="primary" id="reviewUpdate" value="수정"></input>
			    </div>
			</c:if> --%>
		</div>
	</div>
</div>