<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="juanlucas.models.Article" %>
<%@ page import="juanlucas.models.Admin" %>
<%@ page import="juanlucas.controllers.ArticlesController" %>
<%@ page import="juanlucas.controllers.AuthController" %>
<%
	boolean auth = AuthController.checkAuth(request, response);
	if(auth){
		Admin admin = (Admin)request.getSession().getAttribute("loged");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Artículos</title>
	<link href="../styles/general.css" rel="stylesheet">
	<link href="../styles/lists.css" rel="stylesheet">
</head>
<body>
	<header class="border-bottom d-flex justify-content-between p-3">
		<h2 id="tituloHeader">Artículos</h2>
		<div id="botonBurger">
			<div></div>
			<div></div>
			<div></div>
		</div>
		<nav id="navMovil">
			<a href="../providers">Proveedores</a>
			<a href="../categories">Categorías</a>
			<% if(admin.isSuperadmin()){ %>
				<a href="../admins">Administradores</a>
			<% } %>
			<span><%= admin.getUsername() %> - <a href="../AuthController?action=logout">Salir</a></span>
		</nav>		
	</header>
	<main class="container mt-5">
		<div class="col-3 offset-9 col-sm-2 offset-sm-10 col-lg-1 offset-lg-11">
			<a href="add" class="btn btn-success">Añadir</a>
		</div>
		<% 
			if(session.getAttribute("msg") != null){
				String[] message = (String[])session.getAttribute("msg");
		%>
				<div class="mt-2 col-12 alert <%= message[0] == "ok" ? "alert-success" : "alert-danger" %>"><%= message[1] %></div>
		<% 
				session.removeAttribute("msg");
			}
		%>
		<div class="table-responsive col-12">
			<table class="table table-striped table-hover">
				<thead>
					<tr>
						<th>Código</th>
						<th>Descripción</th>
						<th>Categoría</th>
						<th>Precio</th>
						<th>Proveedor</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
				<% 
					ArrayList<Article> list = ArticlesController.list();
					for(int i = 0; i<list.size();i++){
						Article article = list.get(i);
				%>
					<tr>
						<td><%= article.getId() %></td>
						<td><%= article.getDescription() %></td>
						<td>
							<% if(article.getCategory() != null) { %>
								<%= article.getCategory().getTitle() %>
							<% }else{ %>
								-
							<% } %>
						</td>
						<td><%= article.getPrice() %> €</td>
						<td>
							<% if(article.getProvider() != null) { %>
								<%= article.getProvider().getName() %>
							<% }else{ %>
								-
							<% } %>
						</td>
						<td class="text-center">
							<a href="edit?id=<%= article.getId() %>" class="btn btn-secondary">Editar</a>
							<button class="btn btn-danger deleteBtn" onclick="deleteArticle(<%= article.getId() %>)">Borrar</button>
						</td>
					</tr>
				<%						
					}
				%>
				</tbody>
			</table>
		</div>
	</main>
	<script type="text/javascript" src="../scripts/menu.js"></script>
	<script type="text/javascript">
	
		function deleteArticle(id){
			if(confirm("¿Realmente quieres borrar el artículo?")){
				window.location.href = "../ArticlesController?action=delete&id="+id;
			}
		}
	
	</script>
</body>
</html>
<% } %>