{% macro user_segments(column, thresholds, labels) %}
    case
        {% for i in range(thresholds | length) %}
        when {{ column }} < {{ thresholds[i] }} then '{{ labels[i] }}'
        {% endfor %}
        else '{{ labels | last}}'
    end
{% endmacro %}