<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Encuesta de Satisfacción</title>
</head>
<body>
<h1>Encuesta de Satisfacción</h1>

<!-- CAMBIO: action apunta al servlet -->
<form action="procesarEncuesta" method="POST">
    <div class="form-group">
        <label for="nombre">Nombre del usuario:</label>
        <input type="text" id="nombre" name="nombre" required>
    </div>

    <div class="form-group">
        <label for="edad">Edad:</label>
        <input type="number" id="edad" name="edad" min="1" max="120" required>
    </div>

    <div class="form-group">
        <label>¿Recomendarías este sitio a otros?</label>
        <input type="radio" id="recomienda_si" name="recomienda" value="si" required>
        <label for="recomienda_si" style="display: inline;">Sí</label>

        <input type="radio" id="recomienda_no" name="recomienda" value="no" required>
        <label for="recomienda_no" style="display: inline;">No</label>
    </div>

    <div class="form-group">
        <label for="calificacion">Calificación del 1 al 5:</label>
        <select id="calificacion" name="calificacion" required>
            <option value="">-- Selecciona --</option>
            <option value="1">1 - Muy insatisfecho</option>
            <option value="2">2 - Insatisfecho</option>
            <option value="3">3 - Neutral</option>
            <option value="4">4 - Satisfecho</option>
            <option value="5">5 - Muy satisfecho</option>
        </select>
    </div>

    <div class="form-group">
        <label for="comentario">Comentario adicional:</label>
        <textarea id="comentario" name="comentario" rows="5"></textarea>
    </div>

    <button type="submit">Enviar Encuesta</button>
</form>
</body>
</html>