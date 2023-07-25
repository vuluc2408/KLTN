
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">

<title>Hello, world!</title>
</head>
<body>
	<section class="row">
		<div class="col-6 offset-3 mt-4">
			<form action="<c:url value="/admin/videos/saveOrUpdate" />"
				method="POST" enctype="multipart/form-data">
				<div class="card">
					<div class="card-header">
						<h2>${video.isEdit ? 'Edit Video' :'Add New Video'}</h2>
					</div>
					<div class="card-body">
					<div class="row">
							<div class="col-7">
								<c:if test="${video.isEdit}">
									<div class="mb-3">
										<label for="videoId" class="form-label">video ID:</label> 
										<input
											type="text" ${video.isEdit ? 'readonly' : ''}
											class="form-control" value="${video.videoId }" id="videoId"
											name="videoId" aria-describedby="videoIdid"
											placeholder="Video Id">
									</div>
								</c:if>

								<div class="mb-3">
									<label for="moviename" class="form-label">Video Name</label> <input
										type="text" class="form-control" value="${video.title }"
										id="title" name="title" aria-describedby="titleid"
										placeholder="Title">
								</div>
								
								<div class="mb-3">
								<label for="MovieId">Movie</label>
								<select class="form-select" name="movieId" id="movieId" aria-label="movieId">
								<c:forEach items="${movies }" var="item">
								<option value="${item.movieId }" select="${item.movieId == video.movieId? 'selected' :'' }">${item.moviename }</option>
								</c:forEach>
								</select>
								
								</div>
								<div class="mb-3">
									<label for="description" class="form-label">Description:</label>
									<textarea class="form-control" id="description"
										name="description" rows="5">${video.description }</textarea>
								</div>
							</div>

							<div class="col-5">
								<div class="row">
									<script type="text/javascript">
										function chooseFile(fileInput) {
											if (fileInput.files
													&& fileInput.files[0]) {
												var reader = new FileReader();
												reader.onload = function(e) {
													$('#images').attr('src',
															e.target.resutl);
												}
												reader.readAsDataURL(fileInput.files[0])
											}
										}
									</script>
									<c:if test="${video.poster != null }">
										<img src="/admin/videos/images/${video.poster}" id="images"
											style="width: 60px" class="img-fuild rounded border" alt="" />
									</c:if>
									<c:if test="${video.poster == null }">
										<img src="/templates/images/noimage.jpg" id="images"
											style="width: 60px" class="img-fuild rounded border" alt="" />
									</c:if>
									<br />
									<div class="mb-3">
										<label for="imageFile" class="form-label">Image File:</label>
										<input type="file" class="form-control-file"
											value="${video.imageFile }" id="imageFile" name="imageFile"
											aria-describedy="imageFile" placehoder="video Image"
											onchange="chooseFile(this)" accept=".jpg, .png" />
									</div>
								</div>

								<div class="row">
									<div class="mb-3">
										<label for="active">active</label> <select class="form-select"
											aria-label="active" name="active" id="active">
											<option ${video.active == true ? 'select':'' } value="1">On
												Sale</option>
											<option ${video.active == false ? 'select':'' } value="1">Out
												of Stock</option>
											<option></option>
										</select>
									</div>
								</div>
							</div>
						</div>
						<div class="card-footer text-muted">
							<div class="row">
								<div class="col-9 float-left">
									<a href="<c:url value="/admin/videos/add" />"
										class="btn btn-secondary"><i class="fas fa-new"></i>New</a>
									<button class="btn btn-primary" type="submit">
										<i class="fas fa-save"></i>
										
									<c:if test="${video.isEdit}">
										<span>Update</span>
									</c:if>
									<c:if test="${!video.isEdit}">
										<span>Save</span>
									</c:if>
									</button>
								</div>
								<div class="col-3 float-right">
								<a href="/admin/videos/searchpagenated" class="btn btn-success"><i class="fas fa-bars">List videos</i></a>
								<c:if test="${video.isEdit }">
									<a href="/admin/videos/delete/${video.videoId }" class="btn btn-danger float-right"><i class="fas fa-bars">Delete</i></a>
								</c:if>
								</div>
							</div>

						</div>
			</form>
		</div>
	</section>

</body>
</html>