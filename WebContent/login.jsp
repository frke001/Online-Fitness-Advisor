<%@page import="beans.AdvisorQuestionBean"%>
<%@page import="dto.AdvisorDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="advisorBean" class="beans.AdvisorBean" scope="session"></jsp:useBean>

<!DOCTYPE html>

	<%
		if(request.getParameter("submit") != null){
			
			if(request.getParameter("username") != null && request.getParameter("password") != null){
				
				if(advisorBean.login(request.getParameter("username"), request.getParameter("password"))){
					session.setAttribute("notification", "");
					AdvisorQuestionBean advisorQuestionBean = new AdvisorQuestionBean();
					session.setAttribute("questionBean", advisorQuestionBean);
					response.sendRedirect("messages.jsp");
				}else{
					session.setAttribute("notification", "Incorrect credentials.");
				}
			}
		}
	%>
<html>
<head>
<meta charset="UTF-8" name="viewport"
	content="width=device-width, initial-scale=1">
<title>Login</title>
<link href="styles/login.css" rel="stylesheet">
<link href="bootstrap-5.3.2-dist/css/bootstrap.min.css" rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous">
<script src="bootstrap-5.3.2-dist/js/bootstrap.bundle.min.js"
	integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
	crossorigin="anonymous"></script>
</head>
<body class="bg-light">

	<div
		class="container d-flex align-items-center justify-content-center min-vh-100">
		<div class="row">
			<div class="col-sm-12 col-md-12 col-lg-5 col-xl-5 ">
				<div class="card">
				
					<div class="card-body d-flex justify-content-center">
						<h2 class="card-title text-center mb-5 fw-semibold">Login</h2>
						<h4 class="text-center fw-semibold">Welcome back!</h4>
						<h6 class="text-center mb-5 fw-semibold">To keep connected with us please login with your personal info.</h6>

						<form method="post" action="login.jsp"
							class="needs-validation" novalidate>
							<div class="mb-3">
								<label for="username" class="form-label">Username</label>

								<div class="input-group has-validation">
									<span class="input-group-text" id="inputGroupPrepend"><img
										src="images/username.png"></span> <input type="text"
										class="form-control rounded-end shadow" id="username"
										name="username" placeholder="Enter username" required>
									<div class="invalid-feedback">Please insert username.</div>
									
								</div>
							</div>
							<div class="mb-3">
								<label for="password" class="form-label">Password</label>
								<div class="input-group has-validation">

									<span class="input-group-text" id="inputGroupPrepend"><img
										src="images/password.png"></span> <input type="password"
										class="form-control rounded-end shadow" id="password"
										name="password" placeholder="Enter password" required>
									<div class="invalid-feedback">Please insert password.</div>
									
								</div>
							</div>
							<div>
								<button type="submit" class="btn btn-primary shadow login-btn fw-semibold w-100" name="submit" >Login</button>
							</div>
							<br><br>
							<h3><span class="badge text-danger"><%=session.getAttribute("notification") != null ? session.getAttribute("notification").toString() : ""%></span></h3>
						</form>

					</div>
				</div>
			</div>

			<!-- Slika na drugoj polovini -->
			<div class="col-sm-12 col-md-12 col-lg-7 col-xl-7">
				<img src="images/loginImage.jpg" alt="Image" class="img-fluid">
			</div>
		</div>
	</div>
	  <script>
	 const forms = document.querySelectorAll('.needs-validation')

	  // Loop over them and prevent submission
	  Array.from(forms).forEach(form => {
	    form.addEventListener('submit', event => {
	      if (!form.checkValidity()) {
	        event.preventDefault()
	        event.stopPropagation()
	      }

	      form.classList.add('was-validated')
	    }, false);
	  });
	</script>
</body>
</html>