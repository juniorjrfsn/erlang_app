-module(interactive_text_classifier).
-export([main/0, train_and_save_model/0, interactive_mode/0]).

% Função principal
main() ->
    % Opção para treinar o modelo ou entrar no modo interativo
    io:format("Escolha uma opção:~n"),
    io:format("1 - Treinar o modelo~n"),
    io:format("2 - Modo interativo~n"),
    Option = io:get_line("Opção: "),
    case string:trim(Option) of
        "1" -> train_and_save_model();
        "2" -> interactive_mode();
        _   -> io:format("Opção inválida.~n")
    end.

% Treinar o modelo e salvar os pesos e bias
train_and_save_model() ->
    % Texto original
    TextData = [
        "A vida é uma aventura, aproveite cada instante.",
        "O amor é a força que nos move.",
        "A natureza é a nossa casa, vamos preservá-la.",
        "A educação é a chave para o futuro.",
        "A tecnologia nos conecta, mas não nos define.",
        "A arte nos inspira, nos faz sonhar.",
        "A música nos alegra, nos emociona.",
        "O esporte nos diverte, nos ensina a competir.",
        "A amizade é um tesouro, um presente.",
        "A família é a base de tudo, o nosso porto seguro."
    ],
    
    % Rótulos esperados (exemplo: classificação binária)
    Labels = [1, 0, 1, 0, 1, 0, 1, 0, 1, 0], % 1 = positivo, 0 = negativo

    % Pré-processamento dos dados
    {EncodedData, Vocabulary} = preprocess_text(TextData),

    % Determinar o tamanho máximo de uma frase (em número de palavras)
    MaxWordsPerSentence = lists:max([length(Frase) || Frase <- EncodedData]),

    % Padronizar o tamanho das frases
    StandardizedData = [pad_sentence(Row, MaxWordsPerSentence, length(Vocabulary)) || Row <- EncodedData],

    % Dividir os dados em treino e teste
    {TrainingData, TrainingLabels, _, _} = split_data(StandardizedData, Labels, 1.0),

    % Verificar consistência dos dados
    InputSize = length(hd(TrainingData)),
    io:format("Tamanho do vetor de entrada: ~p~n", [InputSize]),

    % Inicializar pesos e bias
    Weights = init_weights(InputSize),
    Bias = 0.5,

    % Taxa de aprendizado e épocas
    LearningRate = 0.1,
    Epochs = 100,

    % Treinar o modelo
    {FinalWeights, FinalBias} = train_model(TrainingData, TrainingLabels, Weights, Bias, LearningRate, Epochs),

    % Salvar os pesos e bias em formato binário
    file:write_file("model_weights.bin", term_to_binary(FinalWeights)),
    file:write_file("model_bias.bin", term_to_binary(FinalBias)),

    % Salvar o vocabulário e o tamanho máximo de palavras
    file:write_file("vocabulary.txt", io_lib:format("~p.~n", [Vocabulary])),
    file:write_file("max_words_per_sentence.txt", io_lib:format("~p.~n", [MaxWordsPerSentence])),

    io:format("Modelo treinado e salvo com sucesso!~n").

