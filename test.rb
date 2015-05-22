require 'json'

require_relative 'app/models/statement'
require_relative 'app/models/parameter'

json = "{\"statement\": {\"parameters\": [{\"type\": \"varchar\", \"evaluated\": false, \"name\": \"situacao\", \"value\": \"LOC Locado\"}, {\"type\": \"timestamp\", \"evaluated\": false, \"name\": \"inicio\", \"value\": \"2015-04-04 00:00:00\"}, {\"type\": \"timestamp\", \"evaluated\": false, \"name\": \"fim\", \"value\": \"2015-05-04 00:00:00\"} ], \"sql\": \"SELECT\\n--descricao do grupo de produto\\ngrp.descricao1 AS grupo,\\n\\tSUM(itm.valor) as total\\nFROM\\n {OJ \\n\\t\\t(\\n (\\n zw14vpei itm \\n JOIN \\n zw14vped ped \\n ON \\n {FN TIMESTAMPADD (SQL_TSI_DAY, ped.dataemiss-72687, {D '2000-01-01'})} BETWEEN :inicio AND :fim \\n AND ped.situacao = :situacao \\n AND itm.codtipoitem = 1 \\n AND ped.numeropedido = itm.numeropedido\\n ) JOIN \\n zw14ppro pro \\n ON \\n pro.tipoclasse = 'I'\\n AND pro.classe IS NOT NULL\\n AND {FN SUBSTRING(pro.classe,1,3)} = '453'\\n AND itm.codigo = pro.codproduto\\n\\t\\t) JOIN \\n zw14ppro grp \\n ON \\n grp.tipoclasse = 'G' \\n AND grp.classe = '453'\\n AND grp.ordemclasse = {FN CONVERT({FN SUBSTRING(pro.classe,4,3)},SQL_INTEGER)}\\n }\\nGROUP BY \\n grp.codproduto,\\n\\tgrp.descricao1\"} }"
data = JSON.parse(json, symbolize_names: true)

s = Statement.new data[:statement]
s.prepare
puts s.sql
