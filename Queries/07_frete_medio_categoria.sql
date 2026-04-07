select 
categoria,
avg (frete) as frete_medio
from vw_base_vendas
GROUP BY categoria
ORDER BY frete_medio DESC;