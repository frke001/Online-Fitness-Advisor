<%@page import="dto.AdvisorQuestionDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="advisorBean" class="beans.AdvisorBean" scope="session"></jsp:useBean>
<jsp:useBean id="questionBean" class="beans.AdvisorQuestionBean"
	scope="session"></jsp:useBean>

<%
if (!(advisorBean.isLoggedIn()))
	response.sendRedirect("login.jsp");

	
	Long id = Long.parseLong(request.getParameter("id"));
	AdvisorQuestionDTO q = questionBean.findById(id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport"
	content="width=device-width, initial-scale=1">
<title>Message reply</title>
<link href="bootstrap-5.3.2-dist/css/bootstrap.min.css" rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous">
<script src="bootstrap-5.3.2-dist/js/bootstrap.bundle.min.js"
	integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
	crossorigin="anonymous"></script>
<link href="styles/navbar.css" rel="stylesheet">

<script type="text/javascript">
	
function send() {
    var fileInput = document.getElementById('fileInput');
    if (fileInput.files.length > 0) {
        var formData = new FormData();
        formData.append('image', fileInput.files[0]);
		console.log("fajl");
        var request = new XMLHttpRequest();
        request.onreadystatechange = function () {
            if ((request.readyState == 4) && (request.status == 201)) {
                
                var form = document.forms[0];
                var elements = form.elements;

                let tmp = {
                    attachmentId: Number.parseInt(request.responseText),
                    to: elements.mail.value,
                    message: elements.message.value,
                    subject: elements.subject.value ? elements.subject.value : null
                }
                var sendRequest = new XMLHttpRequest();
                sendRequest.onreadystatechange = function () {
                    if ((sendRequest.readyState == 4) && (sendRequest.status == 200)) {
                    	console.log("fajl success");
                    	window.location.href="messages.jsp?action=sentMail";
                    }
                }
                sendRequest.open("POST", "http://localhost:9000/api/v1/mail", true);
                sendRequest.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
                sendRequest.send(JSON.stringify(tmp));
                form.reset();
                
            }
        }

        request.open("POST", "http://localhost:9000/api/v1/image", true);
       	
        request.send(formData);
    }else{
    	console.log("else");
        
        var form = document.forms[0];
        var elements = form.elements;
        var tmp = {
            to: elements.mail.value,
            message: elements.message.value,
            subject: elements.subject.value ? elements.subject.value : null
        }
        var sendRequest = new XMLHttpRequest();
        sendRequest.onreadystatechange = function () {
            if ((sendRequest.readyState == 4) && (sendRequest.status == 200)) {
            	console.log("else success");
            	window.location.href="messages.jsp?action=sentMail";
            }
        }
        sendRequest.open("POST", "http://localhost:9000/api/v1/mail", true);
        sendRequest.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
        sendRequest.send(JSON.stringify(tmp));
        form.reset();
    }
}
</script>
</head>
<body class="bg-secondary">
	<jsp:include page="navbar.jsp"></jsp:include>
	<div class="p-4">
		<p class="fw-semibold text-white fs-2">Message reply for <%=q.getClientSenderUsername() %></p>
	</div>
	<div class="container-fluid d-flex align-items-center content"
		style="height: calc(100vh - 184px);">
		<div class="row d-flex justify-content-center w-100 ms-1">
			<div class="col-sm-12 col-md-5">
				<div class="card shadow border border-0 p-4" style="background-color: #cfe2ff;">
					<div class="card-body " style="background-color: #cfe2ff;">
						<p class="fw-semibold fs-3">
							Enter e-mail details <img src="images/gmail.png">
						</p>
						
						<form method="post" action="javascript:send()" class="needs-validation" novalidate>
						<label class="fw-semibold fs-5">Client mail</label>
							<div class="input-group mb-3">
								<span class="input-group-text" id="basic-addon1"><img
									src="images/mailClient.png"></span> <input type="text"
									class="form-control fw-semibold shadow"
									placeholder="Enter mail subject" aria-label="Username"
									aria-describedby="basic-addon1"
									value="<%=q.getMail() %>" readonly name="mail">
						</div>
							<label class="fw-semibold fs-5">Subject</label>
							<div class="input-group mb-3">
								<span class="input-group-text" id="basic-addon1"><img
									src="images/title.png"></span> <input type="text"
									class="form-control fw-semibold shadow"
									placeholder="Enter mail subject" aria-label="Subject"
									aria-describedby="basic-addon1" name="subject">
			
							</div>
							<label class="fw-semibold fs-5">Message</label>
							<div class="input-group mb-3 has-validation">
								<span class="input-group-text"><img src="images/mess.png"></span>
								<textarea class="form-control fw-semibold shadow"
									placeholder="Enter mail message" aria-label="With textarea" name="message" required></textarea>
								<div class="invalid-feedback" >Please insert message.</div>	
							</div>
							<label class="fw-semibold fs-5">Attachment</label>
							<div class="mb-3">
							 <input class="form-control fw-semibold shadow" type="file"
									id="fileInput">
				
							</div>
							<button type="submit" name="submit" class="btn btn-success fw-semibold">Send mail&nbsp;<img src="images/reply.png"></button>
						</form>
					</div>
				</div>
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