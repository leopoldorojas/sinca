class ResultMatrix
  include ActiveModel::Model

  attr_accessor :dates, :indicators, :companies

  def results
    indicators.map do |indicator|
      date_results = dates.map do |date|
        indicator_base = Indicator.by_credit_company(companies).before_of(date).last_register_by_credit_company(date)
        
        result = Result.new
        result.tap do |r|
          r.average = indicator_base.average(indicator)
          r.sum = indicator_base.sum(indicator)
          r.count = indicator_base.count(indicator)

=begin
          # If average de porcentaje y es el indicador_3 (que va sobre el indicador_1) entonces:
          array_of_amount_by_percentage = []
          for_each indicator_base do | i |
            new_element = i.indicator_1 * i.indicator_3 / 100
            array_of_amount_by_percentage << new_element
          end

          sum_of_new_column = array_of_amount_by_percentage.sum
          total_indicator_1 = indicator_base.sum(indicator_1)
          r.average = 100 * sum_of_new_column / total_indicator_1

          # If indicador_4 seria igual que lo de arriba, solo que con indicador_4, pero manteniendo lo de indicador_1

          # If indicador_7 entonces seria igual que lo de arriba pero cambiando indicador_3 por indicador_7, y indicador_1 por indicador_5

          # If indicador_2, dado que es operated_by division
          r.average = indicator_base.sum(indicator_1) / indicator_base.sum(indicator_6)

          #ERGO:
          indicador_n is a percentage of indicador_m =>  indicador_n_directriz = percentage, indicador_m
          indicador_n is calculated of indicador_m operated_by indicador_q => indicador_n_directriz = operated_by, [indicador_m, indicador_q]

          OJO: Crea una nueva estructura en config con solo los indicators que tienen rule. Y los totals requeridos (sum) calcularlos antes para no hacerlo varias veces. Inclusive en el calculo sum normal de hasta arriba, podria utilizarse ese cache total, para tampoco volverlo a calcular
=end

        end
        
        { date: date, result: result }
      end

      { indicator: indicator, results: date_results }
    end
  end

end
