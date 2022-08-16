class ExpensesController < ApplicationController
  def index
    @deputies = Deputy.all.sort_by(&:sum_of_expenses).reverse
    @expenses = Expense.all
  end

  def show
    require 'uri'
    require 'net/http'

    @deputy = Deputy.find(params[:id])
    @expenses = @deputy.expenses.order("value desc").page(params[:page]).per(25)

    uri = URI("https://dadosabertos.camara.leg.br/api/v2/deputados/#{@deputy.number_deputy}")
    res = Net::HTTP.get_response(uri)
    @deputy_api = JSON.parse(res.body)["dados"]
  end

  def create
    @deputies = Deputy.all
  end

  def import
    begin
      file = params["/importar"]["csv"]
      file = file.tempfile.path

      if CsvManager::CheckIntegrityService.call(file)
        Thread.new do
          PopulateDatabaseJob.perform_later(file)
        end
        redirect_to root_path
        flash[:notice] = "Os dados estão sendo processados..."
      else
        redirect_to importar_path
        flash[:alert] = "Este arquivo não é valido!"
      end
    rescue Errno::ENOENT
      redirect_to importar_path
      flash[:alert] = "Erro ao processar o arquivo, tente novamente com o mesmo arquivo!"
    end
  end

  def destroy
    Expense.destroy_all
    Deputy.destroy_all
    redirect_to importar_path
    flash[:notice] = "Os dados foram excluídos, agora você pode enviar um novo arquivo."
  end
end
