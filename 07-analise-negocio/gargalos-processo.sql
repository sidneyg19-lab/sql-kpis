-- Análise de Gargalos de Processo
-- Identifica etapas que apresentam maior tempo médio de processamento

SELECT
    etapa,
    COUNT(*) AS total_processos,
    ROUND(AVG(DATEDIFF(data_fim, data_inicio)), 2) AS tempo_medio_dias,
    MAX(DATEDIFF(data_fim, data_inicio)) AS maior_tempo_dias
FROM processos
WHERE data_inicio IS NOT NULL
  AND data_fim IS NOT NULL
GROUP BY etapa
ORDER BY tempo_medio_dias DESC;
