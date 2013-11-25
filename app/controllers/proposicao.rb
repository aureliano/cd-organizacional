ResPublica::App.controllers :proposicao do
  
  get :index do
    options = {:skip => skip_value, :limit => DataPage.default_page_size, :tags => get_tags_without_stopwords(params[:prop_tags])}
    @proposicoes, @total = Proposicao.search options
    
    render 'proposicao/index'
  end
  
  get :index, :with => :id do
    @proposicao = Proposicao.where(:_id => params[:id]).first
    redirect '/404' unless @proposicao
    @dados_prop = proposicao_dados_complementares @proposicao.id_cadastro
    @dados_votacoes = votacoes_proposicao @proposicao
    puts @dados_votacoes
    
    render 'proposicao/dados_proposicao'
  end
end
