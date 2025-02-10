-module(mlp).
-export([main/0]).

% Inicializar pesos aleatórios
init_weights(Size) -> [rand:uniform() - 0.5 || _ <- lists:seq(1, Size)].

% Função de ativação (Sigmoid)
sigmoid(X) -> 1 / (1 + math:exp(-X)).

% Derivada da função de ativação (Sigmoid)
sigmoid_derivative(Y) -> Y * (1 - Y).

% Treinar o modelo
train_model(_, _, Weights, Bias, _, 0) ->
    io:format("Treinamento concluído. Pesos finais: ~p, Bias final: ~p~n", [Weights, Bias]),
    {Weights, Bias};

train_model(TrainingData, Labels, Weights, Bias, LearningRate, Epochs) ->
    % Forward propagation
    Predictions = [forward_propagation(Row, Weights, Bias) || Row <- TrainingData],
    % Calcular erros
    Errors = [Y - Pred || {Y, Pred} <- lists:zip(Labels, Predictions)],
    % Atualizar pesos e bias usando a derivada da função sigmoid
    {NewWeights, NewBias} = update_weights_and_bias(TrainingData, Errors, Predictions, Weights, Bias, LearningRate),
    % Próxima época
    train_model(TrainingData, Labels, NewWeights, NewBias, LearningRate, Epochs - 1)
.
% Propagação direta
forward_propagation(Inputs, Weights, Bias) ->
    WeightedSum = lists:sum([X * W || {X, W} <- lists:zip(Inputs, Weights)]) + Bias,
    sigmoid(WeightedSum)
.

% Atualizar pesos e bias
update_weights_and_bias(TrainingData, Errors, Predictions, Weights, Bias, LearningRate) ->
    % Calcular os deltas para os pesos
    DeltaWeights = [[LearningRate * Error * sigmoid_derivative(Pred) * X || X <- Row] || {Row, Error, Pred} <- lists:zip3(TrainingData, Errors, Predictions)],
    % Somar os deltas para cada peso
    SumDeltaWeights = lists:foldl(fun(List, Acc) -> [X + Y || {X, Y} <- lists:zip(Acc, List)] end, lists:duplicate(length(Weights), 0.0), DeltaWeights),
    % Atualizar pesos
    UpdatedWeights = [W + DeltaW || {W, DeltaW} <- lists:zip(Weights, SumDeltaWeights)],
    % Calcular o delta para o bias
    DeltaBias = LearningRate * lists:sum([Error * sigmoid_derivative(Pred) || {Error, Pred} <- lists:zip(Errors, Predictions)]),
    UpdatedBias = Bias + DeltaBias,
    {UpdatedWeights, UpdatedBias}.

% Testar o modelo
test_model(TestData, TestLabels, Weights, Bias) ->
    % Fazer previsões no conjunto de teste
    Predictions = [forward_propagation(Row, Weights, Bias) || Row <- TestData],
    % Arredondar as previsões para obter valores binários (0 ou 1)
    RoundedPredictions = [round(Pred) || Pred <- Predictions],
    % Comparar as previsões com os rótulos reais
    Results = [if Pred == Label -> "Correto"; true -> "Incorreto" end || {Pred, Label} <- lists:zip(RoundedPredictions, TestLabels)],
    % Exibir resultados
    io:format("Previsões: ~p~n", [RoundedPredictions]),
    io:format("Rótulos Reais: ~p~n", [TestLabels]),
    io:format("Resultados: ~p~n", [Results])
.



% Função principal para treinar e testar a MLP
main() ->
    % Definir os dados de treinamento (matriz 10x10)
    TrainingData = [
        [1, 0, 1, 0, 1, 0, 1, 0, 1, 0],
        [0, 1, 0, 1, 0, 1, 0, 1, 0, 1],
        [1, 1, 0, 0, 1, 1, 0, 0, 1, 1],
        [0, 0, 1, 1, 0, 0, 1, 1, 0, 0],
        [1, 0, 0, 1, 0, 0, 1, 0, 0, 1],
        [0, 1, 1, 0, 1, 1, 0, 1, 1, 0],
        [1, 1, 1, 0, 0, 0, 1, 1, 1, 0],
        [0, 0, 0, 1, 1, 1, 0, 0, 0, 1],
        [1, 0, 1, 1, 0, 1, 1, 0, 1, 1],
        [0, 1, 0, 0, 1, 0, 0, 1, 0, 0]
    ],
    % Rótulos esperados (saída binária)
    Labels = [1, 0, 1, 0, 1, 0, 1, 0, 1, 0],
    % Inicializar pesos e bias aleatoriamente
    Weights = init_weights(10),
    Bias = 0.5,
    % Taxa de aprendizado
    LearningRate = 0.1,
    % Número de épocas
    Epochs = 100,
    % Treinar o modelo
    {FinalWeights, FinalBias} = train_model(TrainingData, Labels, Weights, Bias, LearningRate, Epochs),
    

    % Definir os dados de teste (matriz 3x10)
    TestData = [
        [1, 0, 1, 0, 1, 0, 1, 0, 1, 0],  % Deve prever 1
        [0, 1, 0, 1, 0, 1, 0, 1, 0, 1],  % Deve prever 0
        [1, 1, 0, 0, 1, 1, 0, 0, 1, 1]   % Deve prever 1
    ],
    % Rótulos esperados para os dados de teste
    TestLabels = [1, 0, 1],
    % Testar o modelo
    test_model(TestData, TestLabels, FinalWeights, FinalBias)
.

%% erlc mlp.erl
%% erl -noshell -s mlp main -s init stop