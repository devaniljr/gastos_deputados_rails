module CsvManager
  class ExtractDataService < ApplicationService
    require 'csv'

    def initialize(file)
      @file = file
    end

    def call
      required_headers = ["txNomeParlamentar", "ideCadastro", "nuLegislatura", "sgUF", "sgPartido", "numSubCota", "txtDescricao",
        "txtFornecedor", "txtCNPJCPF", "datEmissao", "vlrLiquido", "urlDocumento"]
      uf = 'RO'

      CSV::Converters[:blank_to_nil] = lambda do |field|
        field && field.empty? ? nil : field
      end

      data = []

      puts "Extracting data from designated UF..."
      CSV.foreach(@file, headers: true, col_sep: ';', encoding: "bom|utf-8", converters: [:all, :blank_to_nil]) do |row|
        data << Hash[row.headers.zip(row.fields)] if row['sgUF'] == uf
      end

      # use in rails: data.extract!(*required_headers)
      data.each { |hash| hash.keep_if { |k, _| required_headers.include? k } }
    end
  end
end
