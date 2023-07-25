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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
	integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<title>Hello, world!</title>
</head>
<body>
	<section class="row">
		<div class="col mt-4">
			<div class="card">
				<div class="card-header">List Movie</div>
				<div class="card-body">
					<!-- Hiển thị thông báo -->
					<c:if test="${message != null}">
						<div class="alert alert-primary" role="alert">
							<i>${message}</i>
						</div>
					</c:if>
					<!-- Hết thông báo -->
					<!-- Search -->
					<div class="row mt-2 mb-2">
						<div class="col-md-6">
							<form action="/admin/movies/searchpagenated">
								<div class="input-group">
									<input type="text" class="form-control ml-2" name="name"
										id="name" placeholder="Nhập từ khóa để tìm kiếm" value="${param.name}"/>
									<button class="btn btn-outline-primary ml-2">Search</button>
								</div>
							</form>
						</div>

						<div class="col-md-6">
							<div class="float-right">
								<a class="btn btn-outline-success" href="/admin/movies/add">Add
									New Movie</a>
							</div>
						</div>
					</div>

					<c:if test="${!moviePage.hasContent()}">
						<div class="row">
							<div class="col">
								<div class="alert alert-danger">Khong tim thay movie</div>
							</div>
						</div>
					</c:if>

					<!-- List -->
					<c:if test="${moviePage.hasContent()}">
						<table class="table table-striped table-responsive">
							<thead class="thead-inverse">
								<tr>
									<th>Movie ID</th>
									<th>Movie Name</th>
									<th>Genre</th>
									<th>Actor</th>
									<th>Director</th>
									<th>Country</th>
									<th>Score</th>
									<th>Released</th>
									<th>Image</th>
									<th>Runtime</th>
									<th>Description</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${moviePage.content}" var="movie">
									<tr>
										<td scope="row">${movie.movieId}</td>
										<td>${movie.moviename}</td>
										<td>${movie.genres}</td>
										<td>${movie.actor}</td>
										<td>${movie.director}</td>
										<td>${movie.country}</td>
										<td>${movie.score}</td>
										<td>${movie.released}</td>
										<td>${movie.images}</td>
										<td>${movie.runtime}</td>
										<td>${movie.description}</td>
										<td><a href="/admin/movies/view/${movie.movieId}"
											class="btn btn-outline-info"> <i class="fa fa-info"></i></a>
											<a href="/admin/movies/edit/ ${movie.movieId}"
											class="btn btn-outline-warning"><i class="fa fa-edit"></i></a>
											<a 
											data-id="${movie.movieId}" 
											data-name="${movie.moviename}"
											onclick="showconfirmation(this.getAttribute('data-id'),this.getAttribute('data-name'))"
											class="btn btn-outline-danger"><i class="fa fa-trash"></i></a>
										</td>
									</tr>
								</c:forEach>

							</tbody>
						</table>
					</c:if>


					<script type="text/javascript">
						function showconfirmation(id, name) {
							$('#movieName').text(name);
							$('#yesOption').attr('href',
									'/admin/movies/delete/' + id);
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
									Ban co muon xoa "<span id="movieName"></span>"?
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

					<div class="row">
						<div class="col-5">
							<form action="">
								<div class="mb-3 input-group float-left">
									<label for="size" class="mr-2">Page size:</label> <select
										class="form-select ml-2" name="size" id="size"
										aria-label="size" onchange="this.form.submit()">
										<option ${moviePage.size == 3 ? 'selected':''} value="3">3</option>
										<option ${moviePage.size == 5 ? 'selected':''} value="5">5</option>
										<option ${moviePage.size == 10 ? 'selected':''} value="10">10</option>
										<option ${moviePage.size == 15 ? 'selected':''} value="15">15</option>
										<option ${moviePage.size == 20 ? 'selected':''} value="20">20</option>
									</select>
								</div>
							</form>

						</div>

						<div class="col-7">
							<!-- Phân trang -->
							<c:if test="${moviePage.totalPages > 0 }">
								<nav aria-label="Page navigation">
									<ul class="pagination">
										<li class="${1==moviePage.number + 1? 'page-item active': 'page-item'}">
											<a class="page-link"
											href="<c:url value='/admin/movies/searchpagenated?name=${param.name}&size=${moviePage.size}&page=${1 }'/>"
											tabindex="-1">First</a>
										</li>
										<c:forEach items="${pageNumbers }" var="pageNumber">
											<c:if test="${moviePage.totalPages > 1 }">
												<li class="${pageNumber == moviePage.number +1 ? 'page-item active' : 'page-item' }">
													<a class="page-link"
													href="<c:url value='/admin/movies/searchpagenated?name=${param.name}&size=${moviePage.size}&page=${pageNumber }'/>">${pageNumber }</a>
												</li>
											</c:if>
										</c:forEach>
										<li
											class="${moviePage.totalPages == moviePage.number + 1 ? 'page-item active': 'page-item' }">
											<a
											href="<c:url value='/admin/movies/searchpagenated?name=${param.name}&size=${moviePage.size}&page=${moviePage.totalPages }'/>"
											class="page-link">Last</a>
										</li>

									</ul>
								</nav>
							</c:if>
							<!-- Kết thúc phân trang -->
						</div>
					</div>


				</div>
			</div>
		</div>
	</section>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>
</body>
</html>