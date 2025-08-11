<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>ShopLite • Productos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<nav class="navbar navbar-expand-lg bg-white border-bottom">
    <div class="container">
        <a class="navbar-brand text-primary" href="${pageContext.request.contextPath}/home">ShopLite</a>
        <div class="ms-auto d-flex gap-2">
            <a class="btn btn-sm btn-outline-secondary" href="${pageContext.request.contextPath}/admin">Nuevo producto (Admin)</a>
            <form method="post" action="${pageContext.request.contextPath}/auth/logout">
                <button class="btn btn-sm btn-outline-danger">Cerrar sesión</button>
            </form>
        </div>
    </div>
</nav>

<section class="container my-5">
    <h2 class="mb-3">Productos</h2>

    <div class="row g-3">
        <c:forEach var="p" items="${items}">
            <div class="col-md-4">
                <div class="card shadow-sm h-100">
                    <div class="card-body">
                        <h5 class="card-title"><c:out value="${p.name}"/></h5>
                        <p class="text-muted">$ <c:out value="${p.price}"/></p>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- Selector de tamaño (opcional) -->
    <form method="get" action="${pageContext.request.contextPath}/home" class="mt-4">
        <input type="hidden" name="page" value="1" />
        <label for="sizeSelect" class="form-label">Tamaño por página:</label>
        <select name="size" id="sizeSelect" class="form-select w-auto d-inline" onchange="this.form.submit()">
            <option value="2" ${size==2?'selected':''}>2</option>
            <option value="3" ${size==3?'selected':''}>3</option>
            <option value="4" ${size==4?'selected':''}>4</option>
            <option value="5" ${size==5?'selected':''}>5</option>
            <option value="6" ${size==6?'selected':''}>6</option>
        </select>
    </form>

    <!-- Controles de paginación -->
    <div class="d-flex justify-content-between align-items-center mt-3">

        <!-- URLs calculadas con JSTL: ya incluyen el contextPath -->
        <c:url var="prevUrl" value="/home">
            <c:param name="page" value="${page - 1}" />
            <c:param name="size" value="${size}" />
        </c:url>

        <c:url var="nextUrl" value="/home">
            <c:param name="page" value="${page + 1}" />
            <c:param name="size" value="${size}" />
        </c:url>

        <!-- Botón Anterior -->
        <c:choose>
            <c:when test="${page > 1}">
                <!-- OJO: sin ${pageContext.request.contextPath} -->
                <a class="btn btn-outline-secondary" href="${prevUrl}">« Anterior</a>
            </c:when>
            <c:otherwise>
                <span class="btn btn-outline-secondary disabled" aria-disabled="true">« Anterior</span>
            </c:otherwise>
        </c:choose>

        <span class="text-muted">
            Página ${page} de ${totalPages} • tamaño ${size} • total ${total}
        </span>

        <!-- Botón Siguiente -->
        <c:choose>
            <c:when test="${page < totalPages}">
                <!-- OJO: sin ${pageContext.request.contextPath} -->
                <a class="btn btn-outline-secondary" href="${nextUrl}">Siguiente »</a>
            </c:when>
            <c:otherwise>
                <span class="btn btn-outline-secondary disabled" aria-disabled="true">Siguiente »</span>
            </c:otherwise>
        </c:choose>
    </div>
</section>
</body>
</html>
