# JSP Implicit Objects

https://www.udemy.com/jsp-servlet-free-course/learn/lecture/5377438#overview

implicit objects are created by the web container that are available to all the jsp pages. There are in total 9 Implicit objects

A list of the 9 implicit objects is given below:

implicit objects

implicit objects

            Class

out

javax.servlet.jsp.JspWriter

request

javax.servlet.http.HttpServletRequest

response

javax.servlet.http.HttpServletResponse

session

javax.servlet.http.HttpSession

application

javax.servlet.ServletContext

exception

javax.servlet.jsp.JspException

Page

java.lang.Object

pageContext

javax.servlet.jsp.PageContext

Config

javax.servlet.ServletConfig

__________________________________________________________________________________________

 Out: It can be used for writing content to the browser

Example: out.print(“Hello World”);

__________________________________________________________________________________________ 

Request: Its purpose is to get the data on a JSP page which has been entered by user on the previous JSP page.

Example: String name= request.getParameter("name");

 __________________________________________________________________________________________

Response: Response object helps the user to give the response to the client after page load.

Example: response.sendRedirect("http://studyeasy.org");

 __________________________________________________________________________________________

Session: It is used for storing user’s data to make it available on other JSP pages till the user session is active.

Example: session.getAttribute(“name”);

 __________________________________________________________________________________________

Application: it is used for getting application wide initialized parameter(s) and to maintain useful data across whole JSP application.

Example: application.getAttribute(“BuiltVer”);

__________________________________________________________________________________________

Exception: This object is used in exception handling for displaying the error messages. This object is only available to the JSP pages, which has isErrorPage set to true.

Example:

<!-- Exception.jsp -->

<%@ page isErrorPage="true" %>

Exception occurred: <%= 25/0 %>

 __________________________________________________________________________________________

Page: The page implicit object represents the JSP page itself. It is of type object. It is rarely used in JSP pages.

pageContext: pageContext implicit object provides methods to access other implicit objects. Specifically pageContext object has methods like getPage, getRequest, getResponse etc. It also provides methods to set and get attributes. The scope of the pages attribute is the processing of that page.

 __________________________________________________________________________________________

Config: This is a Servlet configuration object and mainly used for accessing getting configuration information such as servlet context, servlet name, configuration parameters etc.

Example: String servletName=config.getServletName();

 __________________________________________________________________________________________