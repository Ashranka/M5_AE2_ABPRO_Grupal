<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Resultados de la Encuesta</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="container">
    <h1>Resultados de la Encuesta</h1>

    <!-- Usar c:out para mostrar valores de forma segura -->
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

    <!-- Usar c:if para advertencia si es menor de edad -->
    <c:if test="${param.edad < 18}">
        <div class="mensaje advertencia">
            <strong>ADVERTENCIA:</strong> Usuario menor de 18 años. Se requiere supervisión parental.
        </div>
    </c:if>

    <!-- Usar c:if para agradecimiento especial si calificación >= 4 -->
    <c:if test="${param.calificacion >= 4}">
        <div class="mensaje exito">
            <strong>¡Muchas gracias!</strong> Nos alegra que tu experiencia haya sido satisfactoria.
        </div>
    </c:if>

    <!-- Usar c:choose, c:when, c:otherwise según recomendación -->
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
</div>
</body>
</html>