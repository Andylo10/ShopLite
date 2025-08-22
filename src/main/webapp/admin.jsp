<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>ShopLite • Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body class="bg-light">
<nav class="navbar navbar-expand-lg bg-white border-bottom">
    <div class="container">
        <a class="navbar-brand text-danger" href="${pageContext.request.contextPath}/home">ShopLite • Admin</a>
    </div>
</nav>

<section class="container my-5">
    <c:if test="${param.err=='1'}">
        <div class="alert alert-danger">Datos inválidos</div>
    </c:if>

    <div class="row g-4">
        <!-- Columna izquierda: Agregar producto -->
        <div class="col-md-4">
            <div class="card shadow-sm">
                <div class="card-body p-4">
                    <h3 class="mb-3">Agregar nuevo producto</h3>
                    <form id="addProductForm" method="post" action="${pageContext.request.contextPath}/admin" class="row g-3">
                        <input type="hidden" name="action" value="add">
                        <div class="col-12">
                            <label class="form-label">Nombre</label>
                            <input class="form-control" name="name" placeholder="Teclado 60%" required>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Precio</label>
                            <input class="form-control" name="price" placeholder="59.99" required>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Stock</label>
                            <input class="form-control" name="stock" placeholder="10" required>
                        </div>
                        <div class="col-12">
                            <button type="submit" class="btn btn-primary w-100">Guardar</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Sección Editar producto -->
            <div class="card shadow-sm mt-4" id="editSection" style="display:none;">
                <div class="card-body p-4">
                    <h3 class="mb-3">Editar producto</h3>
                    <form id="editProductForm" method="post" action="${pageContext.request.contextPath}/admin" class="row g-3">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="id" id="editProductId">
                        <div class="col-12">
                            <label class="form-label">Nombre</label>
                            <input class="form-control" name="name" id="editProductName" required>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Precio</label>
                            <input class="form-control" name="price" id="editProductPrice" required>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Stock</label>
                            <input class="form-control" name="stock" id="editProductStock" required>
                        </div>
                        <div class="col-12 d-flex gap-2">
                            <button type="submit" class="btn btn-success w-50">Actualizar</button>
                            <button type="button" class="btn btn-secondary w-50" onclick="closeEdit()">Cancelar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Columna derecha: Tabla productos -->
        <div class="col-md-8">
            <div class="card shadow-sm">
                <div class="card-body p-4">
                    <h3 class="mb-3">Productos existentes</h3>
                    <table class="table table-bordered table-hover">
                        <thead class="table-light">
                        <tr>
                            <th>Nombre</th>
                            <th>Precio</th>
                            <th>Stock</th>
                            <th>Acciones</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="p" items="${products}">
                            <tr>
                                <td>${p.name}</td>
                                <td>${p.price}</td>
                                <td>${p.stock}</td>
                                <td class="d-flex gap-1">
                                    <button class="btn btn-sm" title="Editar"
                                            style="color:#0d6efd; border:none; background:none;"
                                            onclick="editProduct('${p.id}', '${p.name}', ${p.price}, ${p.stock})">
                                        <i class="bi bi-pencil-fill"></i>
                                    </button>
                                    <form method="post" action="${pageContext.request.contextPath}/admin" style="display:inline-block;">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="${p.id}">
                                        <button class="btn btn-sm" title="Eliminar"
                                                style="color:#dc3545; border:none; background:none;">
                                            <i class="bi bi-trash-fill"></i>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</section>

<script>
    function editProduct(id, name, price, stock) {
        document.getElementById('editSection').style.display = 'block';
        document.getElementById('editProductId').value = id;
        document.getElementById('editProductName').value = name;
        document.getElementById('editProductPrice').value = price;
        document.getElementById('editProductStock').value = stock;
        document.getElementById('editProductForm').scrollIntoView({ behavior: 'smooth' });
    }

    function closeEdit() {
        document.getElementById('editSection').style.display = 'none';
    }
</script>

</body>
</html>
