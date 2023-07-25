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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<title>Hello, world!</title>
</head>
<body>
	<section class="row">
		<div class="col mt-4">
			<div class="card">
				<div class="card-header">List Video</div>
				<div class="card-body">
					<!-- Hiển thị thông báo -->
					<c:if test="${message != null}">
						<div class="alert alert-primary" role="alert">
							<i>${message}</i>
						</div>
					</c:if>
					<!-- Hết thông báo -->
					<table class="table table-striped table-responsive">
						<thead class="thead-inverse">
							<tr>
								<th>&npsb;</th>
								<th>Poster</th>
								<th>Video Name</th>
								<th>Views</th>
								<th>Status</th>
								<th>Movie Name</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${videos}" var="video">
								<tr>
									<td><input type="checkbox" class="form-check-input" /></td>
									<td>
										<c:if test="${video.poster !=null}">
											<img src="/admin/videos/images/${video.poster }" width="70" class="img-fuild" alt="" />
										</c:if>
										<c:if test="${video.poster==null}">
											<img src="/templates/images/noimage.jpg" width="70" class="img-fluid" alt="" />
										</c:if>
									</td>
									<td>${video.title}</td>
									<td>${video.views}</td>
									<td>${video.active}</td>
									<td>${video.movie.moviename}</td>
									<td><a href="/admin/videos/view/${video.videoId}"
										class="btn btn-outline-info"> <i class="fa fa-info"></i></a> <a
										href="/admin/videos/edit/${video.videoId}"
										class="btn btn-outline-warning"><i class="fa fa-edit"></i></a>
										<a 
											data-id="${video.videoId}" 
											data-name="${video.title}"
											onclick="showconfirmation(this.getAttribute('data-id'),this.getAttribute('data-name'))"
											class="btn btn-outline-danger"><i class="fa fa-trash"></i></a>
									</td>
								</tr>
							</c:forEach>

						</tbody>
					</table>
					
					<script type="text/javascript">
						function showconfirmation(id, name) {
							$('#videoTitle').text(name);
							$('#yesOption').attr('href',
									'/admin/videos/delete/' + id);
							$('#confirmationId').modal('show');
						}
					</script>	
					
					<!-- Modal -->

					<div class="modal fade" id="confirmationId" tabindex="-1"
						aria-labelledby="confirmationLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="confirmationLabel">Confirmation</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body">
									Ban co muon xoa "<span id="videoTitle"></span>"?
								</div>
								<div class="modal-footer">
									<a id="yesOption" class="btn btn-primary">Yes</a>
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">Close</button>
								</div>
							</div>
						</div>
					</div>
					<!-- End Modal -->
				</div>
			</div>
		</div>
	</section>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>
</body>
</html>