% Modo interativo
interactive_mode() ->
    % Verificar se os arquivos existem
    case {filelib:is_file("model_weights.bin"), filelib:is_file("model_bias.bin"),
          filelib:is_file("vocabulary.txt"), filelib:is_file("max_words_per_sentence.txt")} of
        {true, true, true, true} ->
            % Carregar os pesos e bias salvos
            {ok, WeightsData} = file:read_file("model_weights.bin"),
            {ok, BiasData} = file:read_file("model_bias.bin"),
            Weights = binary_to_term(WeightsData),
            Bias = binary_to_term(BiasData),

            % Carregar o vocabulário e o tamanho máximo de palavras
            {ok, VocabularyData} = file:read_file("vocabulary.txt"),
            {ok, MaxWordsData} = file:read_file("max_words_per_sentence.txt"),
            Vocabulary = binary_to_term(list_to_binary(string:trim(binary_to_list(VocabularyData)))),
            MaxWordsPerSentence = binary_to_term(list_to_binary(string:trim(binary_to_list(MaxWordsData)))),

            % Entrada do usuário
            io:format("Digite uma frase (ou 'sair' para encerrar):~n"),
            UserInput = io:get_line("Frase: "),
            case string:trim(UserInput) of
                "sair" -> io:format("Encerrando...~n");
                _ ->
                    % Pré-processar a entrada do usuário
                    {EncodedInput, _} = preprocess_text([UserInput]),
                    StandardizedInput = pad_sentence(hd(EncodedInput), MaxWordsPerSentence, length(Vocabulary)),

                    % Fazer previsão
                    Prediction = forward_propagation(StandardizedInput, Weights, Bias),
                    RoundedPrediction = round(Prediction),

                    % Exibir resultado
                    Response = if RoundedPrediction == 1 -> "Positivo"; true -> "Negativo" end,
                    io:format("Resposta: ~p~n", [Response]),

                    % Continuar no modo interativo
                    interactive_mode()
            end;
        _ ->
            io:format("Erro: Os arquivos de modelo não foram encontrados. Treine o modelo primeiro.~n")
    end.

% Pré-processamento do texto
preprocess_text(TextData) ->
    % Tokenizar o texto
    TokenizedData = [string:tokens(Frase, " ,.") || Frase <- TextData],
    
    % Construir vocabulário
    Vocabulary = lists:usort(lists:flatten(TokenizedData)),

    % Codificar os dados usando one-hot encoding
    OneHotEncode = fun(Word) ->
        [if V == Word -> 1; true -> 0 end || V <- Vocabulary]
    end,
    EncodedData = [[OneHotEncode(Word) || Word <- Frase] || Frase <- TokenizedData],

    {EncodedData, Vocabulary}.

% Padronizar o tamanho das frases
pad_sentence(Sentence, MaxWords, WordSize) ->
    CurrentSize = length(Sentence),
    case CurrentSize of
        MaxWords ->
            lists:flatten(Sentence);
        _ when CurrentSize < MaxWords ->
            Padding = lists:duplicate((MaxWords - CurrentSize) * WordSize, 0),
            lists:flatten(Sentence) ++ Padding;
        _ ->
            error({sentence_too_large, CurrentSize})
    end.

% Dividir os dados em treino e teste
split_data(Data, Labels, TrainRatio) ->
    Total = length(Data),
    TrainSize = round(Total * TrainRatio),
    {TrainData, TestData} = lists:split(TrainSize, Data),
    {TrainLabels, TestLabels} = lists:split(TrainSize, Labels),
    {TrainData, TrainLabels, TestData, TestLabels}.

% Inicializar pesos aleatórios
init_weights(Size) ->
    [rand:uniform() - 0.5 || _ <- lists:seq(1, Size)].

% Função de ativação (Sigmoid)
sigmoid(X) ->
    1 / (1 + math:exp(-X)).

% Derivada da função de ativação (Sigmoid)
sigmoid_derivative(Y) ->
    Y * (1 - Y).

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
    train_model(TrainingData, Labels, NewWeights, NewBias, LearningRate, Epochs - 1).

% Propagação direta
forward_propagation(Inputs, Weights, Bias) ->
    case length(Inputs) == length(Weights) of
        true ->
            WeightedSum = lists:sum([X * W || {X, W} <- lists:zip(Inputs, Weights)]) + Bias,
            sigmoid(WeightedSum);
        false ->
            io:format("Erro: Tamanhos incompatíveis. Inputs: ~p, Weights: ~p~n", [length(Inputs), length(Weights)]),
            error(badarg)
    end.

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



%% erlc interactive_text_classifier.erl
%% erl -noshell -s interactive_text_classifier main -s init stop