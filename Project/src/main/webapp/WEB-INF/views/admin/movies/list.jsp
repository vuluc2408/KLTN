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
				<div class="card-header">List Movie</div>
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
							<c:forEach items="${movies}" var="movie">
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
										class="btn btn-outline-info"> <i class="fa fa-info"></i></a> <a
										href="/admin/movies/edit/ ${movie.movieId}"
										class="btn btn-outline-warning"><i class="fa fa-edit"></i></a>
										<a href="/admin/movies/delete/ ${movie.movieId}"
										class="btn btn-outline-danger"><i class="fa fa-trash"></i></a>
									</td>
								</tr>
							</c:forEach>

						</tbody>
					</table>
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