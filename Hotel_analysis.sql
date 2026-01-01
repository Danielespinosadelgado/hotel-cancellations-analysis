/*
PROYECTO: Análisis de Cancelaciones Hoteleras
OBJETIVO: Identificar patrones de pérdida de ingresos y comportamiento de usuarios.
AUTOR: Daniel Espinosa
HERRAMIENTA: Google BigQuery (Standard SQL)
*/

-- =======================================================
-- 1. ANALISIS DE LEAD TIME (TIEMPO DE ANTICIPACIÓN)
-- =======================================================
-- Hipótesis: Las reservas realizadas con mucha anticipación tienen mayor probabilidad de cancelación.
-- Resultado: Las reservas con +6 meses de anticipación tienen una tasa de cancelación del 57%.

SELECT 
    CASE 
        WHEN lead_time <= 7 THEN '01. Corto Plazo (0-7 días)'
        WHEN lead_time BETWEEN 8 AND 30 THEN '02. Medio Plazo (8-30 días)'
        WHEN lead_time BETWEEN 31 AND 90 THEN '03. Largo Plazo (1-3 meses)'
        WHEN lead_time BETWEEN 91 AND 180 THEN '04. Muy Largo Plazo (3-6 meses)'
        ELSE '05. Extremo (+6 meses)'
    END AS rango_lead_time,
    COUNT(*) AS total_reservas,
    SUM(is_canceled) AS total_cancelaciones,
    ROUND((SUM(is_canceled) / COUNT(*)) * 100, 2) AS tasa_cancelacion_pct
FROM 
    `hotel-booking-demand-482821.hotel_data.hotel_bookings`
GROUP BY 
    rango_lead_time
ORDER BY 
    rango_lead_time;


-- =======================================================
-- 2. DETECCIÓN DE ANOMALÍAS EN SEGMENTOS (GRUPOS)
-- =======================================================
-- Hipótesis: Los grupos tienen altas cancelaciones debido a problemas con el tipo de depósito.
-- Resultado: Se detectó un 99.32% de cancelaciones en 'Groups' con depósito 'Non Refund', sugiriendo un problema operativo/pago.

SELECT 
    deposit_type,
    COUNT(*) AS total_reservas,
    SUM(is_canceled) AS total_cancelaciones,
    ROUND((SUM(is_canceled) / COUNT(*)) * 100, 2) AS tasa_cancelacion_pct
FROM 
    `hotel-booking-demand-482821.hotel_data.hotel_bookings`
WHERE
    market_segment = 'Groups' -- Filtro para enfocar el análisis en el segmento problemático
GROUP BY 
    deposit_type
ORDER BY 
    total_reservas DESC;


-- =======================================================
-- 3. IMPACTO FINANCIERO (ADR - AVERAGE DAILY RATE)
-- =======================================================
-- Hipótesis: Las cancelaciones afectan más a las reservas de alto valor.
-- Resultado: El ADR de reservas canceladas es mayor ($104.97) que el de las efectivas ($99.99).

SELECT 
    CASE 
        WHEN is_canceled = 0 THEN '01. Reservas Efectivas'
        ELSE '02. Reservas Canceladas'
    END AS estado_reserva,
    COUNT(*) AS cantidad,
    ROUND(AVG(adr), 2) AS precio_promedio_noche,
    ROUND(SUM(adr), 2) AS monto_total_adr -- Representa el "Revenue at Risk"
FROM 
    `hotel-booking-demand-482821.hotel_data.hotel_bookings`
GROUP BY 
    estado_reserva
ORDER BY 
    estado_reserva;