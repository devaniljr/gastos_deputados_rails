class PopulateDatabaseJob < ApplicationJob
  queue_as :default

  def perform(file)
    data = CsvManager::ExtractDataService.call(file)

    data.each do |expense|
      deputy_exist = Deputy.exists?(number_deputy: expense["ideCadastro"])

      if deputy_exist
        deputy = Deputy.find_by(number_deputy: expense["ideCadastro"])

        Expense.create(
          type_of_expense: expense["numSubCota"],
          description: expense["txtDescricao"],
          date: expense["datEmissao"],
          provider_document: expense["txtCNPJCPF"],
          provider_name: expense["txtFornecedor"],
          value: expense["vlrLiquido"].to_d,
          document_url: expense["urlDocumento"],
          deputy: deputy
        )
      elsif !deputy_exist
        deputy = Deputy.create(
          number_deputy: expense["ideCadastro"],
          name: expense["txNomeParlamentar"],
          state: expense["sgUF"],
          party: expense["sgPartido"],
          legislature: expense["nuLegislatura"]
        )

        Expense.create(
          type_of_expense: expense["numSubCota"],
          description: expense["txtDescricao"],
          date: expense["datEmissao"],
          provider_document: expense["txtCNPJCPF"],
          provider_name: expense["txtFornecedor"],
          value: expense["vlrLiquido"].to_d,
          document_url: expense["urlDocumento"],
          deputy: deputy
        )
      end
    end
  end
end
