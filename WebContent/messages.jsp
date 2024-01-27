<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="dto.AdvisorQuestionDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="advisorBean" class="beans.AdvisorBean" scope="session"></jsp:useBean>
<jsp:useBean id="questionBean" class="beans.AdvisorQuestionBean"
	scope="session"></jsp:useBean>
<%
List<AdvisorQuestionDTO> questions = new ArrayList();

if (!(advisorBean.isLoggedIn())) {
	response.sendRedirect("login.jsp");
}
session.removeAttribute("readId");
String action = request.getParameter("action");
if (action == null || "".equals(action)) {

	questions = questionBean.getAll();
} else if (action.equals("search")) {

	if (request.getParameter("searchText") != null || !"".equals(request.getParameter("searchText"))) {

		questions = questionBean.getAllByContent(request.getParameter("searchText"));
		session.setAttribute("searchTerm", request.getParameter("searchText"));
	} else {
		questions = questionBean.getAll();
	}
} else if (action.equals("read")) {
	
	if (request.getParameter("id") != null || !"".equals(request.getParameter("id"))) {
		Long id = Long.parseLong(request.getParameter("id"));
		
		if(questionBean.readMessage(id)){
			session.setAttribute("readId", id);	
			questions = questionBean.getAll();
			session.setAttribute("readSuccess", "true");
		}else{
			session.setAttribute("readUnsuccess", "true");
		}
	}
}else if (action.equals("sentMail")) {
	session.setAttribute("readSuccess", "true");
	questions = questionBean.getAll();
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport"
	content="width=device-width, initial-scale=1">
<title>Messages</title>
<link href="bootstrap-5.3.2-dist/css/bootstrap.min.css" rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous">
<script src="bootstrap-5.3.2-dist/js/bootstrap.bundle.min.js"
	integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
	crossorigin="anonymous"></script>
<link href="styles/messages.css" rel="stylesheet">
<link href="styles/navbar.css" rel="stylesheet">
<script type="text/javascript">
	function readMess(id) {
		window.location.href = "messages.jsp?action=read&id=" + id;
	}
</script>
</head>
</head>
<body class="bg-secondary">
	<jsp:include page="navbar.jsp"></jsp:include>
	<div class="p-4">
		<p class="fw-semibold text-white fs-2">Client messages</p>
	</div>
	<div class="container-fluid">

		<div class="custom-scrollbar mt-1">
			<div class="container">
				<div class="row d-flex justify-content-center">
					<div class="col-sm-12 col-md-7">
						<form method="post" action="messages.jsp?action=search">
							<div class="input-group mb-1">
								<span class="input-group-text rounded-start" id="basic-addon1"><img
									src="images/search.png"></span> <input type="text"
									name="searchText" class="form-control fw-semibold"
									placeholder="Search by message content" aria-label="Username"
									aria-describedby="basic-addon1"
									value="<%="search".equals(action)? session.getAttribute("searchTerm"):"" %>">
								<button class="btn bg-success text-white fw-semibold"
									type="submit" id="button-addon2">Search</button>

							</div>
						</form>
					</div>
				</div>
				<hr class="mb-4">
				<%
				for (AdvisorQuestionDTO q : questions) {
				%>
				<div class="card mb-4">
					<div class="card-header fw-semibold text-white">
						<div class="d-flex justify-content-between align-items-center">
							<div class="d-flex align-items-center gap-2">
								<div class="avatar">
									<%
									if (q.getClientSenderProfileId() != null && q.getClientSenderProfileId() != 0) {
									%>
									<img
										src="http://localhost:9000/api/v1/image/<%=q.getClientSenderProfileId()%>"
										alt="slika" class="profile rounde-pill">
									<%
									} else {
									%>
									<img src="images/defaultProfile.png" alt="slika"
										class="profile rounde-pill">
									<%
									}
									%>
								</div>
								<p class="fw-semibold fs-6 m-0"><%=q.getClientSenderUsername()%></p>
							</div>
							<div>
								<a href="reply.jsp?id=<%= q.getId() %>"
									class="btn btn-success fs-6 fw-semibold d-flex align-items-center"><img
									src="images/reply.png">&nbsp;Reply</a>
							</div>
						</div>
					</div>
					<div class="card-body pt-1">
						<div class="fp-title d-flex justify-content-between">
							<p class="m-0 mb-2 fs-6 fw-semibold badge bg-info"><%=q.getFitnessProgramName()%></p>
							<p class="m-0 mb-2 fs-6 fw-semibold badge bg-info"><%=new SimpleDateFormat("dd MMM, yyy").format(q.getCreationDate())%></p>
						</div>
						<div class="d-flex justify-content-center">
							<a  <%= q.getIsRead()? "" : "onclick=\"readMess(" + q.getId() + ")\"" %>
								class="btn btn-success fs-6 fw-semibold d-flex align-items-center"
								data-bs-toggle="collapse" href="#textCollapse<%=q.getId()%>"
								role="button" aria-expanded="false"
								aria-controls="collapseExample"> <img
								src="<%=q.getIsRead() ? "images/readMess.png" : "images/unreadMess.png"%>">&nbsp;View
								message
							</a>
						</div>
						<div class="collapse <%= q.getId() == session.getAttribute("readId") ? "show": "" %>" id="textCollapse<%=q.getId()%>">
							<p class="fs-6 fw-semibold text-center m-0 mt-2"><%=q.getQuestion()%></p>
						</div>
					</div>

				</div>
				<%
				}
				%>

			</div>
		</div>
	</div>
	<div class="toast-container position-fixed bottom-0 end-0 p-3">
		<div id="catToastUnsuccess" class="toast" role="alert" aria-live="assertive"
			aria-atomic="true">
			<div class="toast-header">
				<img src="images/alarm.png" class="rounded me-2" alt="..."> <strong
					class="me-auto">Warning</strong> <small>just now</small>
				<button type="button" class="btn-close" data-bs-dismiss="toast"
					aria-label="Close"></button>
			</div>
			<div class="toast-body fw-semibold fs-6">Action unsuccessful</div>
		</div>
	</div>
	<div class="toast-container position-fixed bottom-0 end-0 p-3">
		<div id="catToastSuccess" class="toast" role="alert" aria-live="assertive"
			aria-atomic="true">
			<div class="toast-header">
				<img src="images/success.png" class="rounded me-2" alt="..."> <strong
					class="me-auto">Success</strong> <small>just now</small>
				<button type="button" class="btn-close" data-bs-dismiss="toast"
					aria-label="Close"></button>
			</div>
			<div class="toast-body fw-semibold fs-6">Action successful.</div>
		</div>
	</div>
	<script>
    document.addEventListener('DOMContentLoaded', function() {
        const modifyButtons = document.querySelectorAll('.modify-btn');
        const addButtons = document.querySelectorAll('.add-btn');

        modifyButtons.forEach(button => {
            button.addEventListener('click', function() {
                const categoryId = this.getAttribute('data-category-id');
                document.getElementById('categoryIdInput').value = categoryId;
            });
        });
        addButtons.forEach(button => {
            button.addEventListener('click', function() {
                const categoryId = this.getAttribute('data-category-id');
                document.getElementById('categoryIdInputAttr').value = categoryId;
            });
        });
    });
    window.addEventListener('load', () => {
    	const toastShown = <%= session.getAttribute("readUnsuccess")%>
    	const toastShownSuccess = <%= session.getAttribute("readSuccess")%>
        if (toastShown) {
            const toastLiveExample = document.getElementById('catToastUnsuccess');

            const toastBootstrap = new bootstrap.Toast(toastLiveExample, { autohide: false });
            toastBootstrap.show();

            <% session.setAttribute("readUnsuccess", "false");%>
        }
        if (toastShownSuccess) {
            const toastLiveExample = document.getElementById('catToastSuccess');

            const toastBootstrap = new bootstrap.Toast(toastLiveExample, { autohide: false });
            toastBootstrap.show();

            <% session.setAttribute("readSuccess", "false");%>
        }
    });
	</script>
</body>
</html>