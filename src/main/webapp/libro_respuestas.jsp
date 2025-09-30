<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.*" %>

<%
    // ============================================
    // BACKEND: Simulación de lista de respuestas
    // ============================================

    List<Map<String, Object>> respuestas = new ArrayList<>();

    // Respuesta 1
    Map<String, Object> resp1 = new HashMap<>();
    resp1.put("nombre", "María García López");
    resp1.put("edad", 28);
    resp1.put("recomienda", "si");
    resp1.put("calificacion", 5);
    resp1.put("comentario", "Excelente servicio, muy satisfecha con la atención recibida. El sitio es fácil de usar.");
    respuestas.add(resp1);

    // Respuesta 2
    Map<String, Object> resp2 = new HashMap<>();
    resp2.put("nombre", "Carlos Rodríguez");
    resp2.put("edad", 16);
    resp2.put("recomienda", "si");
    resp2.put("calificacion", 4);
    resp2.put("comentario", "Muy buena experiencia, aunque podrían mejorar algunas funciones.");
    respuestas.add(resp2);

    // Respuesta 3 - Calificación BAJA
    Map<String, Object> resp3 = new HashMap<>();
    resp3.put("nombre", "Ana Martínez");
    resp3.put("edad", 35);
    resp3.put("recomienda", "no");
    resp3.put("calificacion", 2);
    resp3.put("comentario", "El servicio fue lento y tuve problemas para encontrar lo que buscaba.");
    respuestas.add(resp3);

    // Respuesta 4
    Map<String, Object> resp4 = new HashMap<>();
    resp4.put("nombre", "Roberto Silva");
    resp4.put("edad", 42);
    resp4.put("recomienda", "si");
    resp4.put("calificacion", 5);
    resp4.put("comentario", "Increíble experiencia, todo funcionó perfectamente.");
    respuestas.add(resp4);

    // Respuesta 5
    Map<String, Object> resp5 = new HashMap<>();
    resp5.put("nombre", "Laura Pérez");
    resp5.put("edad", 24);
    resp5.put("recomienda", "si");
    resp5.put("calificacion", 4);
    resp5.put("comentario", "Buena plataforma, cumple con lo prometido.");
    respuestas.add(resp5);

    // Respuesta 6 - Calificación BAJA
    Map<String, Object> resp6 = new HashMap<>();
    resp6.put("nombre", "Diego Torres");
    resp6.put("edad", 31);
    resp6.put("recomienda", "no");
    resp6.put("calificacion", 1);
    resp6.put("comentario", "Muy decepcionado. El sistema se cayó varias veces.");
    respuestas.add(resp6);

    // Respuesta 7
    Map<String, Object> resp7 = new HashMap<>();
    resp7.put("nombre", "Carmen Jiménez");
    resp7.put("edad", 17);
    resp7.put("recomienda", "si");
    resp7.put("calificacion", 3);
    resp7.put("comentario", "Es aceptable, cumple su función.");
    respuestas.add(resp7);

    // Guardar en request
    request.setAttribute("respuestas", respuestas);

    // ============================================
    // BACKEND: Cálculo de estadísticas
    // ============================================

    int totalRespuestas = respuestas.size();
    int recomiendaSi = 0;
    int recomiendaNo = 0;
    double sumaCalificaciones = 0;
    int menoresDeEdad = 0;
    int calificacionesBajas = 0;

    for (Map<String, Object> resp : respuestas) {
        // Contar recomendaciones
        if ("si".equals(resp.get("recomienda"))) {
            recomiendaSi++;
        } else if ("no".equals(resp.get("recomienda"))) {
            recomiendaNo++;
        }

        // Suma calificaciones
        int calificacion = (Integer) resp.get("calificacion");
        sumaCalificaciones += calificacion;

        // Contar calificaciones bajas (menor a 3)
        if (calificacion < 3) {
            calificacionesBajas++;
        }

        // Contar menores de edad
        int edad = (Integer) resp.get("edad");
        if (edad < 18) {
            menoresDeEdad++;
        }
    }

    double promedioCalificacion = sumaCalificaciones / totalRespuestas;

    // Guardar estadísticas en request
    request.setAttribute("totalRespuestas", totalRespuestas);
    request.setAttribute("recomiendaSi", recomiendaSi);
    request.setAttribute("recomiendaNo", recomiendaNo);
    request.setAttribute("promedioCalificacion", String.format("%.2f", promedioCalificacion));
    request.setAttribute("menoresDeEdad", menoresDeEdad);
    request.setAttribute("calificacionesBajas", calificacionesBajas);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lista de Respuestas</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<h1>Lista de Respuestas de Encuestas</h1>

<!-- ============================================ -->
<!-- BACKEND: Mostrar estadísticas generales     -->
<!-- ============================================ -->
<div class="estadisticas">
    <h2>Estadísticas Generales</h2>
    <p><strong>Total de respuestas:</strong> ${totalRespuestas}</p>
    <p><strong>Calificación promedio:</strong> ${promedioCalificacion} / 5</p>
    <p><strong>Recomiendan el sitio:</strong> ${recomiendaSi} usuarios</p>
    <p><strong>No recomiendan el sitio:</strong> ${recomiendaNo} usuarios</p>
    <p><strong>Menores de edad:</strong> ${menoresDeEdad} usuarios</p>
    <p><strong>Calificaciones bajas (&lt; 3):</strong> ${calificacionesBajas} usuarios</p>
</div>

<!-- ============================================ -->
<!-- BACKEND: Iterar lista con c:forEach         -->
<!-- ============================================ -->
<h2>Detalle de Respuestas</h2>

<c:choose>
    <c:when test="${empty respuestas}">
        <p>No hay respuestas registradas aún.</p>
    </c:when>
    <c:otherwise>
        <table>
            <thead>
            <tr>
                <th>#</th>
                <th>Nombre</th>
                <th>Edad</th>
                <th>Calificación</th>
                <th>Recomienda</th>
                <th>Comentario</th>
            </tr>
            </thead>
            <tbody>
            <!-- Usar c:forEach para iterar sobre respuestas -->
            <c:forEach var="respuesta" items="${respuestas}" varStatus="status">
                <tr class="${respuesta.calificacion < 3 ? 'baja' : ''} ${respuesta.edad < 18 ? 'menor' : ''}">
                    <td>${status.index + 1}</td>
                    <td><c:out value="${respuesta.nombre}" /></td>
                    <td>
                            ${respuesta.edad} años
                        <!-- Mostrar badge si es menor de edad -->
                        <c:if test="${respuesta.edad < 18}">
                            <br><small><strong>[MENOR DE EDAD]</strong></small>
                        </c:if>
                    </td>
                    <td>
                            ${respuesta.calificacion} / 5
                        <!-- Alerta especial para calificaciones bajas -->
                        <c:if test="${respuesta.calificacion < 3}">
                            <br><small style="color: red;"><strong>[REQUIERE ATENCIÓN]</strong></small>
                        </c:if>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${respuesta.recomienda == 'si'}">
                                ✓ Sí
                            </c:when>
                            <c:otherwise>
                                ✗ No
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:out value="${respuesta.comentario}" />
                        <br>
                        <small>(${fn:length(respuesta.comentario)} caracteres)</small>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <!-- Mostrar resumen de problemas detectados -->
        <c:if test="${calificacionesBajas > 0}">
            <div class="alerta">
                <strong>¡ATENCIÓN!</strong> Hay ${calificacionesBajas} respuesta(s) con calificación baja que requieren seguimiento.
            </div>
        </c:if>
    </c:otherwise>
</c:choose>

<a href="encuesta.jsp">Nueva Encuesta</a>
</body>
</html>