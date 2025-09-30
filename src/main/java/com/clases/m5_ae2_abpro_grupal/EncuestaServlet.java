package com.clases.m5_ae2_abpro_grupal;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/procesarEncuesta")
public class EncuestaServlet extends HttpServlet {

    private static List<Map<String, Object>> respuestas = new ArrayList<>();

    static {
        cargarDatosPrueba();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String nombre = request.getParameter("nombre");
        String edadStr = request.getParameter("edad");
        String recomienda = request.getParameter("recomienda");
        String calificacionStr = request.getParameter("calificacion");
        String comentario = request.getParameter("comentario");

        // Validar datos
        if (nombre == null || edadStr == null || calificacionStr == null) {
            response.sendRedirect("encuesta.jsp");
            return;
        }

        try {
            int edad = Integer.parseInt(edadStr);
            int calificacion = Integer.parseInt(calificacionStr);

            Map<String, Object> nuevaRespuesta = new HashMap<>();
            nuevaRespuesta.put("nombre", nombre);
            nuevaRespuesta.put("edad", edad);
            nuevaRespuesta.put("recomienda", recomienda);
            nuevaRespuesta.put("calificacion", calificacion);
            nuevaRespuesta.put("comentario", comentario != null ? comentario : "");

            respuestas.add(nuevaRespuesta);

            request.setAttribute("nombre", nombre);
            request.setAttribute("edad", edad);
            request.setAttribute("recomienda", recomienda);
            request.setAttribute("calificacion", calificacion);
            request.setAttribute("comentario", comentario);

            request.getRequestDispatcher("/resultados.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("encuesta.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Calcular estadísticas
        int totalRespuestas = respuestas.size();
        int recomiendaSi = 0;
        int recomiendaNo = 0;
        double sumaCalificaciones = 0;
        int menoresDeEdad = 0;
        int calificacionesBajas = 0;

        for (Map<String, Object> resp : respuestas) {
            String recomienda = (String) resp.get("recomienda");
            if ("si".equals(recomienda)) recomiendaSi++;
            if ("no".equals(recomienda)) recomiendaNo++;

            int calificacion = (Integer) resp.get("calificacion");
            sumaCalificaciones += calificacion;
            if (calificacion < 3) calificacionesBajas++;

            int edad = (Integer) resp.get("edad");
            if (edad < 18) menoresDeEdad++;
        }

        double promedioCalificacion = totalRespuestas > 0 ?
                sumaCalificaciones / totalRespuestas : 0;

        // Pasar datos al JSP
        request.setAttribute("respuestas", respuestas);
        request.setAttribute("totalRespuestas", totalRespuestas);
        request.setAttribute("recomiendaSi", recomiendaSi);
        request.setAttribute("recomiendaNo", recomiendaNo);
        request.setAttribute("promedioCalificacion", String.format("%.2f", promedioCalificacion));
        request.setAttribute("menoresDeEdad", menoresDeEdad);
        request.setAttribute("calificacionesBajas", calificacionesBajas);

        request.getRequestDispatcher("/lista_respuestas.jsp").forward(request, response);
    }

    private static void cargarDatosPrueba() {
        respuestas.clear();

        Map<String, Object> resp1 = new HashMap<>();
        resp1.put("nombre", "María García López");
        resp1.put("edad", 28);
        resp1.put("recomienda", "si");
        resp1.put("calificacion", 5);
        resp1.put("comentario", "Excelente servicio, muy satisfecha con la atención recibida.");
        respuestas.add(resp1);

        Map<String, Object> resp2 = new HashMap<>();
        resp2.put("nombre", "Carlos Rodríguez");
        resp2.put("edad", 16);
        resp2.put("recomienda", "si");
        resp2.put("calificacion", 4);
        resp2.put("comentario", "Muy buena experiencia, aunque podrían mejorar algunas funciones.");
        respuestas.add(resp2);

        Map<String, Object> resp3 = new HashMap<>();
        resp3.put("nombre", "Ana Martínez");
        resp3.put("edad", 35);
        resp3.put("recomienda", "no");
        resp3.put("calificacion", 2);
        resp3.put("comentario", "El servicio fue lento y tuve problemas.");
        respuestas.add(resp3);

        Map<String, Object> resp4 = new HashMap<>();
        resp4.put("nombre", "Roberto Silva");
        resp4.put("edad", 42);
        resp4.put("recomienda", "si");
        resp4.put("calificacion", 5);
        resp4.put("comentario", "Increíble experiencia, todo funcionó perfectamente.");
        respuestas.add(resp4);

        Map<String, Object> resp5 = new HashMap<>();
        resp5.put("nombre", "Laura Pérez");
        resp5.put("edad", 24);
        resp5.put("recomienda", "si");
        resp5.put("calificacion", 4);
        resp5.put("comentario", "Buena plataforma, cumple con lo prometido.");
        respuestas.add(resp5);

        Map<String, Object> resp6 = new HashMap<>();
        resp6.put("nombre", "Diego Torres");
        resp6.put("edad", 31);
        resp6.put("recomienda", "no");
        resp6.put("calificacion", 1);
        resp6.put("comentario", "Muy decepcionado. El sistema se cayó varias veces.");
        respuestas.add(resp6);

        Map<String, Object> resp7 = new HashMap<>();
        resp7.put("nombre", "Carmen Jiménez");
        resp7.put("edad", 17);
        resp7.put("recomienda", "si");
        resp7.put("calificacion", 3);
        resp7.put("comentario", "Es aceptable, cumple su función.");
        respuestas.add(resp7);
    }
}