<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="juanlucas.models.Category" %>
<%@ page import="juanlucas.models.Provider" %>
<%@ page import="juanlucas.controllers.CategoriesController" %>
<%@ page import="juanlucas.controllers.ProvidersController" %>
<%@ page import="juanlucas.controllers.AuthController" %>
<%
boolean auth = AuthController.checkAuth(request, response);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Registrar artículo</title>
	<link href="../../styles/general.css" rel="stylesheet">
	<link href="../../styles/forms.css" rel="stylesheet">
</head>
<body>
	<header class="border-bottom d-flex justify-content-between p-3">
		<a href="../" class="btn btn-primary">Volver</a>
		<h2 id="tituloHeader">Añadir artículo</h2>
	</header>
	<main class="container-md">
		<% 
			if(session.getAttribute("msg") != null){
				String[] message = (String[])session.getAttribute("msg");
		%>
				<div class="mt-2 col-12 alert <%= message[0] == "ok" ? "alert-success" : "alert-danger" %>"><%= message[1] %></div>
		<% 
				session.removeAttribute("msg");
			}
		%>
		<form method="post" action="../../ArticlesController?action=register" class="mt-5 col-12 col-sm-8 offset-sm-2 col-lg-6 offset-lg-3">
			<div class="mb-3">
			    <label for="description" class="form-label">Descripción</label>
			    <input type="text" class="form-control" placeholder="Nombre visible del artículo" name="description" id="description" required>
			  </div>
			  <div class="mb-3">
			    <label for="price" class="form-label">Precio</label>
			    <input type="number" step="0.01" min="0" class="form-control" placeholder="Precio en €" name="price" id="price" required>
			  </div>
			  <div class="mb-3">
			    <label for="category" class="form-label">Categoría</label>
			    <select class="form-select" id="category" name="category">
			    	<option></option>
			    	<% 
			    		ArrayList<Category> categories = CategoriesController.list();
			    		for(int i = 0; i<categories.size();i++){
							Category category = categories.get(i);
			    	%>
			    		<option value="<%= category.getId() %>"><%= category.getTitle() %></option>
			    	<% } %>
			    </select>
			  </div>
			  <div class="mb-3">
			    <label for="provider" class="form-label">Proveedor</label>
			    <select class="form-select" id="provider" name="provider">
			    	<option></option>
			    	<% 
			    		ArrayList<Provider> providers = ProvidersController.list();
			    		for(int i = 0; i<providers.size();i++){
							Provider provider = providers.get(i);
			    	%>
			    		<option value="<%= provider.getId() %>"><%= provider.getName() %></option>
			    	<% } %>
			    </select>
			  </div>
			  <button type="submit" class="btn btn-primary">Registrar</button>
		</form>
	</main>
</body>
</html>