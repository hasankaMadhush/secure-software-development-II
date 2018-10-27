<%@page import="com.ssd.oauth.GoogleOpenAuthService"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="org.json.JSONObject,org.json.JSONException,java.util.*"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>Google OAuth 2.0 Authentication</title>
<style>
body {
	font-family: Sans-Serif;
	background: #9053c7;
    background: -webkit-linear-gradient(-135deg, #c850c0, #4158d0);
    background: -o-linear-gradient(-135deg, #c850c0, #4158d0);
    background: -moz-linear-gradient(-135deg, #c850c0, #4158d0);
    background: linear-gradient(-135deg, #c850c0, #4158d0);
}

.center {
		margin: auto;
		width: 60%;
		border: 3px solid;
		padding: 10px;
		text-align: center;
}
.headingCenter {
				margin: auto;
				width: 60%;
				padding: 10px;
				text-align: center;
}
.headingCenter a {
    margin: auto;
	display: block;
	padding: 10px;
    text-align: center;
	border-style: solid;
	border-color: #bbb #888 #666 #aaa;
	border-width: 1px 2px 2px 1px;
	background: #ccc;
	color: #333;
	line-height: 2;
	text-decoration: none;
	font-weight: 900;
}

</style>
</head>
<body>
	<div style="float:center" class="center">
	    <div class="headingCenter">
        	<h2 style="float:center">WELCOME TO OAUTH 2.0 Authentication</h2>
        </div>
        <div class="headingCenter">
		<%
			/*
			 * The GoogleAuthHelper handles all the heavy lifting, and contains all "secrets"
			 */
			final GoogleOpenAuthService oAuthService = new GoogleOpenAuthService();

            /*
             * checking is this initial visit to page
             */

			if (request.getParameter("code") == null
					|| request.getParameter("state") == null) {

				 out.println("<a href='" + oAuthService.buildLoginUrl()+ "'>Sign in with <i class='fa fa-google' style='font-size:36px;color:red'>oogle</i></a>");

				/*
				 * setting the secure state token in session to be able to track what we sent to google
				 */
				session.setAttribute("state", oAuthService.getStateToken());

			} else if (request.getParameter("code") != null && request.getParameter("state") != null
					&& request.getParameter("state").equals(session.getAttribute("state"))) {

				session.removeAttribute("state");

				out.println("<pre>");
                /*
                 * get authenticated users information using getUserInfoJson from GoogleOpenAuthService class
                 *
                 */

                String value = oAuthService.getUserInfoJson(request.getParameter("code"));
                JSONObject jsonObj = new JSONObject(value);

                String email = (String) jsonObj.get("email");
                String name = (String) jsonObj.get("name");
                String given_name = (String) jsonObj.get("given_name");
                String pictureURL = (String) jsonObj.get("picture");

                out.println("Hello " + given_name);
                out.println("<img src='"+pictureURL+"'/>");
                out.println("Logged in as : " + name);
                out.println("Email: " + email);
				out.println("</pre>");
			}
		%>
                <h2 style="float:center">OAuth Client | Hasanka Madhushan | IT 15001030</h2>
		</div>
	</div>
	<br />
</body>
</html>
