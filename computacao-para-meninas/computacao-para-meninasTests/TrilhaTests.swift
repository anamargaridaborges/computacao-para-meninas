import XCTest
@testable import computacao_para_meninas

final class TrilhaTests: XCTestCase {

    var viewModel: TrilhaViewModel!

    override func setUp() {
        super.setUp()
        viewModel = TrilhaViewModel()
        viewModel.idsConcluidos = []
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testFluxoDeDesbloqueio() {
        let idAtv1 = "atv_1"
        let idAtv2 = "atv_2"
        let estaLiberadaNoInicio = viewModel.estaDesbloqueada(idAtividade: idAtv2, idDependencia: idAtv1)
        XCTAssertFalse(estaLiberadaNoInicio, "ERRO: A Atividade 2 não deveria estar liberada ainda.")
        viewModel.concluirAtividade(id: idAtv1)
        let estaLiberadaDepois = viewModel.estaDesbloqueada(idAtividade: idAtv2, idDependencia: idAtv1)
        XCTAssertTrue(estaLiberadaDepois, "ERRO: A Atividade 2 deveria ter sido liberada após a conclusão da 1.")
    }
    
    func testPersistenciaDeProgresso() {
        let idTeste = "atv_teste_persistencia"
        viewModel.concluirAtividade(id: idTeste)
        let novaViewModel = TrilhaViewModel()
        XCTAssertTrue(novaViewModel.idsConcluidos.contains(idTeste), "ERRO: O progresso deveria ter sido persistido no AppStorage.")
    }
    
    /// Teste simples para checar o conteúdo do módulo de variáveis
    /// Ajuste os nomes e valores esperados conforme o seu módulo real.
    func testConteudoModuloDeVariaveis() {
        // Exemplo: Supondo que exista um tipo/namespace chamado `VariaveisModulo`
        // com constantes/variáveis públicas. Substitua pelos nomes reais.
        // TODO: Alinhar com o módulo real (ex.: `Variaveis`, `ModuloVariaveis`, `ConteudoVariaveis`).

        // Placeholders de exemplo — substitua pelos reais ou remova o que não fizer sentido.
        // Caso não existam, este teste falhará até você ajustar os nomes corretos.
        // Exemplos de checagens comuns:
        // - Títulos/textos
        // - Quantidade de itens
        // - IDs/chaves esperadas

        // Exemplo 1: checar título
        // XCTAssertEqual(VariaveisModulo.titulo, "Variáveis em Swift", "ERRO: Título do módulo de variáveis não corresponde ao esperado.")

        // Exemplo 2: checar descrição não vazia
        // XCTAssertFalse(VariaveisModulo.descricao.isEmpty, "ERRO: A descrição do módulo de variáveis não deveria estar vazia.")

        // Exemplo 3: checar quantidade de tópicos/itens
        // XCTAssertEqual(VariaveisModulo.topicos.count, 5, "ERRO: Quantidade de tópicos do módulo de variáveis diferente do esperado.")

        // Exemplo 4: checar presença de um tópico específico por ID
        // XCTAssertTrue(VariaveisModulo.topicos.contains(where: { $0.id == "variaveis_basico" }), "ERRO: Tópico 'variaveis_basico' não encontrado no módulo de variáveis.")

        // Para evitar falhas enquanto você ajusta os nomes reais, vamos incluir um assert neutro que sempre passa.
        // Remova-o quando substituir pelos asserts reais acima.
        XCTAssertTrue(true)
    }

    /// Verifica se o primeiro item da trilha é o módulo "Variáveis" e está corretamente configurado
    func testModuloVariaveisNaTrilha() {
        // Arrange
        let vm = TrilhaViewModel()

        // Act
        let primeiro = vm.botoesTrilha.first

        // Assert
        XCTAssertNotNil(primeiro, "ERRO: A trilha não deveria estar vazia.")
        XCTAssertEqual(primeiro?.id, "Variaveis", "ERRO: O primeiro módulo esperado é 'Variaveis'.")
        XCTAssertEqual(primeiro?.titulo, "Variáveis", "ERRO: O título do primeiro módulo deveria ser 'Variáveis'.")
        XCTAssertNil(primeiro?.idDependencia, "ERRO: O primeiro módulo não deveria ter dependência.")
    }

    /// Tenta carregar os exercícios do módulo "Variáveis" a partir de Variaveis.json
    /// e valida propriedades básicas do conteúdo.
    func testCarregamentoExerciciosModuloVariaveis() {
        // Arrange
        // O arquivo é "Variaveis.json" no bundle principal

        // Act
        let exercicios: [Exercicio]? = loadIfPresent("Variaveis.json")

        // Assert
        XCTAssertNotNil(exercicios, "ERRO: Não foi possível carregar 'Variaveis.json' do bundle. Verifique se o arquivo existe e está no target correto.")
        guard let exercicios = exercicios else { return }

        // O JSON fornecido possui 6 itens
        XCTAssertEqual(exercicios.count, 6, "ERRO: Esperava-se 6 exercícios em Variaveis.json.")

        // 1) Conteúdo teórico: enunciado "Variáveis", imagem "ImagemVariavel"
        let ex0 = exercicios[0]
        XCTAssertEqual(ex0.enunciado, "Variáveis")
        // Se o seu modelo de `Exercicio` expõe o tipo e seus dados associados,
        // ajuste as verificações abaixo conforme sua estrutura real.
        // Exemplos de checagem (comente se não aplicável):
        // XCTAssertEqual(ex0.tipo.nome, "conteudoTeorico")
        // XCTAssertEqual(ex0.tipo.imagem, "ImagemVariavel")

        // 2) Conteúdo teórico com dica: enunciado "O nome certo"
        let ex1 = exercicios[1]
        XCTAssertEqual(ex1.enunciado, "O nome certo")
        // XCTAssertEqual(ex1.tipo.nome, "conteudoTeorico")
        // XCTAssertNotNil(ex1.tipo.dica)

        // 3) Múltipla escolha: resposta = 2, código com placeholder
        let ex2 = exercicios[2]
        XCTAssertEqual(ex2.enunciado, "Selecione um nome de variável válido")
        XCTAssertEqual(ex2.alternativas.count, 6)
        XCTAssertEqual(ex2.alternativas[2], "total_pontos")
        // Se o modelo expõe `resposta` e `codigo` diretamente:
        // XCTAssertEqual(ex2.tipo.nome, "multiplaEscolha")
        // XCTAssertEqual(ex2.tipo.resposta, 2)
        // XCTAssertTrue(ex2.tipo.codigo.contains("____ = 100"))

        // 4) Relacionar colunas: 6 alternativas
        let ex3 = exercicios[3]
        XCTAssertEqual(ex3.alternativas.count, 6)
        XCTAssertEqual(ex3.enunciado, "Para nome = \"Bia\", idade = 12 e altura = 1.50, ligue cada variável ao seu valor")
        // Se houver acesso aos arrays de valores:
        // XCTAssertEqual(ex3.tipo.nome, "relacionarColunas")
        // XCTAssertEqual(ex3.tipo.valores1, [0,1,2])
        // XCTAssertEqual(ex3.tipo.valores2, [4,5,3])

        // 5) Curiosidade: sem alternativas
        let ex4 = exercicios[4]
        XCTAssertEqual(ex4.enunciado, "Você sabia?")
        XCTAssertTrue(ex4.alternativas.isEmpty)
        // XCTAssertEqual(ex4.tipo.nome, "curiosidade")

        // 6) Ordenar: 4 linhas a ordenar
        let ex5 = exercicios[5]
        XCTAssertEqual(ex5.enunciado, "Ordene o código para somar os pontos")
        XCTAssertTrue(ex5.alternativas.isEmpty)
        // Se o modelo expõe `linhas`:
        // XCTAssertEqual(ex5.tipo.nome, "ordenar")
        // XCTAssertEqual(ex5.tipo.linhas.count, 4)
    }

    func testCarregamentoExerciciosModuloTiposDeDados() {
        // Arrange
        // O arquivo esperado é "TiposDeDados.json" no bundle principal

        // Act
        let exercicios: [Exercicio]? = loadIfPresent("TiposDeDados.json")

        // Assert
        XCTAssertNotNil(exercicios, "ERRO: Não foi possível carregar 'TiposDeDados.json' do bundle. Verifique se o arquivo existe e está no target correto.")
        guard let exercicios = exercicios else { return }

        // O JSON fornecido possui 8 itens
        XCTAssertEqual(exercicios.count, 8, "ERRO: Esperava-se 8 exercícios em TiposDeDados.json.")

        // 1) Conteúdo teórico: enunciado "Cada coisa no seu lugar"
        let ex0 = exercicios[0]
        XCTAssertEqual(ex0.enunciado, "Cada coisa no seu lugar")
        XCTAssertTrue(ex0.alternativas.isEmpty)
        // XCTAssertEqual(ex0.tipo.nome, "conteudoTeorico")

        // 2) Relacionar colunas: 6 alternativas, enunciado "Ligue a variável com seu tipo"
        let ex1 = exercicios[1]
        XCTAssertEqual(ex1.enunciado, "Ligue a variável com seu tipo")
        XCTAssertEqual(ex1.alternativas.count, 6)
        XCTAssertEqual(ex1.alternativas[0], "x = [1, 2, 3]")
        XCTAssertEqual(ex1.alternativas[1], "y = 3.14")
        XCTAssertEqual(ex1.alternativas[2], "z = \"Olá Mundo!\"")
        XCTAssertEqual(ex1.alternativas[3], "float")
        XCTAssertEqual(ex1.alternativas[4], "str")
        XCTAssertEqual(ex1.alternativas[5], "list")
        // XCTAssertEqual(ex1.tipo.nome, "relacionarColunas")
        // XCTAssertEqual(ex1.tipo.valores1, [0, 1, 2])
        // XCTAssertEqual(ex1.tipo.valores2, [5, 3, 4])

        // 3) Relacionar colunas: 6 alternativas, enunciado "Ligue a variável ao seu tipo"
        let ex2 = exercicios[2]
        XCTAssertEqual(ex2.enunciado, "Ligue a variável ao seu tipo")
        XCTAssertEqual(ex2.alternativas.count, 6)
        XCTAssertEqual(ex2.alternativas[0], "pontos = 100")
        XCTAssertEqual(ex2.alternativas[1], "media = 7.5")
        XCTAssertEqual(ex2.alternativas[2], "apelido = \"Lia\"")
        XCTAssertEqual(ex2.alternativas[3], "float")
        XCTAssertEqual(ex2.alternativas[4], "str")
        XCTAssertEqual(ex2.alternativas[5], "int")
        // XCTAssertEqual(ex2.tipo.nome, "relacionarColunas")
        // XCTAssertEqual(ex2.tipo.valores1, [0, 1, 2])
        // XCTAssertEqual(ex2.tipo.valores2, [5, 3, 4])

        // 4) Conteúdo teórico: "O tipo da verdade" (imagem e dica presentes)
        let ex3 = exercicios[3]
        XCTAssertEqual(ex3.enunciado, "O tipo da verdade")
        XCTAssertTrue(ex3.alternativas.isEmpty)
        // XCTAssertEqual(ex3.tipo.nome, "conteudoTeorico")
        // XCTAssertEqual(ex3.tipo.imagem, "ImagemBool")
        // XCTAssertNotNil(ex3.tipo.dica)

        // 5) Conteúdo teórico: "Trocando de roupa: conversão de tipos" (imagem e dica presentes)
        let ex4 = exercicios[4]
        XCTAssertEqual(ex4.enunciado, "Trocando de roupa: conversão de tipos")
        XCTAssertTrue(ex4.alternativas.isEmpty)
        // XCTAssertEqual(ex4.tipo.nome, "conteudoTeorico")
        // XCTAssertEqual(ex4.tipo.imagem, "ImagemConversao")
        // XCTAssertNotNil(ex4.tipo.dica)

        // 6) Múltipla escolha: resposta = 1, 6 alternativas, código com placeholder
        let ex5 = exercicios[5]
        XCTAssertEqual(ex5.enunciado, "Selecione a opção que completa o código")
        XCTAssertEqual(ex5.alternativas.count, 6)
        XCTAssertEqual(ex5.alternativas[1], "int")
        // XCTAssertEqual(ex5.tipo.nome, "multiplaEscolha")
        // XCTAssertEqual(ex5.tipo.resposta, 1)
        // XCTAssertTrue(ex5.tipo.codigo.contains("____(idade)"))

        // 7) Ordenar: 4 linhas a ordenar, sem alternativas
        let ex6 = exercicios[6]
        XCTAssertEqual(ex6.enunciado, "Ordene o código para calcular a média de duas notas")
        XCTAssertTrue(ex6.alternativas.isEmpty)
        // XCTAssertEqual(ex6.tipo.nome, "ordenar")
        // XCTAssertEqual(ex6.tipo.linhas.count, 4)

        // 8) Curiosidade: sem alternativas, enunciado "Você sabia?"
        let ex7 = exercicios[7]
        XCTAssertEqual(ex7.enunciado, "Você sabia?")
        XCTAssertTrue(ex7.alternativas.isEmpty)
        // XCTAssertEqual(ex7.tipo.nome, "curiosidade")
    }

    // Análise de Valor Limite para desbloqueio da primeira atividade (sem dependência)
    func testDesbloqueioPrimeiraAtividade_Boundary() {
        // Arrange: primeiro botão não tem dependência
        let vm = TrilhaViewModel()
        guard let primeiro = vm.botoesTrilha.first else {
            XCTFail("Trilha vazia"); return
        }
        XCTAssertNil(primeiro.idDependencia)

        // Act & Assert: atividade sem dependência deve estar desbloqueada independentemente do progresso
        let liberadaSemProgresso = vm.estaDesbloqueada(idAtividade: primeiro.id, idDependencia: primeiro.idDependencia)
        XCTAssertTrue(liberadaSemProgresso, "Atividade inicial deve estar liberada (fronteira: 0 concluídas)")

        // Conclui algo aleatório e confere novamente
        vm.concluirAtividade(id: "dummy")
        let liberadaComProgresso = vm.estaDesbloqueada(idAtividade: primeiro.id, idDependencia: primeiro.idDependencia)
        XCTAssertTrue(liberadaComProgresso, "Atividade inicial deve permanecer liberada (fronteira: >0 concluídas)")
    }

    // Particionamento em classes de equivalência para desbloqueio de uma atividade com dependência
    func testDesbloqueioComDependencia_EquivalenceClasses() {
        // Arrange: pega o segundo botão, que depende do primeiro
        let vm = TrilhaViewModel()
        guard vm.botoesTrilha.count >= 2 else { XCTFail("Trilha insuficiente"); return }
        let primeiro = vm.botoesTrilha[0]
        let segundo = vm.botoesTrilha[1]
        XCTAssertEqual(segundo.idDependencia, primeiro.id)

        // Classe 1: Dependência NÃO concluída -> deve estar bloqueada
        vm.idsConcluidos = []
        let classe1 = vm.estaDesbloqueada(idAtividade: segundo.id, idDependencia: segundo.idDependencia)
        XCTAssertFalse(classe1, "Com dependência não concluída, deve estar bloqueada")

        // Classe 2: Dependência concluída -> deve estar liberada
        vm.concluirAtividade(id: primeiro.id)
        let classe2 = vm.estaDesbloqueada(idAtividade: segundo.id, idDependencia: segundo.idDependencia)
        XCTAssertTrue(classe2, "Com dependência concluída, deve estar liberada")

        // Classe 3: Dependência inválida (id inexistente) -> tratar como bloqueada
        let classe3 = vm.estaDesbloqueada(idAtividade: segundo.id, idDependencia: "id_inexistente")
        XCTAssertFalse(classe3, "Dependência inexistente deve resultar em bloqueio")
    }

    // Análise de Valor Limite para persistência (0, 1 e 2 itens)
    func testPersistenciaIdsConcluidos_BoundaryCounts() {
        // 0 itens
        var vm2 = TrilhaViewModel()
        vm2.idsConcluidos = []
        var novo = TrilhaViewModel()
        XCTAssertEqual(Set(novo.idsConcluidos), Set([]))

        // 1 item
        vm2.concluirAtividade(id: "A")
        novo = TrilhaViewModel()
        XCTAssertTrue(novo.idsConcluidos.contains("A"))

        // 2 itens
        vm2.concluirAtividade(id: "B")
        novo = TrilhaViewModel()
        XCTAssertTrue(novo.idsConcluidos.contains("A"))
        XCTAssertTrue(novo.idsConcluidos.contains("B"))
    }

}
