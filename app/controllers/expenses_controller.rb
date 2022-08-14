class ExpensesController < ApplicationController
  def index
    @deputies = Deputy.all.sort_by(&:sum_of_expenses).reverse
  end

  def show
    @deputy = Deputy.find(params[:id])
    @expenses = @deputy.expenses.order("value desc").page(params[:page]).per(25)
  end

  def create

  end

  def import
    file = params["/importar"]["csv"]
    file = file.tempfile.path

    if CsvManager::CheckIntegrityService.call(file)
      PopulateDatabaseJob.perform_later(file)
    else
      redirect_to root_path
      flash[:alert] = "Erro ao processar o arquivo"
    end
  end
end
