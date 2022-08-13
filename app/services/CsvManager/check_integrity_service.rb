 module CsvManager
  class CheckIntegrityService < ApplicationService
    require 'csv'

    def initialize(file)
      @file = file
    end

    def call
      if File.extname(@file) == '.csv'
        headers = CSV.open(@file, 'r', col_sep: ';', &:first)
        required_headers = %w[txNomeParlamentar ideCadastro nuLegislatura sgUF sgPartido numSubCota txtDescricao
    txtFornecedor txtCNPJCPF datEmissao vlrLiquido urlDocumento]

        (headers & required_headers).sort == required_headers.sort
      else
        false
      end
    end
  end
end
