-- macros/test_has_max_one_row.sql

{% test test_has_max_one_row(model) %}

{#-
    Documentação:
    Este teste genérico verifica se o modelo tem no máximo uma linha.
    Ele falha (com um aviso) se a contagem de linhas for maior que 1.

    Lógica: Passa se a contagem for 0 ou 1. Falha se for 2 ou mais.
-#}

    {{ config(
        severity = 'warn'
    ) }}

    {#-
      A consulta a seguir retorna uma linha de "falha" somente se
      a contagem de registros no modelo for maior que 1.
    -#}
    select count(*) as validation_errors
    from {{ model }}
    having count(*) > 1

{% endtest %}