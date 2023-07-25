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
			<form action="<c:url value="/admin/movies/saveOrUpdate" />" method="POST">
				<div class="card">
					<div class="card-header">
						<h2>${movie.isEdit ? 'Edit Movie' :'Add New Movie'}</h2>
					</div>
					<div class="card-body">
						<div class="mb-3">
							<label for="movieId" class="form-label">Movie Id</label>
							<input type="hidden" value="${movie.isEdit }">
							<input type="text" readonly="readonly" class="form-control" value="${movie.movieId }" id="movieId" name="movieId"
							aria-describedby="movieIdid" placeholder="Movie Id">
						</div>
						<div class="mb-3">
							<label for="moviename" class="form-label">Movie Name</label>
							<input type="text" class="form-control" value="${movie.moviename }" id="moviename" name="moviename"
							aria-describedby="nameid" placeholder="Movie Name">
						</div>
						
						<div class="mb-3">
							<label for="genres" class="form-label">Genres</label>
							<input type="text" class="form-control" value="${movie.genres }" id="genres" name="genres"
							aria-describedby="genreid" placeholder="Genres">
						</div>
						
						<div class="mb-3">
							<label for="actor" class="form-label">Actor</label>
							<input type="text" class="form-control" value="${movie.actor }" id="actor" name="actor"
							aria-describedby="actorid" placeholder="Actor">
						</div>
						
						<div class="mb-3">
							<label for="director" class="form-label">Director</label>
							<input type="text" class="form-control" value="${movie.director }" id="director" name="director"
							aria-describedby="directorid" placeholder="Director">
						</div>
						
						<div class="mb-3">
							<label for="country" class="form-label">Country</label>
							<input type="text" class="form-control" value="${movie.country }" id="country" name="country"
							aria-describedby="countryid" placeholder="Country">
						</div>
						
						<div class="mb-3">
							<label for="score" class="form-label">Score</label>
							<input type="text" class="form-control" value="${movie.score }" id="score" name="score"
							aria-describedby="scoreid" placeholder="Score">
						</div>
						
						<div class="mb-3">
							<label for="released" class="form-label">Released</label>
							<input type="text" class="form-control" value="${movie.released }" id="released" name="released"
							aria-describedby="releasedid" placeholder="Released">
						</div>
						
						<div class="mb-3">
							<label for="runtime" class="form-label">Runtime</label>
							<input type="text" class="form-control" value="${movie.runtime }" id="runtime" name="runtime"
							aria-describedby="runtimeid" placeholder="Runtime">
						</div>
						
						<div class="mb-3">
							<label for="description" class="form-label">Description</label>
							<input type="text" class="form-control" value="${movie.description }" id="description" name="description"
							aria-describedby="descriptionid" placeholder="Description">
						</div>
						
					</div>
				</div>
				<div class="card-footer text-muted">
					<a href="<c:url value="/admin/movies/add" />" class="btn btn-secondary"><i class="fas fa-new"></i>New</a>
					<a href="<c:url value="/admin/movies" />" class="btn btn-success"><i class="fas fa-bars"></i>List Movies</a>
					<button class="btn btn-primary" type="submit"><i class="fas fa-save"></i></button>
					<c:if test="${movie.isEdit}">
					<span>Update</span>
					</c:if>
					<c:if test="${!movie.isEdit}">
					<span>Save</span>
					</c:if>
				</div>
				
			</form>
		</div>
	</section>
	
</body>
</html>