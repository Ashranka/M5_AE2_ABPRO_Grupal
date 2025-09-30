<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Resultados de la Encuesta</title>
</head>
<body>
<h1>Resultados de la Encuesta</h1>

<div class="info">
    <p><strong>Nombre:</strong> <c:out value="${param.nombre}" /></p>
    <p><strong>Edad:</strong> <c:out value="${param.edad}" /> años</p>
    <p><strong>Calificación:</strong> <c:out value="${param.calificacion}" /> de 5</p>

    <c:if test="${not empty param.comentario}">
        <p><strong>Comentario:</strong> <c:out value="${param.comentario}" /></p>
        <!-- Usar fn:length para contar caracteres -->
        <p><strong>Longitud del comentario:</strong> ${fn:length(param.comentario)} caracteres</p>
    </c:if>
</div>

<c:if test="${param.edad < 18}">
    <div class="mensaje advertencia">
        <strong>ADVERTENCIA:</strong> Usuario menor de 18 años. Se requiere supervisión parental.
    </div>
</c:if>

<c:if test="${param.calificacion >= 4}">
    <div class="mensaje exito">
        <strong>¡Muchas gracias!</strong> Nos alegra que tu experiencia haya sido satisfactoria.
    </div>
</c:if>

<div class="mensaje">
    <c:choose>
        <c:when test="${param.recomienda == 'si'}">
            <strong>Recomendación:</strong> El usuario SÍ recomendaría este sitio. ¡Excelente!
        </c:when>
        <c:when test="${param.recomienda == 'no'}">
            <strong>Recomendación:</strong> El usuario NO recomendaría este sitio. Debemos mejorar.
        </c:when>
        <c:otherwise>
            <strong>Recomendación:</strong> No se registró respuesta.
        </c:otherwise>
    </c:choose>
</div>

<div>
    <a href="encuesta.jsp">Nueva Encuesta</a>
    <a href="libro_respuestas.jsp">Ver Todas las Respuestas</a>
</div>
</body>
</html>